# CLAUDE.md - [Nom du Projet]

---

## ⛔ RÈGLE IMPORTANTE - LIRE EN PREMIER

**TOUJOURS valider avant de coder.**

Quand l'utilisateur demande une modification :

1. **Analyser** ce qui est demandé
2. **Présenter le plan** (fichiers à modifier, changements prévus)
3. **Attendre validation** de l'utilisateur
4. **Implémenter** seulement après "oui" ou "go"

**POURQUOI ?** Coder sans validation peut :
- Mal interpréter la demande
- Modifier les mauvais fichiers
- Perdre du temps sur une mauvaise direction

**Format de validation :**
```
📋 Modification : {ce que je vais faire}
📁 Fichiers : {liste des fichiers}
✅ Valide ? (oui/non)
```

---

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

## Workflow Git

### Setup initial (une fois)
```bash
git init
gh repo create [nom-projet] --private --source=. --push
```

### Après chaque feature/fix (automatique)
Claude exécute automatiquement :
```
/commit  → commit + push automatique
```

Ou manuellement :
```bash
git add . && git commit -m "type(scope): description" && git push
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
