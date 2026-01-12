# empty
#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="$HOME/.local/share/dotfiles-backup-$(date +%Y%m%dT%H%M%S)"

echo "Dotfiles directory: $DOTFILES_DIR"
echo "Config base: $XDG_CONFIG_HOME"

mkdir -p "$BACKUP_DIR"

link_file() {
	local src="$1"
	local dest="$2"

	if [ -e "$dest" ] || [ -L "$dest" ]; then
		# If already correctly linked, skip
		if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
			echo "Skipping; already linked: $dest -> $src"
			return
		fi
		echo "Backing up existing $dest -> $BACKUP_DIR"
		mkdir -p "$(dirname "$BACKUP_DIR/$dest")"
		mv "$dest" "$BACKUP_DIR/$(basename "$dest")"
	fi
	mkdir -p "$(dirname "$dest")"
	ln -s "$src" "$dest"
	echo "Linked $dest -> $src"
}

install_extensions() {
	local exfile="$1"
	local code_cmd="$2"
	if [ ! -f "$exfile" ]; then
		echo "No extensions file at $exfile"
		return
	fi
	echo "Installing extensions from $exfile using $code_cmd"
	while IFS= read -r ext; do
		ext="$(echo "$ext" | sed 's/^\s*//;s/\s*$//')"
		[ -z "$ext" ] && continue
		case "$ext" in
			\#*) continue ;;
		esac
		echo "-> Installing: $ext"
		"$code_cmd" --install-extension "$ext" || echo "Failed to install $ext (you can retry manually)"
	done < "$exfile"
}

echo "Targets: Code, VSCodium, Code - OSS"
declare -a TARGETS=(
	"$XDG_CONFIG_HOME/Code/User"
	"$XDG_CONFIG_HOME/VSCodium/User"
	"$XDG_CONFIG_HOME/Code - OSS/User"
)

FILES_TO_LINK=(
	"$DOTFILES_DIR/vscode/settings.json"
	"$DOTFILES_DIR/vscode/keybindings.json"
)

for target in "${TARGETS[@]}"; do
	# Normalize path with eval to expand spaces
	TARGET_DIR="$target"
	if [ -d "$TARGET_DIR" ] || mkdir -p "$TARGET_DIR" 2>/dev/null; then
		echo "Preparing target: $TARGET_DIR"
		for src in "${FILES_TO_LINK[@]}"; do
			if [ -f "$src" ]; then
				dest="$TARGET_DIR/$(basename "$src")"
				link_file "$src" "$dest"
			fi
		done
	else
		echo "Unable to prepare target: $TARGET_DIR"
	fi
done

# Find a code CLI to install extensions
CODE_CANDIDATES=(code code-insiders codium code-oss)
CODE_CMD=""
for c in "${CODE_CANDIDATES[@]}"; do
	if command -v "$c" >/dev/null 2>&1; then
		CODE_CMD="$c"
		break
	fi
done

EXT_FILE="$DOTFILES_DIR/vscode/extensions.txt"
if [ -n "$CODE_CMD" ]; then
	install_extensions "$EXT_FILE" "$CODE_CMD"
else
	echo "No 'code' CLI found (tried: ${CODE_CANDIDATES[*]}). Skipping extension install."
	echo "To install extensions later, run: code --install-extension <extension-id>"
fi

echo "Done. Backups (if any) are in $BACKUP_DIR"

