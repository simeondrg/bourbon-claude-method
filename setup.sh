#!/bin/bash

# ============================================
# BOURBON CLAUDE METHOD - Installation
# ============================================
# Ce script installe tout ce dont tu as besoin
# pour créer des projets avec Claude Code.
# ============================================

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Emojis
CHECK="✅"
CROSS="❌"
ARROW="➜"
ROCKET="🚀"
PACKAGE="📦"
GEAR="⚙️"
SPARKLE="✨"

echo ""
echo -e "${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║                                                            ║${NC}"
echo -e "${PURPLE}║  ${ROCKET} ${CYAN}BOURBON CLAUDE METHOD${PURPLE}                               ║${NC}"
echo -e "${PURPLE}║     ${NC}Installation automatique${PURPLE}                             ║${NC}"
echo -e "${PURPLE}║                                                            ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Détecter l'OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        echo -e "${CHECK} Système détecté : ${GREEN}macOS${NC}"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        echo -e "${CHECK} Système détecté : ${GREEN}Linux${NC}"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ -n "$WINDIR" ]]; then
        OS="windows"
        echo -e "${CHECK} Système détecté : ${GREEN}Windows${NC}"
    else
        echo -e "${CROSS} Système non reconnu: $OSTYPE"
        exit 1
    fi
}

# Vérifier si une commande existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Installation de Node.js
install_node() {
    echo ""
    echo -e "${PACKAGE} ${BLUE}Vérification de Node.js...${NC}"

    if command_exists node; then
        NODE_VERSION=$(node -v)
        echo -e "${CHECK} Node.js est installé : ${GREEN}$NODE_VERSION${NC}"
    else
        echo -e "${YELLOW}${ARROW} Node.js n'est pas installé. Installation...${NC}"

        if [[ "$OS" == "macos" ]]; then
            if command_exists brew; then
                brew install node
            else
                echo -e "${YELLOW}Installation de Homebrew d'abord...${NC}"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                brew install node
            fi
        elif [[ "$OS" == "linux" ]]; then
            curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif [[ "$OS" == "windows" ]]; then
            echo -e "${YELLOW}Télécharge et installe Node.js depuis : https://nodejs.org${NC}"
            echo -e "${YELLOW}Puis relance ce script.${NC}"
            exit 1
        fi

        echo -e "${CHECK} Node.js installé : ${GREEN}$(node -v)${NC}"
    fi
}

# Installation de Git
install_git() {
    echo ""
    echo -e "${PACKAGE} ${BLUE}Vérification de Git...${NC}"

    if command_exists git; then
        GIT_VERSION=$(git --version)
        echo -e "${CHECK} Git est installé : ${GREEN}$GIT_VERSION${NC}"
    else
        echo -e "${YELLOW}${ARROW} Git n'est pas installé. Installation...${NC}"

        if [[ "$OS" == "macos" ]]; then
            xcode-select --install 2>/dev/null || brew install git
        elif [[ "$OS" == "linux" ]]; then
            sudo apt-get update && sudo apt-get install -y git
        elif [[ "$OS" == "windows" ]]; then
            echo -e "${YELLOW}Télécharge et installe Git depuis : https://git-scm.com${NC}"
            exit 1
        fi

        echo -e "${CHECK} Git installé"
    fi
}

# Installation de GitHub CLI
install_gh() {
    echo ""
    echo -e "${PACKAGE} ${BLUE}Vérification de GitHub CLI...${NC}"

    if command_exists gh; then
        echo -e "${CHECK} GitHub CLI est installé : ${GREEN}$(gh --version | head -n 1)${NC}"
    else
        echo -e "${YELLOW}${ARROW} GitHub CLI n'est pas installé. Installation...${NC}"

        if [[ "$OS" == "macos" ]]; then
            brew install gh
        elif [[ "$OS" == "linux" ]]; then
            type -p curl >/dev/null || sudo apt install curl -y
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
            sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
            sudo apt update
            sudo apt install gh -y
        fi

        echo -e "${CHECK} GitHub CLI installé"
    fi

    # Vérifier l'authentification
    if ! gh auth status >/dev/null 2>&1; then
        echo ""
        echo -e "${YELLOW}${ARROW} Tu dois te connecter à GitHub.${NC}"
        echo -e "${CYAN}Lance cette commande et suis les instructions :${NC}"
        echo ""
        echo -e "  ${GREEN}gh auth login${NC}"
        echo ""
    else
        echo -e "${CHECK} Connecté à GitHub"
    fi
}

# Installation de Claude Code
install_claude_code() {
    echo ""
    echo -e "${PACKAGE} ${BLUE}Vérification de Claude Code...${NC}"

    if command_exists claude; then
        CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "installé")
        echo -e "${CHECK} Claude Code est installé : ${GREEN}$CLAUDE_VERSION${NC}"
    else
        echo -e "${YELLOW}${ARROW} Claude Code n'est pas installé. Installation...${NC}"

        if [[ "$OS" == "macos" ]] || [[ "$OS" == "linux" ]]; then
            curl -fsSL https://claude.ai/install.sh | sh
        elif [[ "$OS" == "windows" ]]; then
            echo -e "${CYAN}Exécute cette commande dans PowerShell :${NC}"
            echo ""
            echo -e "  ${GREEN}irm https://claude.ai/install.ps1 | iex${NC}"
            echo ""
        fi

        echo -e "${CHECK} Claude Code installé"
    fi
}

