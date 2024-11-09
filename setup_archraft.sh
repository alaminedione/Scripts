#!/bin/bash

# Colors
GREEN='\033[1;32m'
BLUE='\033[1;34m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

echo -e "${BLUE}### Arch Linux Setup Script ###${NC}"

# Function to ask for user confirmation
confirm_action() {
    echo -ne "${YELLOW}$1 (y/n): ${NC}"
    read -r CONFIRM
    if [[ "$CONFIRM" =~ ^[Nn]$ ]]; then
        echo -e "${RED}Skipping...${NC}"
        return 1
    fi
    return 0
}

# Step 1: Update the system
if confirm_action "Do you want to update the system?"; then
    echo -e "${YELLOW}Updating the system...${NC}"
    sudo pacman -Syyu --noconfirm
    echo -e "${GREEN}System update completed.${NC}"
fi

# Step 2: Disable specified services
if confirm_action "Do you want to disable unnecessary services?"; then
    SERVICES=(
        "apparmor.service"
        "avahi-daemon.service"
        "avahi-daemon.socket"
        "NetworkManager-wait-online.service"
        "bluetooth.service"
        "pcscd.socket"
        "cloud-config.service"
        "cloud-final.service"
        "remote-fs.target"
        "cloud-init-local.service"
        "cups.path"
        "sshd.service"
        "cups.service"
        "cups.socket"
        "getty@.service"
        "hv_kvp_daemon.service"
        "hv_vss_daemon.service"
        "ufw.service"
        "ModemManager.service"
        "wpa_supplicant.service"
    )

    echo -e "${YELLOW}Disabling unnecessary services...${NC}"
    for SERVICE in "${SERVICES[@]}"; do
        echo -e "${BLUE}Disabling ${SERVICE}...${NC}"
        sudo systemctl disable --now $SERVICE 2>/dev/null
    done
    echo -e "${GREEN}Services disabled.${NC}"
fi

# Step 3: Install required packages
if confirm_action "Do you want to install packages?"; then
    PACKAGES=(
        "debugedit"
        "megasync-bin"
        "ungoogled-chromium-bin"
        "telegram-desktop"
        "redshift"
        "kitty"
        "obsidian"
        "zed"
        "freedownloadmanager"
        "tgpt"
        "yt-dlp"
        "zoxide"
        "asciinema"
        "bat"
        "cht.sh"
        "github-cli"
        "stow"
        "nodejs"
        "pnpm"
        "typescript"
        "php"
        "pip"
        "composer"
        "neovim"
        "npm"
        "eza"
        "mycli"
        "mariadb"
    )

    # Select packages to install
    echo -e "${YELLOW}Select packages to install (separate numbers with spaces, or enter 'all' to install everything):${NC}"
    for i in "${!PACKAGES[@]}"; do
        echo -e "${BLUE}[$i] ${PACKAGES[i]}${NC}"
    done

    echo -ne "${YELLOW}Enter selection: ${NC}"
    read -r SELECTION

    if [[ "$SELECTION" == "all" ]]; then
        SELECTED_PACKAGES=("${PACKAGES[@]}")
    else
        SELECTED_PACKAGES=()
        for index in $SELECTION; do
            SELECTED_PACKAGES+=("${PACKAGES[$index]}")
        done
    fi

    # Install selected packages
    echo -e "${YELLOW}Installing selected packages...${NC}"
    for PACKAGE in "${SELECTED_PACKAGES[@]}"; do
        echo -e "${BLUE}Installing ${PACKAGE}...${NC}"
        yay -S --needed --noconfirm $PACKAGE
    done

    echo -e "installe zsh plugins "
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

    echo -e "${GREEN}Package installation completed.${NC}"
fi

# Step 4: Set up BlackArch repository
if confirm_action "Do you want to set up the BlackArch repository?"; then
    echo -e "${YELLOW}Setting up BlackArch repository...${NC}"
    curl -O https://blackarch.org/strap.sh
    sudo chmod +x strap.sh &&
        sudo ./strap.sh &&
        rm strap.sh
    echo -e "${GREEN}BlackArch repository setup completed.${NC}"
    echo -e "${YELLOW}Updating the system with BlackArch repository...${NC}"
    sudo pacman -Syyu
fi
