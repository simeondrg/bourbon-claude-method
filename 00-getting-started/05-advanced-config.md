# ⚙️ Configuration Avancée

## Fichiers de Configuration

### Ordre de priorité (du plus haut au plus bas)

| Priorité | Fichier | Usage |
|----------|---------|-------|
| 1 | `/etc/claude-code/managed-settings.json` | Enterprise (admin) |
| 2 | `.claude/settings.local.json` | Projet local (git-ignored) |
| 3 | `.claude/settings.json` | Projet partagé (équipe) |
| 4 | `~/.claude/settings.json` | User global (défaut perso) |

### Commandes de gestion

```bash
claude config list                    # Voir tous les settings
claude config get <key>               # Voir une valeur
claude config set <key> <value>       # Modifier une valeur
claude config add <key> <value>       # Ajouter à une liste
claude config remove <key> <value>    # Retirer d'une liste
```

---

## Permissions & Sécurité

### Structure des permissions

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Bash(git diff)",
      "Bash(git add *)",
      "Bash(git commit *)"
    ],
    "ask": [
      "Bash(git push:*)",
      "Bash(npm install *)"
    ],
    "deny": [
      "Read(./.env*)",
      "Read(./secrets/**)",
      "Read(./**/credentials*)",
      "Bash(rm -rf:*)",
      "Bash(curl:*)"
    ]
  }
}
```

### Niveaux de permission

| Niveau | Comportement |
|--------|-------------|
| `allow` | Exécute automatiquement sans demander |
| `ask` | Demande confirmation à chaque fois |
| `deny` | Bloque toujours, même si demandé |

> **Règle** : `deny` a toujours priorité sur `allow`

### Exemple : Basic Security (recommandé)

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Bash(git diff)",
      "Bash(git add *)",
      "Bash(git commit *)"
    ],
    "ask": [
      "Bash(git push:*)",
      "Bash(npm install *)"
    ],
    "deny": [
      "Read(./.env*)",
      "Read(./secrets/**)",
      "Read(./**/credentials*)",
      "Bash(rm -rf:*)",
      "Bash(curl:*)"
    ]
  }
}
```

### Exemple : Strict Security (projets sensibles)

```json
{
  "permissions": {
    "ask": [
      "Bash(*)",
      "Write(*)",
      "Edit(*)"
    ],
    "deny": [
      "Read(./.env*)",
      "Read(./secrets/**)",
      "Read(./config/**)",
      "Read(./**/credentials*)",
      "Read(./**/*.key)",
      "Read(./**/*.pem)",
      "WebFetch",
      "Bash(curl:*)",
      "Bash(wget:*)",
      "Bash(ssh:*)"
    ]
  }
}
```

---

## Hooks System

### Qu'est-ce qu'un Hook ?

Les hooks sont des scripts shell qui s'exécutent automatiquement lors d'événements Claude Code.

> **Attention** : Les hooks s'exécutent avec tes credentials. Toujours reviewer avant d'ajouter.

### Events disponibles

| Event | Déclencheur |
|-------|-------------|
| `PreToolUse` | Avant un tool call (peut bloquer) |
| `PostToolUse` | Après un tool call complété |
| `UserPromptSubmit` | Quand user soumet un prompt |
| `Notification` | Quand Claude envoie une notification |
| `Stop` | Quand Claude finit de répondre |
| `SubagentStop` | Quand un subagent termine |
| `PreCompact` | Avant opération de compact |
| `SessionStart` | Quand Claude démarre/reprend une session |
| `SessionEnd` | Quand la session se termine |

### Structure d'un Hook

Dans `~/.claude/settings.json` ou `.claude/settings.json` :

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx prettier --write $FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

### Variables disponibles

| Variable | Description |
|----------|-------------|
| `$FILE_PATH` | Chemin du fichier concerné |
| `$CLAUDE_PROJECT_DIR` | Répertoire du projet |
| `$CONVERSATION_SUMMARY` | Résumé de la conversation |

### Exit codes

| Code | Comportement |
|------|-------------|
| `0` | Success, continue |
| `2` | Block l'action, montrer message à Claude |
| autre | Erreur |

### Exemple : Auto-format après édition

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx prettier --write $FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

### Exemple : Log des sessions

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo \"$(date): $CONVERSATION_SUMMARY\" >> ~/.claude/activity.log"
          }
        ]
      }
    ]
  }
}
```

### Exemple : Bloquer certains fichiers

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "if [[ \"$FILE_PATH\" == *\".env\"* ]]; then echo 'Cannot modify .env files'; exit 2; fi"
          }
        ]
      }
    ]
  }
}
```