# Configuration des commandes globales Bourbon
install_bourbon_commands() {
    echo ""
    echo -e "${GEAR} ${BLUE}Installation des commandes Bourbon...${NC}"

    CLAUDE_DIR="$HOME/.claude"
    COMMANDS_DIR="$CLAUDE_DIR/commands"

    # Créer le dossier si nécessaire
    mkdir -p "$COMMANDS_DIR"

    # Copier la commande /start (assistant de démarrage)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    if [[ -f "$SCRIPT_DIR/templates/commands/start.md" ]]; then
        cp "$SCRIPT_DIR/templates/commands/start.md" "$COMMANDS_DIR/start.md"
        echo -e "${CHECK} Commande ${GREEN}/start${NC} installée"
    fi

    if [[ -f "$SCRIPT_DIR/templates/commands/bourbon-init.md" ]]; then
        cp "$SCRIPT_DIR/templates/commands/bourbon-init.md" "$COMMANDS_DIR/bourbon-init.md"
        echo -e "${CHECK} Commande ${GREEN}/bourbon-init${NC} installée"
    fi

    if [[ -f "$SCRIPT_DIR/templates/commands/skills-install.md" ]]; then
        cp "$SCRIPT_DIR/templates/commands/skills-install.md" "$COMMANDS_DIR/skills-install.md"
        echo -e "${CHECK} Commande ${GREEN}/skills-install${NC} installée"
    fi

    echo -e "${CHECK} Commandes Bourbon installées dans ${CYAN}~/.claude/commands/${NC}"
}

# Installation des Skills de base (skills.sh)
install_core_skills() {
    echo ""
    echo -e "${PACKAGE} ${BLUE}Installation des Skills de base (skills.sh)...${NC}"

    # Vérifier si npx est disponible
    if ! command_exists npx; then
        echo -e "${YELLOW}${ARROW} npx non disponible, skills non installés${NC}"
        echo -e "${CYAN}Tu pourras les installer plus tard avec /skills-install${NC}"
        return
    fi

    echo -e "${CYAN}Installation du bundle CORE...${NC}"

    # Bundle CORE - toujours installé
    npx skills add vercel-labs/agent-skills 2>/dev/null && \
        echo -e "${CHECK} vercel-labs/agent-skills (react, web-design)" || \
        echo -e "${YELLOW}⚠ vercel-labs/agent-skills (à installer manuellement)${NC}"

    npx skills add anthropics/skills 2>/dev/null && \
        echo -e "${CHECK} anthropics/skills (frontend-design, pdf, xlsx...)" || \
        echo -e "${YELLOW}⚠ anthropics/skills (à installer manuellement)${NC}"

    npx skills add obra/superpowers 2>/dev/null && \
        echo -e "${CHECK} obra/superpowers (TDD, debugging, planning)" || \
        echo -e "${YELLOW}⚠ obra/superpowers (à installer manuellement)${NC}"

    echo ""
    echo -e "${CHECK} Skills CORE installés"
    echo -e "${CYAN}💡 Pour plus de skills : /skills-install [saas|mobile|marketing]${NC}"
}

# Vérification finale
final_check() {
    echo ""
    echo -e "${PURPLE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${SPARKLE} ${GREEN}INSTALLATION TERMINÉE !${NC}"
    echo -e "${PURPLE}════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${BLUE}Résumé :${NC}"
    echo ""

    if command_exists node; then
        echo -e "  ${CHECK} Node.js    : $(node -v)"
    else
        echo -e "  ${CROSS} Node.js    : non installé"
    fi

    if command_exists git; then
        echo -e "  ${CHECK} Git        : installé"
    else
        echo -e "  ${CROSS} Git        : non installé"
    fi

    if command_exists gh; then
        echo -e "  ${CHECK} GitHub CLI : installé"
    else
        echo -e "  ${CROSS} GitHub CLI : non installé"
    fi

    if command_exists claude; then
        echo -e "  ${CHECK} Claude Code: installé"
    else
        echo -e "  ${CROSS} Claude Code: non installé"
    fi

    # Vérifier skills installés
    if [[ -d "$HOME/.claude/skills" ]] && [[ "$(ls -A $HOME/.claude/skills 2>/dev/null)" ]]; then
        SKILLS_COUNT=$(ls -1 "$HOME/.claude/skills" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "  ${CHECK} Skills     : ${SKILLS_COUNT} bundles installés"
    else
        echo -e "  ${YELLOW}⚠${NC} Skills     : aucun (utilise /skills-install)"
    fi

    echo ""
    echo -e "${PURPLE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${ROCKET} ${CYAN}PROCHAINE ÉTAPE :${NC}"
    echo ""
    echo -e "  1. Crée un dossier pour ton projet :"
    echo -e "     ${GREEN}mkdir mon-projet && cd mon-projet${NC}"
    echo ""
    echo -e "  2. Lance Claude Code :"
    echo -e "     ${GREEN}claude${NC}"
    echo ""
    echo -e "  3. Tape la commande magique :"
    echo -e "     ${GREEN}/start${NC}"
    echo ""
    echo -e "  Claude va te guider pas à pas pour créer ton projet ! ${SPARKLE}"
    echo ""
}

# Exécution
main() {
    detect_os
    install_node
    install_git
    install_gh
    install_claude_code
    install_bourbon_commands
    install_core_skills
    final_check
}

main "$@"
