# 🛠️ Project Setup - Choisir son niveau

## Les 3 niveaux

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  🟢 LEVEL 1 - MINIMAL                                          │
│  Pour : Landing pages, sites vitrines, projets rapides          │
│  Temps : 1-3 jours                                              │
│  Fichiers : CLAUDE.md uniquement                                │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  🟡 LEVEL 2 - STANDARD                                         │
│  Pour : Apps web, MVPs, portfolios dynamiques                   │
│  Temps : 1-4 semaines                                           │
│  Fichiers : CLAUDE.md + AGENTS.md                               │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  🔴 LEVEL 3 - COMPLETE                                         │
│  Pour : SaaS, apps mobiles, projets complexes                   │
│  Temps : 1-6 mois                                               │
│  Fichiers : CLAUDE.md + AGENTS.md + Skills complets             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Arbre de décision

```
Ton projet c'est quoi ?
│
├─→ Site statique / Landing page / Portfolio simple
│   │
│   └─→ 🟢 LEVEL 1 - MINIMAL
│       - Pas de backend
│       - Pas d'auth
│       - Juste du HTML/CSS/JS
│
├─→ App web avec utilisateurs / MVP / Dashboard
│   │
│   ├─→ < 10 pages/fonctionnalités ?
│   │   └─→ 🟡 LEVEL 2 - STANDARD
│   │
│   └─→ > 10 pages ou fonctionnalités complexes ?
│       └─→ 🔴 LEVEL 3 - COMPLETE
│
└─→ SaaS / App mobile / Marketplace / Plateforme
    │
    └─→ 🔴 LEVEL 3 - COMPLETE
        - Multi-utilisateurs
        - Paiements
        - Features avancées
```

---

## Comparaison détaillée

| Aspect | 🟢 Minimal | 🟡 Standard | 🔴 Complete |
|--------|-----------|-------------|-------------|
| **Fichiers config** | CLAUDE.md | + AGENTS.md | + Skills + PRD |
| **Workflow** | Conversation | + Commits structurés | + Ralph Loop |
| **Planning** | Aucun | Basique | PRD détaillés |
| **Tests** | Aucun | Manuels | Automatisés |
| **Déploiement** | Manuel | Semi-auto | CI/CD |
| **Documentation** | Aucune | README | Complète |
| **Temps setup** | 5 min | 15 min | 30 min |

---

## Quick Start par niveau

### 🟢 Level 1 - Minimal

```bash
# Créer le projet
mkdir mon-projet && cd mon-projet

# Copier le template
cp -r /path/to/bourbon-claude-method/02-project-setup/level-1-minimal/* .

# Lancer Claude
claude
```

### 🟡 Level 2 - Standard

```bash
# Créer le projet
mkdir mon-projet && cd mon-projet

# Copier le template
cp -r /path/to/bourbon-claude-method/02-project-setup/level-2-standard/* .

# Init git
git init

# Lancer Claude
claude
```

### 🔴 Level 3 - Complete

```bash
# Créer le projet
mkdir mon-projet && cd mon-projet

# Copier le template
cp -r /path/to/bourbon-claude-method/02-project-setup/level-3-complete/* .

# Init git
git init

# Installer dépendances (si template avec package.json)
npm install

# Lancer Claude
claude
```

---

## Contenu de chaque niveau

### 🟢 Level 1 - Minimal
```
level-1-minimal/
└── CLAUDE.md              # Instructions basiques
```

### 🟡 Level 2 - Standard
```
level-2-standard/
├── CLAUDE.md              # Instructions projet
├── AGENTS.md              # Learnings (vide au départ)
└── .claude/
    └── commands/
        └── commit.md      # Skill commit basique
```

### 🔴 Level 3 - Complete
```
level-3-complete/
├── CLAUDE.md              # Instructions complètes
├── AGENTS.md              # Learnings structurés
├── .claude/
│   └── commands/
│       ├── commit.md      # Commits conventionnels
│       ├── ralph.md       # Ralph Loop
│       ├── prd.md         # Générateur PRD
│       ├── review.md      # Code review
│       └── compound.md    # Documentation learnings
└── tasks/
    └── prd-template.json  # Template PRD
```

---

## Migration entre niveaux

### De Minimal vers Standard

```bash
# Ajouter AGENTS.md
touch AGENTS.md

# Ajouter le skill commit
mkdir -p .claude/commands
# Copier le commit.md du level-2
```

### De Standard vers Complete

```bash
# Ajouter les skills manquants
# Copier depuis level-3-complete/.claude/commands/

# Ajouter le dossier tasks
mkdir tasks
# Copier le template PRD
```

---

## Prochaines étapes

Choisis ton niveau et suis le guide correspondant :

- → [level-1-minimal/](./level-1-minimal/) - Setup minimal
- → [level-2-standard/](./level-2-standard/) - Setup standard
- → [level-3-complete/](./level-3-complete/) - Setup complet
