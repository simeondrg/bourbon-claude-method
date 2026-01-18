# Project Setup - Choisir son niveau

## Les 3 niveaux

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  LEVEL 1 - MINIMAL                                              │
│  Pour : Landing pages, sites vitrines, projets rapides          │
│  Durée : 1-3 jours                                              │
│  Fichiers : CLAUDE.md uniquement                                │
│  Skills : Aucun                                                 │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  LEVEL 2 - STANDARD                                             │
│  Pour : Apps web, MVPs, portfolios dynamiques                   │
│  Durée : 1-4 semaines                                           │
│  Fichiers : CLAUDE.md + AGENTS.md                               │
│  Skills : /commit, /review                                      │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  LEVEL 3 - COMPLETE                                             │
│  Pour : SaaS, apps mobiles, projets complexes                   │
│  Durée : 1-6 mois                                               │
│  Fichiers : CLAUDE.md + AGENTS.md + Skills complets             │
│  Skills : /prd, /ralph, /test, /review, /commit, /compound      │
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
│   └─→ LEVEL 1 - MINIMAL
│       - Pas de backend
│       - Pas d'auth
│       - Juste du HTML/CSS/JS
│
├─→ App web avec utilisateurs / MVP / Dashboard
│   │
│   ├─→ < 10 pages/fonctionnalités ?
│   │   └─→ LEVEL 2 - STANDARD
│   │
│   └─→ > 10 pages ou fonctionnalités complexes ?
│       └─→ LEVEL 3 - COMPLETE
│
└─→ SaaS / App mobile / Marketplace / Plateforme
    │
    └─→ LEVEL 3 - COMPLETE
        - Multi-utilisateurs
        - Paiements
        - Features avancées
```

---

## Comparaison détaillée

| Aspect | Minimal | Standard | Complete |
|--------|---------|----------|----------|
| **Fichiers config** | CLAUDE.md | + AGENTS.md | + Skills + PRD |
| **Workflow** | Conversation | + Commits structurés | + Ralph Loop |
| **Planning** | Aucun | Basique | PRD détaillés |
| **Tests** | Aucun | Manuels | Automatisés |
| **Déploiement** | Manuel | Semi-auto | CI/CD |
| **Documentation** | Aucune | README | Complète |
| **Temps setup** | 5 min | 15 min | 30 min |

---

## Workflow par niveau

### Level 1 - Minimal
```
Demande → Claude code → Commit manuel
```

### Level 2 - Standard
```
Demande → Claude code → /review → /commit
```

### Level 3 - Complete
```
/prd → /ralph → /test → /review → /commit → /compound (optionnel)
         ↑         ↑
         └─ fix ───┘
```

---

## Fast-Track (tous niveaux)

Pour les changements triviaux (< 5 lignes, 1 fichier) :
- Modification directe → `/commit` (Level 2-3)
- Pas de PRD nécessaire

**Règle des 5 secondes** : Si tu hésites plus de 5 secondes, ce n'est PAS un fast-track.

---

## Gestion des Branches (Level 3)

| Situation | Branche |
|-----------|---------|
| Feature | `feature/{prd-name}` (créée par `/ralph`) |
| Fast-Track | `main` (direct) |
| Fix urgent | `hotfix/{bug-name}` |

---

## Quick Start par niveau

### Level 1 - Minimal

```bash
mkdir mon-projet && cd mon-projet
cp -r /path/to/bourbon-claude-method/02-project-setup/level-1-minimal/* .
claude
```

### Level 2 - Standard

```bash
mkdir mon-projet && cd mon-projet
cp -r /path/to/bourbon-claude-method/02-project-setup/level-2-standard/* .
cp -r .claude .   # Copie les skills
git init
claude
```

### Level 3 - Complete

```bash
mkdir mon-projet && cd mon-projet
cp -r /path/to/bourbon-claude-method/02-project-setup/level-3-complete/* .
cp -r .claude .   # Copie les skills
git init
npm install       # Si template avec package.json
claude
```

---

## Contenu de chaque niveau

### Level 1 - Minimal
```
level-1-minimal/
└── CLAUDE.md              # Instructions basiques
```

### Level 2 - Standard
```
level-2-standard/
├── CLAUDE.md              # Instructions projet
├── AGENTS.md              # Learnings (vide au départ)
└── .claude/
    └── commands/
        ├── commit.md      # Skill commit
        └── review.md      # Skill review basique
```

### Level 3 - Complete
```
level-3-complete/
├── CLAUDE.md              # Instructions complètes
├── AGENTS.md              # Learnings structurés
├── .claude/
│   └── commands/
│       ├── commit.md      # Commits conventionnels
│       ├── ralph.md       # Ralph Loop
│       ├── prd.md         # Générateur PRD
│       ├── test.md        # Tests complets
│       ├── review.md      # Code review avec scoring
│       ├── compound.md    # Documentation learnings
│       ├── browser.md     # Automatisation navigateur
│       ├── cost-check.md  # Suivi consommation tokens
│       ├── lighthouse.md  # Audit performance
│       └── push.md        # Git push
├── tasks/
│   └── prd-template.json  # Template PRD
└── reference/
    └── DESIGN-SYSTEM.template.md
```

---

## Migration entre niveaux

### De Minimal vers Standard

```bash
# Ajouter AGENTS.md
touch AGENTS.md

# Ajouter les skills
mkdir -p .claude/commands
cp level-2-standard/.claude/commands/*.md .claude/commands/
```

### De Standard vers Complete

```bash
# Ajouter les skills manquants
cp level-3-complete/.claude/commands/*.md .claude/commands/

# Ajouter le dossier tasks
mkdir tasks
cp level-3-complete/tasks/prd-template.json tasks/
```

---

## Prochaines étapes

Choisis ton niveau et suis le guide correspondant :

- → [level-1-minimal/](./level-1-minimal/) - Setup minimal
- → [level-2-standard/](./level-2-standard/) - Setup standard
- → [level-3-complete/](./level-3-complete/) - Setup complet
