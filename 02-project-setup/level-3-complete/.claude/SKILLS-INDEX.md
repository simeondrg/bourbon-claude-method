# SKILLS INDEX - Auto-Application Matrix

Ce fichier définit quand les skills sont automatiquement appliqués selon le contexte.

## Workflow Skills

| Skill | Déclencheur | Auto-run |
|-------|-------------|----------|
| `/prd` | Demande de nouvelle feature | Non - manuel |
| `/check-stories` | Après `/prd` | Suggéré |
| `/ralph` | Après validation PRD | Non - manuel |
| `/test` | Après `/ralph` | Suggéré |
| `/review` | Avant `/commit` | Suggéré |
| `/security` | Avant `/commit` (quick scan) | Suggéré |
| `/commit` | Changements à commiter | Non - manuel |
| `/compound` | Après feature significative | Suggéré |
| `/extract` | Après debug non-trivial | Suggéré |
| `/qa` | Après deploy | Suggéré |
| `/notify` | Config notifications mobile | Non - one-time setup |

## Stack-Based Auto-Application

### Next.js Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Création composant | Patterns AGENTS.md, TypeScript strict |
| Route API | Validation Zod, Error handling |
| Page avec data | Loading states, Error boundaries |
| Deploy | `/qa` suggéré |

### Supabase Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Query | Destructure `{ data, error }` |
| Insert/Update | Validation avant, error handling après |
| Nouvelle table | RLS policies obligatoires |
| Realtime | Vérifier policy SELECT |

### Stripe Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Webhook | Vérification signature |
| Checkout | Error handling complet |
| Subscription | Idempotency keys |

## Trigger Keywords

Quand ces mots apparaissent, suggérer le skill associé :

| Keyword | Skill suggéré |
|---------|---------------|
| "nouvelle feature", "ajouter", "créer" | `/prd` |
| "bug", "erreur", "ne marche pas" | Debug → `/extract` si résolu |
| "déployer", "production", "live" | `/qa` |
| "commit", "push", "PR" | `/security quick` → `/review` → `/commit` |
| "optimiser", "performance", "lent" | `/lighthouse` |
| "sécurité", "vulnérabilité", "secrets" | `/security` |

## Quality Gates Automatiques

### Avant Commit

```
Changements staged ?
    ↓
Est-ce > 5 lignes ou > 1 fichier ?
    ↓ OUI
Suggérer: /security quick → /review → /commit
```

### Après Debug Significatif (>10 min)

```
Solution trouvée ?
    ↓ OUI
Était-ce non-évident ?
    ↓ OUI
Suggérer: /extract pour sauvegarder le learning
```

### Après Feature Complète

```
Feature mergée ?
    ↓ OUI
A-t-on appris quelque chose de nouveau ?
    ↓ OUI
Suggérer: /compound pour documenter dans AGENTS.md
```

## Skill Dependencies

```
/prd
  └── /check-stories (recommandé)
        └── /ralph ─────────────────────────┐
              │                              │
              ├── 📱 Notifications (ntfy.sh) │
              │   - Start: "🚀 Ralph started"│
              │   - Story done: "✅ X/N"     │
              │   - Complete: "🎉 Done"      │
              │   - Error: "❌ Stuck"        │
              │                              │
              └── /test                      │
                    └── /security quick      │
                          └── /review        │
                                └── /commit  │
                                      │      │
                                      ├──────┘
                                      │
                                      └── /compound (optionnel)
                                      └── /qa (si deploy)
```

## File Type Triggers

| Extension | Contexte | Rappel |
|-----------|----------|--------|
| `.tsx` | React component | Mobile-first, TypeScript strict |
| `route.ts` | API route | Zod validation, error handling |
| `.sql` | Migration | RLS policies |
| `page.tsx` | Page | Loading/error states |
| `.test.ts` | Test | Coverage > 80% |

## Session Triggers

### Début de Session

1. Lire AGENTS.md (Codebase Patterns en premier)
2. Vérifier PRDs en cours dans `tasks/`
3. Rappeler workflow : `/prd → /ralph → /test → /review → /commit`

### Fin de Session

1. Y a-t-il des learnings non documentés ?
   - OUI → Suggérer `/extract` ou `/compound`
2. Y a-t-il des changements non commités ?
   - OUI → Suggérer `/commit`
3. Y a-t-il une feature complète non testée en prod ?
   - OUI → Suggérer `/qa`

## Escalation Rules

### Story trop grosse

```
Story > 3 fichiers OU > 50 lignes de changement
    ↓
Suggérer split avant /ralph
```

### Bug critique découvert

```
Bug sévérité CRITICAL
    ↓
Stopper workflow actuel
    ↓
Créer hotfix branch
    ↓
Fix → /test → /review → /commit → Deploy
```

### Build failure répété (3x)

```
Même erreur 3 fois
    ↓
Arrêter loop Ralph
    ↓
Analyser root cause
    ↓
Possiblement extraire en skill si non-évident
```
