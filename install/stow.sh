#!/bin/bash
#|---/ /+---------------------+---/ /|#
#|--/ /-| Symphony Dotfiles   |--/ /-|#
#|-/ /--| Stow Symlinks       |-/ /--|#
#|/ /---+---------------------+/ /---|#

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

step "Linking dotfiles"
cd "$DOTFILES"

# Use stow dry-run to find conflicts, back them up, then stow for real
backup_conflicts() {
    local dry_run conflicts=()

    dry_run=$(stow -n -v . 2>&1)

    # Parse: "over existing target .config/foo/bar since neither..."
    while IFS= read -r line; do
        if [[ "$line" == *"existing target"* ]]; then
            local path=$(echo "$line" | sed -n 's/.*existing target \([^ ]*\) since.*/\1/p')
            [[ -n "$path" ]] && conflicts+=("$path")
        fi
    done <<< "$dry_run"

    [[ ${#conflicts[@]} -eq 0 ]] && return 0

    mkdir -p "$BACKUP_DIR"
    for item in "${conflicts[@]}"; do
        local target="$HOME/$item"
        [[ -e "$target" && ! -L "$target" ]] || continue
        mkdir -p "$BACKUP_DIR/$(dirname "$item")"
        mv "$target" "$BACKUP_DIR/$item"
        info "Backed up: $item"
    done

    info "Backups saved to: $BACKUP_DIR"
}

backup_conflicts

if ! stow -v .; then
    err "Failed to link dotfiles"
    info "Fix conflicts and retry: cd ~/dotfiles && stow ."
    exit 1
fi

ok "Dotfiles linked"
