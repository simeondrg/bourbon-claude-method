#!/bin/bash
# Setup Overnight Compound Loop pour macOS
# Usage: ./setup-overnight.sh [project-path]

set -e

PROJECT_PATH="${1:-$(pwd)}"
PROJECT_NAME=$(basename "$PROJECT_PATH")

echo "🌙 Setup Overnight Compound Loop"
echo "================================"
echo "Project: $PROJECT_NAME"
echo "Path: $PROJECT_PATH"
echo ""

# Créer le dossier scripts si nécessaire
mkdir -p "$PROJECT_PATH/scripts/compound"
mkdir -p "$PROJECT_PATH/logs"
mkdir -p "$PROJECT_PATH/reports"

# Script de Compound Review (22h30)
cat > "$PROJECT_PATH/scripts/compound/daily-compound-review.sh" << 'SCRIPT'
#!/bin/bash
# Compound Review - Extrait les learnings de la journée
# Tourne à 22h30

set -e
cd "$(dirname "$0")/../.."

echo "[$(date)] Starting compound review..."

# S'assurer d'être sur main et à jour
git checkout main 2>/dev/null || true
git pull origin main 2>/dev/null || true

# Lancer Claude pour compound
claude -p "
Tu es en mode compound review.

1. Regarde les fichiers modifiés aujourd'hui (git log --since='24 hours ago')
2. Identifie les patterns et learnings
3. Mets à jour CLAUDE.md avec les nouvelles règles découvertes
4. Crée/update memory/learnings/$(date +%Y-%m-%d).md avec un résumé

Commit tes changements avec le message 'compound: daily review $(date +%Y-%m-%d)'
Push sur main.
" --dangerously-skip-permissions 2>&1 | tee -a logs/compound-review.log

echo "[$(date)] Compound review complete."
SCRIPT

# Script Auto-Compound Build (23h00)
cat > "$PROJECT_PATH/scripts/compound/auto-compound.sh" << 'SCRIPT'
#!/bin/bash
# Auto-Compound Build - Implémente la priorité #1
# Tourne à 23h00

set -e
cd "$(dirname "$0")/../.."

echo "[$(date)] Starting auto-compound build..."

# Récupérer les derniers learnings
git fetch origin main
git reset --hard origin/main

# Vérifier s'il y a un fichier de priorités
if [ ! -f "reports/priorities.md" ]; then
    echo "No priorities.md found. Skipping auto-build."
    exit 0
fi

# Lire la priorité #1
PRIORITY=$(head -20 reports/priorities.md | grep -E "^1\." | head -1 | sed 's/^1\. //')

if [ -z "$PRIORITY" ]; then
    echo "No priority item found. Skipping."
    exit 0
fi

echo "Building: $PRIORITY"

# Créer une branche
BRANCH_NAME="compound/$(date +%Y%m%d)-$(echo $PRIORITY | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | cut -c1-30)"
git checkout -b "$BRANCH_NAME"

# Lancer Claude pour implémenter
claude -p "
Tu es en mode auto-compound build.

Tâche à implémenter: $PRIORITY

1. Crée un PRD minimal dans tasks/
2. Implémente la feature
3. Assure-toi que typecheck et lint passent
4. Commit tes changements

Ne push pas encore - crée juste les commits locaux.
" --dangerously-skip-permissions 2>&1 | tee -a logs/auto-compound.log

# Push et créer PR
git push -u origin "$BRANCH_NAME"
gh pr create --draft --title "Compound: $PRIORITY" --base main --body "Auto-generated overnight build"

echo "[$(date)] Auto-compound build complete. PR created."
SCRIPT

# Rendre exécutables
chmod +x "$PROJECT_PATH/scripts/compound/daily-compound-review.sh"
chmod +x "$PROJECT_PATH/scripts/compound/auto-compound.sh"

echo "✅ Scripts créés"

# Créer les LaunchAgents
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
mkdir -p "$LAUNCH_AGENTS_DIR"

# Compound Review plist (22h30)
cat > "$LAUNCH_AGENTS_DIR/com.bourbon.$PROJECT_NAME.compound-review.plist" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.bourbon.$PROJECT_NAME.compound-review</string>
    <key>ProgramArguments</key>
    <array>
        <string>$PROJECT_PATH/scripts/compound/daily-compound-review.sh</string>
    </array>
    <key>WorkingDirectory</key>
    <string>$PROJECT_PATH</string>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>22</integer>
        <key>Minute</key>
        <integer>30</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$PROJECT_PATH/logs/compound-review.log</string>
    <key>StandardErrorPath</key>
    <string>$PROJECT_PATH/logs/compound-review.log</string>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
    </dict>
</dict>
</plist>
PLIST

# Auto-Compound plist (23h00)
cat > "$LAUNCH_AGENTS_DIR/com.bourbon.$PROJECT_NAME.auto-compound.plist" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.bourbon.$PROJECT_NAME.auto-compound</string>
    <key>ProgramArguments</key>
    <array>
        <string>$PROJECT_PATH/scripts/compound/auto-compound.sh</string>
    </array>
    <key>WorkingDirectory</key>
    <string>$PROJECT_PATH</string>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>23</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$PROJECT_PATH/logs/auto-compound.log</string>
    <key>StandardErrorPath</key>
    <string>$PROJECT_PATH/logs/auto-compound.log</string>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
    </dict>
</dict>
</plist>
PLIST

echo "✅ LaunchAgents créés"

# Charger les jobs
launchctl load "$LAUNCH_AGENTS_DIR/com.bourbon.$PROJECT_NAME.compound-review.plist" 2>/dev/null || true
launchctl load "$LAUNCH_AGENTS_DIR/com.bourbon.$PROJECT_NAME.auto-compound.plist" 2>/dev/null || true

echo "✅ Jobs chargés"
echo ""
echo "🎉 Setup terminé !"
echo ""
echo "Vérifier les jobs:"
echo "  launchctl list | grep bourbon"
echo ""
echo "Logs:"
echo "  tail -f $PROJECT_PATH/logs/compound-review.log"
echo "  tail -f $PROJECT_PATH/logs/auto-compound.log"
echo ""
echo "Désactiver:"
echo "  launchctl unload ~/Library/LaunchAgents/com.bourbon.$PROJECT_NAME.*.plist"
