# Bourbon Claude Method

**La méthode pour créer n'importe quel projet avec Claude Code - sans effort, tout est automatisé.**

> Compatible Claude Code **2.1.17+** (janvier 2025)

---

## RÈGLE D'OR

> **L'utilisateur ne doit JAMAIS deviner quoi faire.**
>
> Tu décris ton projet en une phrase. Claude fait tout le reste.

---

## Comment ça marche

```
1. Tu installes (1 min)
2. Tu tapes "/start"
3. Tu décris ton projet en une phrase
4. Tu regardes Claude construire
5. Ton site est en ligne
```

**C'est tout.** Pas de jargon, pas de questions techniques, pas de choix à faire.

---

## Installation

```bash
# Mac/Linux
git clone https://github.com/simeondrg/bourbon-claude-method.git
cd bourbon-claude-method
./setup.sh

# Windows (PowerShell admin)
git clone https://github.com/simeondrg/bourbon-claude-method.git
cd bourbon-claude-method
.\setup.ps1
```

Le script installe automatiquement tout ce qu'il faut.

---

## Utilisation

```bash
mkdir mon-projet
cd mon-projet
claude
/start
```

Puis décris ton projet :
- "Un site pour mon restaurant"
- "Une app de réservation"
- "Une plateforme pour vendre mes formations"

**Claude fait le reste automatiquement.**

---

## Nouveautés 2025

### Architecture modulaire `.claude/rules/`

Les règles sont maintenant séparées en fichiers modulaires :

```
.claude/
├── rules/
│   ├── automation.md   # Règle d'or
│   ├── stack.md        # Technologies
│   ├── quality.md      # Standards code
│   └── patterns.md     # Auto-rempli
├── commands/           # Skills (/start, /ralph...)
└── hooks.md            # Documentation hooks
```

**Avantages** :
- CLAUDE.md allégé (~70% moins de tokens)
- Règles chargées à la demande
- Plus facile à maintenir

### Commandes Claude essentielles

| Commande | Action |
|----------|--------|
| `/compact` | Compresser contexte (libérer tokens) |
| `/usage` | Voir consommation du plan |
| `/context` | Voir tokens utilisés |
| `/clear` | Nouveau départ |

### Raccourcis

| Touche | Action |
|--------|--------|
| `Ctrl+S` | Stash prompt (sauvegarde temp) |
| `!` | Autocomplete historique bash |
| `Ctrl+C` | Interrompre proprement |

### Hooks (automation avancée)

Exécuter des actions automatiques :

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "npm run lint --fix"
      }
    ]
  }
}
```

Voir `.claude/hooks.md` pour plus d'exemples.

---

## Types de projets supportés

| Tu dis | Claude crée |
|--------|-------------|
| "site restaurant" | Landing + Menu + Contact + Maps |
| "portfolio" | Galerie + Bio + Contact |
| "app de réservation" | Auth + Calendrier + Dashboard |
| "vendre mes formations" | Stripe + Dashboard + Vidéos |
| "app fitness" | Mobile + Auth + Tracking |

---

## Pour les développeurs

### Stack par défaut

- **Frontend** : Next.js 14+ (App Router) + Tailwind + shadcn/ui
- **Backend** : Supabase (PostgreSQL + Auth + Storage)
- **Infra** : Vercel + Stripe
- **Tests** : Playwright (E2E)

### Skills auto-installés

| Type projet | Skills |
|-------------|--------|
| Vitrine | `web-design-guidelines`, `vercel-react-best-practices` |
| Web App | + `frontend-design`, `native-data-fetching` |
| SaaS | + `better-auth-best-practices` |
| Mobile | `building-native-ui`, `upgrading-expo` |

Source: [skills.sh](https://skills.sh)

### Frontmatter Skills (format officiel)

```yaml
---
name: my-skill
description: "Quand utiliser ce skill"
argument-hint: "[args]"
allowed-tools: Read, Write, Bash
model: sonnet
---

# Instructions du skill...
```

---

## Structure

```
bourbon-claude-method/
├── setup.sh                    # Installation
├── templates/commands/         # Templates skills
└── 02-project-setup/
    └── level-3-complete/
        ├── CLAUDE.md           # Config projet (allégé)
        └── .claude/
            ├── rules/          # Règles modulaires
            ├── commands/       # Skills
            └── hooks.md        # Documentation hooks
```

---

## Philosophie

### Compound Engineering
> "Chaque unité de travail doit rendre les suivantes plus faciles."

### Automatisation Maximale
> "L'utilisateur décrit, Claude exécute."

---

## Liens

- [Bourbon Media](https://bourbonmedia.fr)
- [Masterclass Premium](https://bourbonmedia.fr/masterclass)
- [Twitter/X](https://twitter.com/simeondrg)

---

*Créé avec Claude Code à La Réunion 🇷🇪*
