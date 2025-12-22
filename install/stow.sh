#!/bin/bash
# Symlink dotfiles using stow

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

step "Linking dotfiles"

cd "$DOTFILES"

if stow . 2>/dev/null; then
    ok "Dotfiles linked"
    return 0 2>/dev/null || true
fi

# Handle conflicts by adopting existing files
warn "Conflicts detected, adopting existing files"
stow --adopt . 2>/dev/null || true
git checkout . 2>/dev/null || true
stow -R . 2>/dev/null || { err "Stow failed"; return 1 2>/dev/null || exit 1; }
ok "Dotfiles linked"
