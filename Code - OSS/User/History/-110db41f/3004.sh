#!/usr/bin/env bash
# ──────────────────────────────────────────────────────
# Config launcher via wofi → always opens in Neovim
# ──────────────────────────────────────────────────────

# 1) Force Neovim as the editor
CMD="nvim"

# 2) Pick a terminal emulator (you can reorder or add your own)
if   command -v alacritty &>/dev/null; then
  TERM_EMU="alacritty"
elif command -v kitty &>/dev/null; then
  TERM_EMU="kitty"
elif command -v xterm  &>/dev/null; then
  TERM_EMU="xterm"
else
  echo "Error: No supported terminal found (alacritty/kitty/xterm)" >&2
  exit 1
fi

# 3) Map friendly names → config files
declare -A cfg=(
  [hypr]    ="$HOME/.config/hypr/hyprland.conf"
  [fish]    ="$HOME/.config/fish/config.fish"
  [kitty]   ="$HOME/.config/kitty/kitty.conf"
  [alacritty]="$HOME/.config/alacritty/alacritty.yml"
  [nvim]    ="$HOME/.config/nvim/init.vim"
  [waybar]  ="$HOME/.config/waybar/config"
  [wofi]    ="$HOME/.config/wofi/config"
  [rofi]    ="$HOME/.config/rofi/config.rasi"
  [picom]   ="$HOME/.config/picom/picom.conf"
)

# 4) Let the user pick
choice=$(printf '%s\n' "${!cfg[@]}" \
         | wofi --show dmenu --prompt "Edit config:")

# 5) Bail if they cancelled
[[ -z "$choice" ]] && exit 0

file="${cfg[$choice]}"

# 6) Ensure the file really exists
if [[ ! -f "$file" ]]; then
  notify-send "Config Launcher" "❌ File not found: $file"
  exit 1
fi

# 7) Launch Neovim in the chosen terminal, then exit
"$TERM_EMU" -e "$CMD" "$file" &

exit 0
