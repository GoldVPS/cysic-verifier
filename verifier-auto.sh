#!/bin/bash

# === Terminal Colors ===
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'
BLUE_LINE="\e[38;5;220m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

# === Show Header ===
function show_header() {
    clear
    echo -e "\e[38;5;220m"
    echo " ██████╗  ██████╗ ██╗     ██████╗ ██╗   ██╗██████╗ ███████╗"
    echo "██╔════╝ ██╔═══██╗██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝"
    echo "██║  ███╗██║   ██║██║     ██║  ██║██║   ██║██████╔╝███████╗"
    echo "██║   ██║██║   ██║██║     ██║  ██║╚██╗ ██╔╝██╔═══╝ ╚════██║"
    echo "╚██████╔╝╚██████╔╝███████╗██████╔╝ ╚████╔╝ ██║     ███████║"
    echo " ╚═════╝  ╚═════╝ ╚══════╝╚═════╝   ╚═══╝  ╚═╝     ╚══════╝"
    echo -e "\e[0m"
    echo -e "🚀 \e[1;33mCysic Verifier Installer\e[0m - Powered by \e[1;33mGoldVPS Team\e[0m 🚀"
    echo -e "🌐 \e[4;33mhttps://goldvps.net\e[0m - Best VPS with Low Price"
    echo ""
}

# === Install and Run Node ===
function install_and_run() {
    clear
    show_header

    echo -e "${CYAN}1. 🔑 Import existing key file"
    echo -e "2. 🆕 Setup as new node${RESET}"
    read -p "Select option (1 or 2): " NODE_CHOICE

    if [[ "$NODE_CHOICE" == "1" ]]; then
        echo -e "${CYAN}→ Importing key mode selected${RESET}"
        git clone https://github.com/GoldVPS/cysic-verifier.git
        cd cysic-verifier || exit
        chmod +x setup.sh
        ./setup.sh build

        mkdir -p /root/.cysic/keys
        echo -e "${YELLOW}📥 Please upload your .key file to: /root/.cysic/keys/"
        echo -e "Example filename: 0x123abc.key"
        read -p "🔃 Press ENTER once the key file is uploaded to start the node..."

        ./setup.sh run

    elif [[ "$NODE_CHOICE" == "2" ]]; then
        echo -e "${CYAN}→ Setting up new node...${RESET}"
        git clone https://github.com/GoldVPS/cysic-verifier.git
        cd cysic-verifier || exit
        chmod +x setup.sh
        ./setup.sh build
        ./setup.sh run
        echo -e "${GREEN}🎉 Setup complete. Please backup the .key file generated in /root/.cysic/keys/${RESET}"
    else
        echo -e "${RED}❌ Invalid choice.${RESET}"
        sleep 2
    fi
}

# === Check Logs ===
function check_logs() {
    if screen -list | grep -q "cysic"; then
        echo -e "${YELLOW}Attaching to 'cysic' screen session...${RESET}"
        sleep 1
        screen -r cysic
    else
        echo -e "${RED}No screen session named 'cysic' found. Please run the setup first.${RESET}"
        sleep 2
    fi
}

# === Uninstall Script ===
function uninstall_all() {
    echo -e "${RED}⚠️ This will delete all Cysic verifier files and this installer. Proceed? (y/n)${RESET}"
    read -p "→ Confirm [y/n]: " CONFIRM

    if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
        echo -e "${YELLOW}Stopping and removing Cysic files...${RESET}"
        screen -S cysic -X quit 2>/dev/null
        rm -rf ~/cysic-verifier ~/setup_linux.sh ~/verifier-auto.sh
        echo -e "${GREEN}✅ Uninstallation complete.${RESET}"
        exit 0
    else
        echo -e "${CYAN}Uninstall cancelled.${RESET}"
        sleep 1
    fi
}

# === Main Menu ===
function main_menu() {
    while true; do
        show_header
        echo -e "${BLUE_LINE}"
        echo -e "${YELLOW}Select an option (1–4):${RESET}"
        echo -e "${BLUE_LINE}"
        echo -e "1. 🚀 Setup and Run Verifier"
        echo -e "2. 📄 View Logs"
        echo -e "3. ❌ Exit"
        echo -e "4. 🧹 Uninstall All"
        echo -e "${BLUE_LINE}"
        read -p "Select an option (1–4): " OPTION

        case $OPTION in
            1) install_and_run ;;
            2) check_logs ;;
            3) echo -e "${GREEN}Goodbye!${RESET}"; exit 0 ;;
            4) uninstall_all ;;
            *) echo -e "${RED}Invalid option. Please try again.${RESET}"; sleep 1 ;;
        esac
    done
}

main_menu
