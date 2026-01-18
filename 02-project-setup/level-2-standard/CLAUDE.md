# CLAUDE.md - [Nom du Projet]

## Projet

**[Nom]** - [Description en 2-3 phrases]

- **Cible** : [Qui utilise ce produit]
- **Problème** : [Ce que ça résout]

---

## Stack

### Frontend
- Framework : Next.js 14 (App Router)
- Styling : Tailwind CSS
- Components : shadcn/ui
- Icons : Lucide

### Backend
- Database : Supabase
- Auth : Supabase Auth
- API : Next.js API Routes

### Infrastructure
- Hébergement : Vercel
- Domaine : [domaine.com]

---

## Structure

```
src/
├── app/
│   ├── page.tsx           # Homepage
│   ├── layout.tsx         # Layout principal
│   └── api/               # Routes API
├── components/
│   ├── ui/                # shadcn/ui
│   └── [feature]/         # Par fonctionnalité
├── lib/
│   ├── supabase/
│   └── utils/
└── types/
```

---

## Conventions

### Code
- TypeScript strict
- Mobile-first
- Français dans l'UI, anglais dans le code

### Imports (ordre)
```typescript
// 1. React/Next
// 2. Libs externes
// 3. Components internes
// 4. Lib interne
// 5. Types
```

### Commits
```
type(scope): description

Types: feat, fix, docs, style, refactor, test, chore
```

---

## Commandes

```bash
npm run dev        # Développement
npm run build      # Build production
npm run lint       # Linting
npm run typecheck  # Vérification types
```

---

## Variables d'environnement

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
```

---

## Ce que Claude doit faire

- Lire AGENTS.md avant chaque feature
- Utiliser les patterns existants
- Valider avec typecheck + lint
- Commits conventionnels

## Ce que Claude NE doit PAS faire

- Réécrire du code qui fonctionne sans demande
- Ajouter des dépendances sans justification
- Créer de la documentation non demandée
- Over-engineering
