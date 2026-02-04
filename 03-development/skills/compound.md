# /compound - Compound Engineering Loop

## Usage

```
/compound [feature-name]     # Compound les learnings d'une feature
/compound --daily            # Review et compound de la journée
/compound --overnight        # Lance le loop complet overnight
```

---

## Source & Inspiration

Patterns validés par :
- @ryancarson — Overnight compound loop
- @pbteja1998 — Mission Control multi-agents
- @RohunJauhar — Self-improving AI setup
- @kieranklaassen — Compound Engineering Plugin original

---

## Le Principe

> "Chaque unité de travail doit rendre les suivantes plus faciles."

Le compound engineering c'est :
1. **Extraire** les learnings de chaque session
2. **Persister** ces learnings dans les fichiers de config (CLAUDE.md, AGENTS.md)
3. **Bénéficier** de ces learnings dans les sessions suivantes

---

## Compound Loop Overnight (Automatisé)

### Phase 1 : Compound Review (22h30)

```bash
#!/bin/bash
# scripts/daily-compound-review.sh

cd ~/projects/mon-projet

# S'assurer d'être sur main et à jour
git checkout main
git pull origin main

claude -p "
Charge le skill compound-engineering.

Regarde et lis chaque thread Claude des dernières 24h.
Pour chaque thread où on n'a PAS utilisé le skill Compound à la fin,
fais-le maintenant :
- Extrais les learnings clés
- Mets à jour les fichiers CLAUDE.md / AGENTS.md pertinents
- Documente les patterns découverts
- Note les erreurs à éviter

Commit tes changements et push sur main.
"
```

### Phase 2 : Auto-Compound Build (23h00)

```bash
#!/bin/bash
# scripts/auto-compound.sh

cd ~/projects/mon-projet

# Récupérer les derniers learnings
git fetch origin main
git reset --hard origin/main

# Trouver le dernier rapport de priorités
LATEST_REPORT=$(ls -t reports/*.md | head -1)

# Analyser et prendre la priorité #1
PRIORITY_ITEM=$(cat "$LATEST_REPORT" | head -20 | grep "1\." | head -1)

# Créer une branche feature
BRANCH_NAME="compound/$(date +%Y%m%d)"
git checkout -b "$BRANCH_NAME"

# Créer PRD et implémenter
claude -p "
Charge le skill prd.
Crée un PRD pour: $PRIORITY_ITEM
Sauvegarde dans tasks/prd-compound-$(date +%Y%m%d).md
"

# Lancer Ralph pour implémenter
/ralph compound-$(date +%Y%m%d)

# Créer PR
git push -u origin "$BRANCH_NAME"
gh pr create --draft --title "Compound: $PRIORITY_ITEM" --base main
```

---

## Setup launchd (macOS)

### Compound Review (22h30)

```xml
<!-- ~/Library/LaunchAgents/com.bourbon.compound-review.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "...">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.bourbon.compound-review</string>
  <key>ProgramArguments</key>
  <array>
    <string>/path/to/scripts/daily-compound-review.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key><integer>22</integer>
    <key>Minute</key><integer>30</integer>
  </dict>
</dict>
</plist>
```

### Auto-Compound Build (23h00)

```xml
<!-- ~/Library/LaunchAgents/com.bourbon.auto-compound.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "...">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.bourbon.auto-compound</string>
  <key>ProgramArguments</key>
  <array>
    <string>/path/to/scripts/auto-compound.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key><integer>23</integer>
    <key>Minute</key><integer>0</integer>
  </dict>
</dict>
</plist>
```

### Charger les jobs

```bash
launchctl load ~/Library/LaunchAgents/com.bourbon.compound-review.plist
launchctl load ~/Library/LaunchAgents/com.bourbon.auto-compound.plist
```

---

## Compound Manuel (après une feature)

```
/compound auth-system
```

Claude va :
1. Lire l'historique de la session auth-system
2. Identifier les patterns utiles
3. Noter les erreurs rencontrées et comment elles ont été résolues
4. Mettre à jour CLAUDE.md avec les nouveaux patterns
5. Documenter dans `memory/learnings/auth-system.md`

---

## Structure des Learnings

```
memory/
├── learnings/
│   ├── 2026-02-04.md          # Daily learnings
│   ├── auth-system.md         # Feature-specific
│   └── patterns.md            # Patterns réutilisables
└── compound-log.md            # Log des compound runs
```

### Format d'un learning

```markdown
## [Date] - [Feature/Contexte]

### Ce qui a marché
- Pattern X pour résoudre Y
- Approche Z pour le problème A

### Ce qui n'a PAS marché
- ❌ Tentative de B → erreur C
- ❌ Approche D → trop lent

### Règles découvertes
- Toujours faire X avant Y
- Ne jamais utiliser Z dans ce contexte

### Code patterns à réutiliser
\`\`\`typescript
// Pattern pour [description]
...\`\`\`
```

---

## Implémentation (.claude/commands/compound.md)

```markdown
---
description: Compound les learnings d'une session/feature
allowed-tools: Read, Write, Bash(git *)
model: sonnet
---

# /compound

Extrais et persiste les learnings de la session.

## Arguments
- feature-name : (optionnel) Nom de la feature
- --daily : Review de la journée entière
- --overnight : Lance le loop complet

## Étapes

1. **Charger le contexte**
   - Lire l'historique de session
   - Identifier les décisions clés
   - Noter les erreurs et solutions

2. **Extraire les learnings**
   - Patterns qui ont marché
   - Erreurs à éviter
   - Code réutilisable

3. **Persister**
   - Mettre à jour CLAUDE.md si pattern global
   - Créer/mettre à jour memory/learnings/[feature].md
   - Ajouter au compound-log.md

4. **Commit**
   - git add memory/ CLAUDE.md
   - git commit -m "compound: [feature] learnings"
   - git push

## Output
Résumé des learnings extraits et fichiers mis à jour.
```

---

## Résultat Attendu

Après quelques semaines de compound :
- CLAUDE.md devient une base de connaissance du projet
- Les erreurs communes ne se répètent plus
- L'agent "connaît" les patterns du codebase
- Chaque nouvelle feature bénéficie des learnings passés

> "Stop prompting. Start compounding." — @ryancarson
