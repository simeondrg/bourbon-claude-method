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

### Skills Library (skills.sh)

> **Règle d'Or** : Au démarrage de chaque projet, installer les skills pertinents selon le type, puis les appeler au fur et à mesure.

#### Installation rapide

```bash
/skills-install           # Auto-détecte le type
/skills-install saas      # Bundle SaaS complet
/skills-install mobile    # Bundle mobile Expo
/skills-install marketing # Bundle marketing
```

#### Bundles disponibles

| Bundle | Skills inclus | Commande |
|--------|---------------|----------|
| **CORE** (auto) | react-best-practices, web-design, TDD, debugging | `npx skills add vercel-labs/agent-skills` |
| **SaaS** | supabase, stripe, better-auth | `npx skills add supabase/agent-skills stripe/ai better-auth/skills` |
| **Marketing** | seo-audit, copywriting, paid-ads, email-sequence | `npx skills add coreyhaines31/marketingskills` |
| **Mobile** | expo, react-native, native-ui | `npx skills add expo/skills callstackincubator/agent-skills` |

#### Appel contextuel automatique

| Contexte | Skill appelé |
|----------|--------------|
| Composant React | `/vercel-react-best-practices` |
| Table Supabase | `/supabase-postgres-best-practices` |
| Intégration Stripe | `/stripe-best-practices` |
| Copy marketing | `/copywriting` |
| Meta Ads | `/paid-ads` |

📚 **Catalogue complet** : [06-skills-library/](./06-skills-library/) ou [skills.sh](https://skills.sh)

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
├── 00-getting-started/         # Guide démarrage
├── 01-idea-to-plan/            # Business planning
├── 02-project-setup/           # Configs CLAUDE.md (3 niveaux)
│   └── level-3-complete/
│       ├── CLAUDE.md           # Config projet (allégé)
│       └── .claude/
│           ├── rules/          # Règles modulaires
│           ├── commands/       # Skills locaux
│           ├── SKILLS-INDEX.md # Matrice auto-application
│           └── hooks.md        # Documentation hooks
├── 03-development/             # Workflows dev
├── 04-launch/                  # Déploiement
├── 05-monetize/                # Stripe, revenus
└── 06-skills-library/          # 📚 Catalogue skills.sh complet
```

---

## Philosophie

### Compound Engineering
> "Chaque unité de travail doit rendre les suivantes plus faciles."

### Automatisation Maximale
> "L'utilisateur décrit, Claude exécute."

### Agent Autonome (Overnight Builds)
> "L'agent travaille pendant que tu dors."

---

## 🌙 Overnight Builds (Nouveau - Février 2026)

**Sources :** @ryancarson, @RohunJauhar, @pbteja1998

### Le Concept

Ton agent Claude peut travailler **pendant que tu dors** :
1. **22h30** — Review les sessions du jour, extrait les learnings
2. **23h00** — Prend la priorité #1 du backlog et l'implémente
3. **Au réveil** — Tu as une PR prête à review

### Setup rapide

```bash
# Copier les scripts
cp templates/overnight/* scripts/

# Configurer launchd (macOS)
./scripts/setup-overnight.sh

# Vérifier
launchctl list | grep bourbon
```

### Commandes liées

| Commande | Action |
|----------|--------|
| `/compound` | Extraire les learnings d'une feature |
| `/compound --daily` | Review de la journée |
| `/compound --overnight` | Lance le loop complet |

### Le "John Wick" Prompt

Pour un agent ultra-proactif, utilise ce prompt dans ton CLAUDE.md :

```markdown
## Agent Mode

Je suis un co-founder IA, pas un assistant passif.

- J'utilise tout ce que je sais sur le projet pour repérer des opportunités
- Je construis des améliorations sans attendre qu'on me demande
- Je monitore les workflows et corrige les inefficacités
- Je travaille de façon autonome pendant les heures creuses
- Je crée des PRs, jamais push direct
- Bias vers l'action plutôt que demander permission

Objectif : Le fondateur doit se réveiller impressionné par ce qui a été produit.
```

Voir [03-development/skills/compound.md](./03-development/skills/compound.md) pour le guide complet.

---

## Liens

- [Bourbon Media](https://bourbonmedia.fr)
- [Masterclass Premium](https://bourbonmedia.fr/masterclass)
- [Twitter/X](https://twitter.com/simeondrg)

---

*Créé avec Claude Code à La Réunion 🇷🇪*
