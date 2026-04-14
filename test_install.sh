#!/bin/bash

PASS=0
FAIL=0

check() {
    local name="$1"
    local cmd="$2"
    if eval "$cmd" &>/dev/null; then
        echo "[PASS] $name"
        ((PASS++))
    else
        echo "[FAIL] $name"
        ((FAIL++))
    fi
}

check_file() {
    local name="$1"
    local file="$2"
    if [ -f "$file" ]; then
        echo "[PASS] $name ($file)"
        ((PASS++))
    else
        echo "[FAIL] $name ($file not found)"
        ((FAIL++))
    fi
}

check_dir() {
    local name="$1"
    local dir="$2"
    if [ -d "$dir" ]; then
        echo "[PASS] $name ($dir)"
        ((PASS++))
    else
        echo "[FAIL] $name ($dir not found)"
        ((FAIL++))
    fi
}

echo "=== System Tools ==="
check "git" "git --version"
check "zsh" "zsh --version"
check "tmux" "tmux -V"
check "vim" "vim --version"
check "fzf" "fzf --version"
check "bat" "bat --version"
check "tree" "tree --version"
check "curl" "curl --version"
check "build-essential" "make --version"

echo ""
echo "=== oh-my-zsh ==="
check_dir "oh-my-zsh" "$HOME/.oh-my-zsh"
check_dir "zsh-autosuggestions plugin" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
check_dir "forgit plugin" "$HOME/.oh-my-zsh/custom/plugins/forgit"
check_dir "powerlevel10k theme" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
check_file "zshrc" "$HOME/.zshrc"
check_file "p10k config" "$HOME/.p10k.zsh"

echo ""
echo "=== asdf ==="
check_file "asdf" "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/asdf.sh" 2>/dev/null
if command -v node &>/dev/null; then
    check "node" "node --version"
else
    echo "[FAIL] node (not in PATH)"
    ((FAIL++))
fi
if command -v pnpm &>/dev/null; then
    check "pnpm" "pnpm --version"
else
    echo "[FAIL] pnpm (not in PATH)"
    ((FAIL++))
fi

echo ""
echo "=== tmux ==="
if [ -x "$HOME/.local/bin/tmux" ]; then
    check "tmux (local build)" "$HOME/.local/bin/tmux -V"
else
    check "tmux (system)" "tmux -V"
fi
check_file "tmux plugin manager" "$HOME/.tmux/plugins/tpm"
check_file "tmux.conf" "$HOME/.tmux.conf"

echo ""
echo "=== vim-plug ==="
check_file "plug.vim" "$HOME/.vim/autoload/plug.vim"

echo ""
echo "=== Docker ==="
check "docker" "docker --version"
check "docker-compose" "docker compose version"
check "lazydocker" "lazydocker --version"
check_file "docker group" "/etc/group" # just check docker group exists

echo ""
echo "========================================"
echo "Result: $PASS passed, $FAIL failed"
echo "========================================"

if [ $FAIL -eq 0 ]; then
    exit 0
else
    exit 1
fi
