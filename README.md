# Bourbon Claude Method

**La méthode complète pour créer n'importe quel projet avec Claude Code - même si tu n'as jamais codé.**

De l'idée au site en ligne, en passant par le développement - un assistant qui te guide pas à pas.

---

## C'est pour qui ?

- **Entrepreneurs** qui veulent créer leur site/app sans coder
- **Créateurs** qui veulent lancer leurs projets rapidement
- **Débutants** qui veulent apprendre en faisant
- **Développeurs** qui veulent accélérer leur workflow

---

## Workflow Principal

```
/prd → /ralph → /test → /review → /commit → /compound (optionnel)
         ↑         ↑
         └─ fix ───┘
```

| Skill | Description |
|-------|-------------|
| `/prd` | Génère un PRD structuré avec User Stories |
| `/ralph` | Implémentation autonome avec quality gates |
| `/test` | Tests complets (typecheck, lint, build, E2E) |
| `/review` | Code review automatique avec scoring |
| `/commit` | Commit conventionnel + push |
| `/compound` | Documente les learnings |

---

## Les 3 Niveaux

| Niveau | Pour qui | Durée | Skills |
|--------|----------|-------|--------|
| **Level 1 - Minimal** | Landing pages, sites vitrines | 1-3 jours | Aucun |
| **Level 2 - Standard** | Apps web, MVPs | 1-4 semaines | `/commit`, `/review` |
| **Level 3 - Complete** | SaaS, apps complexes | 1-6 mois | Tous les skills |

---

## Installation (1 minute)

### Mac/Linux

```bash
git clone https://github.com/simeondrg/bourbon-claude-method.git
cd bourbon-claude-method
./setup.sh
```

### Windows (PowerShell admin)

```powershell
git clone https://github.com/simeondrg/bourbon-claude-method.git
cd bourbon-claude-method
.\setup.ps1
```

Le script installe automatiquement Node.js, Git, GitHub CLI et Claude Code si nécessaire.

---

## Créer un projet (5 minutes)

```bash
mkdir mon-projet
cd mon-projet
claude
/start
```

L'assistant te guide pour le reste.

---

## Types de projets supportés

| Type | Description | Niveau recommandé |
|------|-------------|-------------------|
| Site Vitrine | Restaurant, Portfolio | Level 1 |
| Application Web | Dashboard, Réservations | Level 2 |
| SaaS | Outil de gestion, Formation | Level 3 |
| App Mobile | Application smartphone | Level 3 |

---

## Structure du Framework

```
bourbon-claude-method/
├── setup.sh                    # Installation automatique
├── templates/commands/         # Commandes de l'assistant
├── 00-getting-started/         # Guides d'installation
├── 01-idea-to-plan/            # Valider et planifier ton idée
├── 02-project-setup/           # Configuration par niveau
│   ├── level-1-minimal/        # CLAUDE.md seulement
│   ├── level-2-standard/       # + AGENTS.md + /commit + /review
│   └── level-3-complete/       # + Tous les skills
├── 03-development/             # Workflows de développement
│   ├── workflows/              # Par type de projet
│   └── skills/                 # Documentation des skills
├── 04-launch/                  # Déploiement
└── 05-monetize/                # Monétisation
```

---

## Règles de Workflow

### Fast-Track (micro-changements)

Pour les changements triviaux (< 5 lignes, 1 fichier) :
- Modification directe → `/commit`
- Pas de PRD nécessaire

**Règle des 5 secondes** : Si tu hésites plus de 5 secondes, ce n'est PAS un fast-track.

### Gestion des Branches

| Situation | Branche |
|-----------|---------|
| Feature | `feature/{prd-name}` (créée par `/ralph`) |
| Fast-Track | `main` (direct) |
| Fix urgent | `hotfix/{bug-name}` |

### Rollback (bug en prod)

```bash
git log --oneline -10          # Identifier le commit
git revert <commit-hash>       # Revert
git push origin main           # Push
/prd fix-{bug-name}            # Créer PRD pour le fix
```

---

## Philosophie Compound Engineering

> "Chaque unité de travail doit rendre les suivantes plus faciles."

```
Sans Compound:
Feature 1 → Oubliée
Feature 2 → Mêmes erreurs
Feature 3 → Mêmes erreurs

Avec Compound:
Feature 1 → Learning documenté
Feature 2 → Évite erreur 1
Feature 3 → Capitalise sur 2 learnings
```

Utilise `/compound` après chaque feature significative pour documenter dans AGENTS.md.

---

## Pour les développeurs

### Documentation avancée

- [Commandes essentielles](00-getting-started/03-essential-commands.md)
- [Configuration avancée](00-getting-started/05-advanced-config.md)
- [Skill Ralph (loop autonome)](03-development/skills/ralph.md)
- [Workflow SaaS](03-development/workflows/saas.md)

### Stack recommandée (Level 3)

- **Frontend** : Next.js 14 (App Router) + Tailwind + shadcn/ui
- **Backend** : Supabase (PostgreSQL + Auth + Storage)
- **Infra** : Vercel + Stripe
- **Tests** : Playwright (E2E) + Vitest (Unit)

---

## Cours Premium (bientôt)

Le repo est gratuit et complet. Pour aller plus loin :

**[Bourbon Claude Masterclass](https://bourbonmedia.fr/masterclass)**

- Vidéos tutoriels pas-à-pas
- Projets guidés de A à Z
- Accès communauté privée
- Sessions Q&A live

---

## Contribuer

1. Fork le repo
2. Crée une branche (`git checkout -b feature/amelioration`)
3. Commit (`git commit -m 'Ajout amélioration'`)
4. Push (`git push origin feature/amelioration`)
5. Ouvre une Pull Request

---

## Licence

MIT License - Utilise, modifie, partage librement.

---

## Liens

- [Bourbon Media](https://bourbonmedia.fr) - Mon agence
- [Twitter/X](https://twitter.com/simeondrg) - Updates quotidiens
- [YouTube](https://youtube.com/@bourbonmedia) - Tutoriels vidéo

---

*Créé avec Claude Code à La Réunion*
