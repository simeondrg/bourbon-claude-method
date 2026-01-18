# ⌨️ Les Commandes Essentielles

## Commandes Built-in

| Commande | Action |
|----------|--------|
| `/help` | Afficher l'aide |
| `/clear` | Effacer la conversation |
| `/cost` | Voir la consommation tokens |
| `/compact [instructions]` | Compacter le contexte avec focus optionnel |
| `/config` | Voir/modifier la configuration |
| `/doctor` | Vérifier l'installation Claude Code |
| `/init` | Initialiser projet avec CLAUDE.md |
| `/login` | Changer de compte Anthropic |
| `/logout` | Se déconnecter |
| `/mcp` | Gérer les serveurs MCP et OAuth |
| `/memory` | Éditer les fichiers CLAUDE.md |
| `/model` | Changer de modèle IA |
| `/permissions` | Voir/modifier les permissions |
| `/review` | Demander une code review |
| `/status` | Voir le statut compte et système |
| `/terminal-setup` | Configurer Shift+Enter (iTerm2/VSCode) |
| `/usage` | Voir limites et rate limits (abonnements) |
| `/vim` | Mode vim insert/command |

---

## Checkpointing (Safety Net)

Claude crée automatiquement des checkpoints à chaque prompt.

| Commande | Action |
|----------|--------|
| `Esc+Esc` | Ouvrir le menu rewind |
| `/rewind` | Ouvrir le menu rewind (alternatif) |

### Types de Rewind

| Type | Description |
|------|-------------|
| **Conversation Rewind** | Revenir à un message précédent, garde le code |
| **Code Rewind** | Annuler les changements de fichiers, garde la conversation |
| **Full Rewind** | Annuler code ET conversation |

> **Limitations** : Les commandes bash (rm, mv, cp) ne sont pas trackées. Utilise Git pour l'historique permanent.

---

## Raccourcis Clavier

| Raccourci | Action |
|-----------|--------|
| `!` | Préfixe mode bash (exécute directement) |
| `@` | Mentionner fichiers/dossiers |
| `\` + Enter | Nouvelle ligne |
| `Esc` | Interrompre Claude |
| `Esc+Esc` | Ouvrir menu rewind |
| `Ctrl+R` | Afficher output/contexte complet |
| `Ctrl+V` | Coller une image |
| `Shift+Tab` | Auto-accept ("yolo mode") |
| `Shift+Tab+Tab` | Mode plan |
| `Cmd+Esc` / `Ctrl+Esc` | Lancer rapidement depuis IDE |
| `Cmd+Option+K` / `Alt+Ctrl+K` | Insérer références fichiers |

---

## Commandes CLI

### Démarrage

```bash
# Lancer Claude dans un dossier
cd mon-projet && claude

# Avec prompt initial
claude "Explique-moi la structure"

# Mode plan (réfléchir avant d'agir)
claude --plan

# Continuer dernière session
claude --continue
```

### Choix du modèle

```bash
claude --model opus    # Tâches complexes, architecture
claude --model sonnet  # Défaut, dev quotidien
claude --model haiku   # Tâches simples, moins cher
```

### Mode Headless (CI/CD & Automation)

```bash
# Non-interactif, print et exit
claude -p "query"

# Output JSON avec métadonnées
claude -p --output-format json "query"

# Stream JSON temps réel
claude -p --output-format stream-json "query"

# Continuer conversation non-interactivement
claude -c -p "query"

# Reprendre session spécifique
claude --resume <session-id> -p "query"

# Limiter les itérations
claude --max-turns 3 -p "query"

# Verbose pour debug
claude --verbose -p "query"
```

### Exemples Headless

```bash
# SRE Incident Response
claude -p "Analyze these errors" \
  --append-system-prompt "You are an SRE expert" \
  --output-format json \
  --allowedTools "Bash,Read,mcp__datadog"

# Security Audit sur PR
gh pr diff 123 | claude -p \
  --append-system-prompt "You are a security engineer" \
  --output-format json \
  --allowedTools "Read,Grep" > audit.json

# Multi-turn Session
session_id=$(claude -p "Start review" --output-format json | jq -r '.session_id')
claude --resume "$session_id" -p "Check compliance"
claude --resume "$session_id" -p "Generate summary"
```

---

## Slash Commands Personnalisés

### Emplacements

| Location | Scope |
|----------|-------|
| `.claude/commands/` | Projet (partagé avec l'équipe) |
| `~/.claude/commands/` | Personnel (tous tes projets) |

### Structure de base

`.claude/commands/mon-command.md` :

```markdown
Analyse ce code pour les problèmes de performance :
```

Usage : `/mon-command`

### Avec Arguments

```markdown
Fix issue #$ARGUMENTS suivant nos coding standards
```

Usage : `/fix-issue 123`

### Arguments Positionnels

```markdown
---
argument-hint: [pr-number] [priority] [assignee]
description: Review pull request with priority and assignee
---

Review PR #$1 with priority $2 and assign to $3.
Focus on security, performance, and code style.
```

Usage : `/review-pr 123 high alice`

### Avec Permissions d'outils

```markdown
---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
argument-hint: [message]
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff: !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

Based on the above changes, create a single git commit.
```

### Avec Override de Modèle

```markdown
---
description: Perform deep code analysis
model: claude-opus-4-1-20250805
disable-model-invocation: true
---

Perform a comprehensive analysis of this codebase focusing on:
- Architecture patterns
- Potential scalability issues
- Security vulnerabilities
- Performance bottlenecks
```

### Syntaxes Utiles

| Syntaxe | Usage |
|---------|-------|
| `$ARGUMENTS` | Tous les arguments |
| `$1`, `$2`, `$3` | Arguments positionnels |
| `` !`command` `` | Exécuter bash avant traitement |
| `@filename` | Inclure contenu de fichier |
| `/mcp__server__prompt` | Appeler prompt MCP |

---

## Gestion du Contexte

### Le problème

Claude a ~200k tokens de contexte. Sur longues sessions :
- Le contexte se remplit
- Les réponses ralentissent
- Les coûts augmentent

### Solutions

```
/compact     # Résumer et compacter le contexte
/compact "Focus sur l'auth system"  # Avec instructions
/clear       # Effacer complètement (perte d'historique)
```

### Bonne pratique

```
# Toutes les 30-60 minutes de travail
/cost        # Vérifier la consommation
/compact     # Si > $5, compacter
```

---

## Commandes Git intégrées

```
"Montre-moi les changements non commités"
→ Claude exécute git status et git diff

"Crée un commit pour ces changements"
→ Claude stage, commit avec message conventionnel

"Pousse sur GitHub"
→ Claude push avec vérification
```

---

## Template quotidien

### Début de journée

```bash
cd mon-projet
claude
```

```
"Rappelle-moi où on en était hier"
```

### Pendant le dev

```
"Implémente [feature]"
"Il y a une erreur : [erreur]"
"Optimise ce code"
```

### Fin de journée

```
/cost                  # Vérifier consommation
/commit                # Commiter les changements
"Résume ce qu'on a fait aujourd'hui"
```

---

## Prochaine étape

→ [../01-idea-to-plan/01-validate-idea.md](../01-idea-to-plan/01-validate-idea.md) - Valider ton idée
