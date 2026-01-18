# 📥 Installer Claude Code

## Prérequis

- Un compte Anthropic avec accès à Claude
- Un terminal (Mac/Linux) ou PowerShell (Windows)
- Node.js 18+ recommandé (pour les projets web)

---

## Installation

### macOS / Linux

```bash
curl -fsSL https://claude.ai/install.sh | sh
```

### Windows (PowerShell Admin)

```powershell
irm https://claude.ai/install.ps1 | iex
```

### Vérifier l'installation

```bash
claude --version
```

Tu devrais voir quelque chose comme : `Claude Code v2.x.x`

---

## Première configuration

### 1. Lancer Claude Code

```bash
claude
```

### 2. Authentification

Claude va te demander de t'authentifier. Deux options :

**Option A : Via navigateur (recommandé)**
- Claude ouvre ton navigateur
- Connecte-toi à ton compte Anthropic
- Autorise Claude Code

**Option B : Via clé API**
```bash
claude --api-key sk-ant-xxxxx
```

### 3. Configuration initiale

À la première utilisation, Claude te pose quelques questions :
- Langue préférée (français recommandé)
- Thème (dark/light)
- Mode de permissions

---

## Configuration recommandée

Crée le fichier `~/.claude/settings.json` :

```json
{
  "model": "sonnet",
  "theme": "dark",
  "preferredLanguage": "fr",
  "modelPreferences": {
    "planning": "opus",
    "quickTasks": "haiku"
  }
}
```

### Explication des modèles

| Modèle | Usage | Coût |
|--------|-------|------|
| **Opus** | Architecture, planning complexe | $$$ |
| **Sonnet** | Développement quotidien | $$ |
| **Haiku** | Tâches rapides, commits | $ |

**Recommandation** : Utilise Sonnet par défaut, Opus pour le planning, Haiku pour les commits.

---

## Structure de fichiers Claude

```
~/.claude/
├── settings.json      # Configuration globale
├── CLAUDE.md          # Instructions globales (tous projets)
└── commands/          # Skills personnalisés globaux
```

```
ton-projet/
├── CLAUDE.md          # Instructions spécifiques au projet
├── AGENTS.md          # Learnings du projet
└── .claude/
    └── commands/      # Skills spécifiques au projet
```

---

## Commandes essentielles

| Commande | Action |
|----------|--------|
| `claude` | Lancer Claude Code |
| `claude "prompt"` | Lancer avec un prompt |
| `/help` | Aide |
| `/clear` | Effacer conversation |
| `/cost` | Voir consommation tokens |
| `Ctrl+C` | Interrompre |
| `Escape` | Annuler action en cours |

---

## Test : Premier projet

```bash
mkdir test-claude && cd test-claude
claude "Crée un fichier hello.js qui affiche Hello World"
```

Claude devrait :
1. Créer le fichier `hello.js`
2. Y écrire le code
3. Te confirmer la création

```bash
node hello.js
# Output: Hello World
```

🎉 **Félicitations, Claude Code est prêt !**

---

## Problèmes fréquents

### "Command not found: claude"

```bash
# Ajouter au PATH
export PATH="$HOME/.claude/bin:$PATH"
# Ajouter à ~/.zshrc ou ~/.bashrc pour persister
```

### "Authentication failed"

```bash
# Réauthentifier
claude logout
claude login
```

### "Rate limit exceeded"

- Attendre quelques minutes
- Ou vérifier ton plan Anthropic

---

## Prochaine étape

→ [02-first-conversation.md](./02-first-conversation.md) - Ta première conversation productive
