# Dotfiles Repository

Welcome to my personal configuration hub. This repository contains my setup for various tools and platforms, ensuring a consistent and productive environment across machines.

![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

---

## 📂 Repository Structure

| Folder | Status | Description |
| :--- | :--- | :--- |
| `vscode/` | ✅ Active | VS Code settings, keybindings, and extension list. |
| `shell/` | ✅ Active | Bash configurations (`.bashrc`) and aliases. |
| `nvim/` | 🚧 Planned | Neovim configurations and plugin setup. |
| `git/` | 🚧 Planned | Git configurations and global ignores. |
| `python/` | 🚧 Planned | Python environment and tool configurations. |

---

## 🛠️ Installation

To set up these dotfiles on a new machine, clone the repository and run the installation script:

```bash
git clone https://github.com/frankogenrwoth/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
chmod +x install.sh
./install.sh
```

> [!IMPORTANT]
> The installation script will attempt to symlink configurations and install VS Code extensions. It creates backups of existing files in `~/.local/share/dotfiles-backup-[timestamp]`.

---

## ✨ Features

- **VS Code**: Synchronized settings across VS Code, VSCodium, and Code-OSS.
- **Bash**: Customized prompt with Git branch integration and useful aliases (like `cls` for `clear`).
- **Safety First**: Automatic backups during installation to prevent data loss.

---

> [!TIP]
> **Pro-tip**: If you are looking for my `.env` file, it is safely tucked away in the `.gitignore` :) 🤫
