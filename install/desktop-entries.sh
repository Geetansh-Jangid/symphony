#!/bin/bash
# Desktop apps setup (webapps, browser overrides, hidden entries)

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APPS_DIR="$DOTFILES/.local/share/applications"
TARGET_DIR="$HOME/.local/share/applications"

# ─────────────────────────────────────────────────────────────────────────────
# Browser Overrides (only install if browser is present)
# ─────────────────────────────────────────────────────────────────────────────

setup_browser_overrides() {
    mkdir -p "$TARGET_DIR"
    
    # brave-browser override
    if command -v brave &>/dev/null && [[ -f "$APPS_DIR/brave-browser.desktop" ]]; then
        cp "$APPS_DIR/brave-browser.desktop" "$TARGET_DIR/"
        ok "brave-browser override"
    fi
    
    # chromium override
    if command -v chromium &>/dev/null && [[ -f "$APPS_DIR/chromium.desktop" ]]; then
        cp "$APPS_DIR/chromium.desktop" "$TARGET_DIR/"
        ok "chromium override"
    fi
    
    return 0
}

# ─────────────────────────────────────────────────────────────────────────────
# Web Apps (personal, users choose which ones)
# ─────────────────────────────────────────────────────────────────────────────

ask_webapps() {
    command -v gum &>/dev/null || return 0

    # Collect webapp names (skip browser overrides and system entries)
    local webapps=()
    for file in "$APPS_DIR"/*.desktop; do
        [[ -f "$file" ]] || continue
        local name=$(basename "$file" .desktop)
        case "$name" in
            brave-browser|chromium|grub-customizer) continue ;;
        esac
        webapps+=("$name")
    done

    [[ ${#webapps[@]} -eq 0 ]] && return 0

    echo
    gum confirm "Install web apps?" || return 0

    step "Select web apps"
    local selected=$(printf '%s\n' "${webapps[@]}" | gum choose --no-limit --height 15)

    [[ -z "$selected" ]] && return 0

    mkdir -p "$TARGET_DIR"
    for app in $selected; do
        local src="$APPS_DIR/$app.desktop"
        local dst="$TARGET_DIR/$app.desktop"
        [[ "$src" -ef "$dst" ]] && { ok "$app (linked)"; continue; }
        cp "$src" "$dst"
        ok "$app"
    done
    return 0
}

# ─────────────────────────────────────────────────────────────────────────────
# Hidden Apps (hide unwanted entries from launcher)
# ─────────────────────────────────────────────────────────────────────────────

setup_hidden() {
    [[ -d "$APPS_DIR/hidden" ]] || return 0

    mkdir -p "$TARGET_DIR"
    local count=0

    for file in "$APPS_DIR/hidden"/*.desktop; do
        [[ -f "$file" ]] || continue
        local dst="$TARGET_DIR/$(basename "$file")"
        [[ "$file" -ef "$dst" ]] && continue
        cp "$file" "$dst"
        count=$((count + 1))
    done

    [[ $count -gt 0 ]] && ok "Hidden $count apps from launcher"
    return 0
}

# ─────────────────────────────────────────────────────────────────────────────
# Run
# ─────────────────────────────────────────────────────────────────────────────

setup_browser_overrides
ask_webapps
setup_hidden

# Refresh desktop database
command -v update-desktop-database &>/dev/null && update-desktop-database "$TARGET_DIR" 2>/dev/null
rm -f "$HOME/.cache/rofi3.druncache" 2>/dev/null
true  # ensure success exit code