### Tips Hooks

- **Location** : `~/.claude/settings.json` (user) ou `.claude/settings.json` (projet)
- **Matchers** : Match tool names (ex: `Bash`, `Edit|Write`, `*`)
- **Scripts projet** : Utiliser `$CLAUDE_PROJECT_DIR` pour chemins relatifs
- **Debug** : Utiliser `claude --debug` pour voir l'exécution des hooks

---

## MCP Servers

### Qu'est-ce que MCP ?

Model Context Protocol (MCP) permet d'étendre Claude Code avec des outils externes : browser automation, database access, API integrations.

### Commandes de gestion

```bash
claude mcp add <name> <command> [args...]      # Ajouter MCP server
claude mcp add --transport sse <name> <url>    # Ajouter SSE transport
claude mcp add --transport http <name> <url>   # Ajouter HTTP transport
claude mcp list                                 # Lister les MCPs installés
claude mcp remove <name>                        # Supprimer un MCP
```

### MCPs populaires

| MCP | Usage | Installation |
|-----|-------|--------------|
| **GitHub** | Repos, PRs, Issues | `claude mcp add --transport http github https://api.githubcopilot.com/mcp/` |
| **Supabase** | Database, Auth | `claude mcp add --transport http supabase https://mcp.supabase.com/` |
| **Figma** | Design context | `claude mcp add --transport http figma https://mcp.figma.com/mcp` |
| **Linear** | Issue tracking | `claude mcp add --transport sse linear https://mcp.linear.app/sse` |
| **Notion** | Docs, wikis | `claude mcp add --transport http notion https://mcp.notion.so/mcp` |

### Exemple avec variables d'environnement

```bash
claude mcp add --transport stdio airtable --env \
  AIRTABLE_API_KEY=YOUR_KEY -- npx -y airtable-mcp-server
```

---

## Git Worktrees (Travail Parallèle)

### Pourquoi utiliser Worktrees ?

| Avantage | Description |
|----------|-------------|
| **No Context Loss** | Chaque session Claude garde son contexte projet |
| **Parallel Work** | Hotfix + feature en parallèle |
| **Safe Experiments** | Tester des changements risqués en isolation |
| **Model Comparison** | Comparer Sonnet vs Opus sur même tâche |
| **Zero Switching Cost** | Plus de git stash, checkout, restart |

### Commandes essentielles

```bash
# Créer worktree avec branche existante
git worktree add <path> <branch>

# Créer worktree avec nouvelle branche
git worktree add <path> -b <branch> <start-point>

# Lister tous les worktrees
git worktree list

# Supprimer un worktree
git worktree remove <path>

# Nettoyer références
git worktree prune

# Déplacer un worktree
git worktree move <worktree> <new-path>
```

### Workflow exemple

```bash
# Créer worktree pour experiment
git worktree add ../myapp-experiment -b experiment/refactor main
cd ../myapp-experiment
claude "refactor the entire auth system"
# Si ça échoue, juste supprimer le directory

# Créer worktree pour code review
git worktree add ../myapp-review -b review/cleanup feature-branch
cd ../myapp-review
claude "add docs, tests, and clean up code style"
git merge review/cleanup

# Comparer modèles
git worktree add ../ml-sonnet -b experiment/sonnet main
git worktree add ../ml-opus -b experiment/opus main
cd ../ml-sonnet && claude --model sonnet
cd ../ml-opus && claude --model opus
```

---

## Skills vs Slash Commands vs Agents

### Différences clés

| Type | Invocation | Location | Usage |
|------|------------|----------|-------|
| **Slash Commands** | User-invoked (`/command`) | `.claude/commands/` | Prompts simples, single file |
| **Agent Skills** | Model-invoked (auto) | `.claude/skills/` | Capabilities complexes, multi-files |
| **Subagents** | User ou Model | `.claude/agents/` | Assistants spécialisés |

### Slash Commands

- Tu tapes `/command`
- Simple fichier markdown
- Exécution immédiate

### Agent Skills

- Claude les utilise automatiquement selon contexte
- Directory avec `SKILL.md` + scripts optionnels
- Mots-clés : "proactively" ou "MUST BE USED" dans description

### Subagents

- Assistants spécialisés avec contexte isolé
- Peuvent être chaînés
- YAML frontmatter avec `name`, `description`, `tools`, `model`

---

## Prochaine étape

→ [../01-idea-to-plan/01-validate-idea.md](../01-idea-to-plan/01-validate-idea.md) - Valider ton idée
