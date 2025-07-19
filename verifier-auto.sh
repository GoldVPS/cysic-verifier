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
    echo -e "${CYAN}Enter your reward address (e.g., 0xabc123...)${RESET}"
    read -p "→ Reward Address: " REWARD_ADDRESS

    if [[ -z "$REWARD_ADDRESS" ]]; then
        echo -e "${RED}Reward address cannot be empty.${RESET}"
        sleep 2
        return
    fi

    echo -e "${YELLOW}Downloading and executing setup...${RESET}"
    sleep 1

    # Run in screen
    screen -S cysic -dm bash -c "
        curl -L https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/setup_linux.sh > ~/setup_linux.sh && \
        bash ~/setup_linux.sh $REWARD_ADDRESS && \
        cd ~/cysic-verifier && bash start.sh
    "

    echo -e "${GREEN}✅ Setup is running inside a screen session named 'cysic'.${RESET}"
    sleep 2
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

# === Main Menu ===
function main_menu() {
    while true; do
        show_header
        echo -e "${BLUE_LINE}"
        echo -e "${YELLOW}Please choose an option:${RESET}"
        echo -e "${BLUE_LINE}"
        echo -e "1. 🚀 Setup and Run Verifier"
        echo -e "2. 📄 View Logs"
        echo -e "3. ❌ Exit"
        echo -e "${BLUE_LINE}"
        read -p "Your choice: " OPTION

        case $OPTION in
            1) install_and_run ;;
            2) check_logs ;;
            3) echo -e "${GREEN}Goodbye!${RESET}"; exit 0 ;;
            *) echo -e "${RED}Invalid option. Please try again.${RESET}"; sleep 1 ;;
        esac
    done
}

main_menu
