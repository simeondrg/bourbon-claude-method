# CLAUDE.md - [Nom du Projet]

## Projet

**[Nom]** est un [type de produit] qui permet à [cible] de [bénéfice principal].

- **Cible** : [Description précise]
- **Produit** : [Core features]
- **Stack** : [Technologies principales]

---

## WORKFLOW OBLIGATOIRE : Plan → Validation → Ralph

**RÈGLE ABSOLUE** : Pour TOUTE demande de modification, suivre ce workflow en 2 étapes.

### Étape 1 : PLAN (automatique)

Dès qu'une modification est demandée :
1. Analyser la demande
2. Explorer le codebase
3. Créer un PRD dans `tasks/prd-{feature}.json`
4. Présenter le plan pour validation

Format :
```
📋 PLAN : {titre}
📝 Description : {description}
📌 User Stories :
- US-001: {titre} → {fichiers}
🎯 Critères d'acceptation :
- {critère}

Valide ce plan ? (oui/non/modifier)
```

### Étape 2 : RALPH (après validation)

```
/ralph {feature-name}
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

### Couleurs
```css
--primary: #[HEX];
--secondary: #[HEX];
--background: #[HEX];
--foreground: #[HEX];
```

### Typographie
- Titres : [Font]
- Corps : Inter

### Composants
- Utiliser shadcn/ui exclusivement
- Mobile-first toujours

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

### Après chaque feature (OBLIGATOIRE)
```bash
# Après /ralph complété :
/commit
git push
```

### Workflow complet
```
1. /prd feature-name → crée PRD
2. Valider le plan
3. /ralph feature-name → implémente
4. /commit → commit conventionnel
5. git push → sauvegarde GitHub
6. /compound feature-name → documente learnings
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

| Skill | Usage |
|-------|-------|
| `/commit` | Commit conventionnel |
| `/ralph` | Exécution PRD autonome |
| `/prd` | Génération PRD structuré |
| `/review` | Code review |
| `/compound` | Documentation learnings |
| `/test` | Suite de tests |

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
