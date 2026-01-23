# Bourbon Claude Method

**La méthode pour créer n'importe quel projet avec Claude Code - sans effort, tout est automatisé.**

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

## Ce qui se passe automatiquement

```
Tu dis: "site pour mon restaurant"
           │
           ▼
┌─────────────────────────────────────────┐
│  Claude comprend automatiquement:       │
│  • Type: Site vitrine                   │
│  • Cible: Tes clients                   │
│  • Features: Menu, Contact, Maps        │
└─────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────┐
│  Claude installe automatiquement:       │
│  • Skills pertinents (design, SEO)      │
│  • Structure projet optimale            │
│  • Configuration complète               │
└─────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────┐
│  Claude construit automatiquement:      │
│  • Toutes les pages                     │
│  • Le design (vérifié visuellement)     │
│  • Les tests                            │
└─────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────┐
│  Claude déploie automatiquement:        │
│  • GitHub (sauvegarde)                  │
│  • Vercel (en ligne)                    │
│  • URL finale prête                     │
└─────────────────────────────────────────┘
           │
           ▼
     🎉 "Ton site est en ligne: [URL]"
```

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

## Raccourcis utiles

| Raccourci | Action |
|-----------|--------|
| `Ctrl+S` | Sauvegarder ton prompt (comme git stash) |
| `Ctrl+C` | Arrêter Claude proprement |
| `/clear` | Recommencer à zéro |

---

## Pour les développeurs

### Workflow automatisé

L'ancien workflow manuel :
```
/prd → /check-stories → /ralph → /test → /security → /review → /commit
```

**Est maintenant automatique.** Tu dis ce que tu veux, Claude enchaîne tout seul.

### Skills installés automatiquement

| Type projet | Skills auto-installés |
|-------------|----------------------|
| Vitrine | `web-design-guidelines`, `vercel-react-best-practices` |
| Web App | + `frontend-design`, `native-data-fetching` |
| SaaS | + `better-auth-best-practices` |
| Mobile | `building-native-ui`, `upgrading-expo` |

Source: [skills.sh](https://skills.sh) - Le marketplace officiel

### Vérification visuelle

Ralph inclut maintenant une **vérification visuelle automatique** :
- Ouvre le browser sur localhost
- Screenshot automatique
- Détecte les problèmes visuels
- Corrige automatiquement

Utilise [Browser Use CLI](https://github.com/anthropics/browser-use) ou Chrome MCP.

### Stack par défaut

- **Frontend** : Next.js 14 (App Router) + Tailwind + shadcn/ui
- **Backend** : Supabase (PostgreSQL + Auth + Storage)
- **Infra** : Vercel + Stripe
- **Tests** : Playwright (E2E) + Browser Use (visuel)

---

## Structure

```
bourbon-claude-method/
├── setup.sh                    # Installation automatique
├── templates/commands/         # /start et autres
└── 02-project-setup/
    └── level-3-complete/       # Setup complet
        ├── CLAUDE.md           # Config projet (inclut patterns)
        └── .claude/commands/   # Skills automatisés
```

---

## Philosophie

### Compound Engineering
> "Chaque unité de travail doit rendre les suivantes plus faciles."

Les patterns découverts sont automatiquement documentés dans CLAUDE.md pour que Claude ne répète pas les mêmes erreurs.

### Automatisation Maximale
> "L'utilisateur décrit, Claude exécute."

Pas de questions inutiles. Pas de "tu veux que je...?". Action immédiate.

---

## Cours Premium

Le repo est gratuit et complet. Pour aller plus loin :

**[Bourbon Claude Masterclass](https://bourbonmedia.fr/masterclass)**

- Vidéos tutoriels pas-à-pas
- Projets guidés de A à Z
- Accès communauté privée

---

## Liens

- [Bourbon Media](https://bourbonmedia.fr)
- [Twitter/X](https://twitter.com/simeondrg)
- [YouTube](https://youtube.com/@bourbonmedia)

---

*Créé avec Claude Code à La Réunion*
