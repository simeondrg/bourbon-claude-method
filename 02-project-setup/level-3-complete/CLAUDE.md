# CLAUDE.md - [Nom du Projet]

---

## ⛔ INTERDICTION ABSOLUE - LIRE EN PREMIER

**NE JAMAIS CODER DIRECTEMENT.**

Quand l'utilisateur valide un plan ou dit "exécute", "implémente", "fais-le", "go" :

1. **INVOQUER `/ralph {feature-name}`** - PAS coder soi-même
2. Ralph gère : branche → code → validation → commit → PR

**POURQUOI ?** L'action directe (écrire du code) contourne :
- La création de branche feature
- Les commits atomiques par story
- La PR pour review
- La traçabilité Git

**SI TU ES TENTÉ DE CODER DIRECTEMENT → STOP → INVOQUE LE SKILL**

Cette règle est NON-NÉGOCIABLE. Aucune exception.

---

## Projet

**[Nom]** est un [type de produit] qui permet à [cible] de [bénéfice principal].

- **Cible** : [Description précise]
- **Produit** : [Core features]
- **Stack** : [Technologies principales]

---

## WORKFLOW OBLIGATOIRE : Plan → Implémentation → Tests → Review → Commit

**RÈGLE ABSOLUE** : Pour TOUTE demande de modification, suivre ce workflow en 5 étapes.

### Étape 1 : PLAN avec `/prd`

Dès qu'une modification est demandée :
1. Analyser la demande
2. Explorer le codebase
3. Créer un PRD dans `tasks/prd-{feature}.json` avec :
   - User Stories atomiques
   - **Tests E2E** à exécuter
   - Critères d'acceptation
4. Présenter le plan pour validation

Format :
```
📋 PLAN : {titre}
📝 Description : {description}
📌 User Stories :
- US-001: {titre} → {fichiers}
🧪 Tests E2E :
- {scénario test}
🎯 Critères d'acceptation :
- {critère}

Valide ce plan ? (oui/non/modifier)
```

### Étape 2 : IMPLÉMENTATION avec `/ralph`

```
/ralph {feature-name}
```
- Implémente chaque story
- Quality Gate après chaque story (typecheck + lint)
- Commit après chaque story validée

### Étape 3 : TESTS avec `/test`

```
/test {feature-name}
```
- Lance les tests E2E définis dans le PRD
- Si échec → fix avec `/ralph` → re-test

### Étape 4 : REVIEW avec `/review`

```
/review
```
- Review automatique : sécurité, performance, conventions
- Si issues critiques → fix avant de continuer

### Étape 5 : COMMIT avec `/commit`

```
/commit
```
- Commit final + push + création PR

### Workflow résumé

```
/prd → /ralph → /test → /review → /commit → /compound (optionnel)
         ↑         ↑
         └─ fix ───┘
```

### Fast-Track (micro-changements)

Pour les changements triviaux (< 5 lignes, 1 fichier) :

```
Utilisateur: "Fix le typo"
Claude: [modifie directement] → /commit
```

**Critères** : typo, couleur, texte, pas d'impact logique métier.

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

### Étape 6 (optionnelle) : COMPOUND

```
/compound {feature-name}
```

Documente les learnings dans AGENTS.md après une feature significative.

---

## Types de Tests

| Type | Outil | Usage |
|------|-------|-------|
| **E2E** | Playwright | Features UI, parcours utilisateur |
| **Unitaires** | Vitest | Logique métier, fonctions |
| **Intégration** | Vitest + MSW | API endpoints |

Dans le PRD :
```
🧪 Tests :
- E2E: [scénarios Playwright]
- Unit: [fonctions à tester] (optionnel)
```

---

## Stack Technique

### Frontend
- Framework : Next.js 14 (App Router)
- Styling : Tailwind CSS + shadcn/ui
- Icons : Lucide React

### Backend
- Runtime : Node.js (Next.js API routes)
- Database : Supabase (PostgreSQL)
- Auth : Supabase Auth
- Storage : Supabase Storage

### Infrastructure
- Hébergement : Vercel
- Paiements : Stripe
- IA : [Claude API / Gemini API]

---

## Design System

**IMPORTANT** : Créer `reference/DESIGN-SYSTEM.md` (voir template dans `reference/DESIGN-SYSTEM.template.md`)

### Principe : Choisir un des deux modèles

**Option A - Style Unique** : Même style partout (simple, cohérent)

**Option B - Styles Différenciés** (recommandé pour SaaS) :
| Contexte | Style | Pages |
|----------|-------|-------|
| Marketing | Punchy/Brutal | landing, pricing, about |
| App | Calme/Soft | dashboard, features |

### Couleurs (à définir)
```css
--primary: #[HEX];
--secondary: #[HEX];
--background: #[HEX];
--foreground: #[HEX];
```

### Typographie
- Titres : [Font Display]
- Corps : Inter / System

### Composants
- Utiliser shadcn/ui exclusivement
- Mobile-first toujours
- Respecter le Design System documenté

---

## Structure

```
src/
├── app/
│   ├── (auth)/            # Routes non connectées
│   ├── (dashboard)/       # Routes connectées
│   ├── (marketing)/       # Pages publiques
│   └── api/               # Routes API
├── components/
│   ├── ui/                # shadcn/ui
│   └── [feature]/         # Par feature
├── lib/
│   ├── supabase/
│   ├── stripe/
│   └── utils/
├── hooks/
└── types/
```

---

## Conventions

### TypeScript
- Strict mode obligatoire
- Pas de `any` sans justification
- Types explicites sur exports

### Imports (ordre)
```typescript
// 1. React/Next
// 2. Libs externes
// 3. Components internes
// 4. Lib interne
// 5. Types
```

### Commits
Format conventionnel obligatoire via `/commit`

---

## Commandes

```bash
npm run dev        # Développement
npm run build      # Build
npm run lint       # Lint
npm run typecheck  # Types
```

---

## Workflow Git

### Setup initial (une fois)
```bash
git init
gh repo create [nom-projet] --private --source=. --push
```

### Après chaque feature (AUTOMATIQUE)
`/commit` exécute automatiquement : commit + push

### Workflow complet
```
1. /prd feature-name → crée PRD
2. Valider le plan
3. /ralph feature-name → implémente
4. /commit → commit + push automatique
5. /compound feature-name → documente learnings
```

---

## Variables d'environnement

```bash
# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# Stripe
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=

# IA
ANTHROPIC_API_KEY=
```

---

## Sécurité

- Jamais de secrets côté client
- Validation Zod sur tous les inputs API
- RLS sur toutes les tables utilisateur

---

## Skills Disponibles

| Skill | Usage | Quand l'utiliser |
|-------|-------|------------------|
| `/prd` | Génération PRD structuré avec tests | Toujours en premier |
| `/ralph` | Implémentation autonome | Après validation PRD |
| `/test` | Tests E2E (Playwright) | Après implémentation |
| `/review` | Code review automatique | Avant commit |
| `/commit` | Commit + push + PR | À la fin |
| `/compound` | Documentation learnings | Après feature complète |

### Workflow standard
```
/prd → /ralph → /test → /review → /commit → /compound
```

---

## Ce que Claude doit faire

- Lire AGENTS.md avant chaque feature
- Suivre le workflow Plan → Validation → Ralph
- Valider avec typecheck + lint après chaque changement
- Documenter les nouveaux patterns dans AGENTS.md

## Ce que Claude NE doit PAS faire

- Réécrire du code qui fonctionne sans demande
- Ajouter des features non demandées
- Changer l'architecture sans validation
- Ajouter des dépendances sans justification
- Créer de la documentation non demandée
