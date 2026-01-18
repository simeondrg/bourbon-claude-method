# 🌐 Workflow Web App

## Vue d'ensemble

Le workflow pour créer une application web dynamique.

**Niveau** : 🟡 Standard
**Durée estimée** : 1-4 semaines
**Stack recommandée** : Next.js + Supabase

---

## Les 5 phases

```
1. Setup (1 jour)
     │
     ▼
2. Structure (1-2 jours)
     │
     ▼
3. Core Features (1-2 semaines)
     │
     ▼
4. Polish (2-3 jours)
     │
     ▼
5. Deploy (1 jour)
```

---

## Phase 1 : Setup

### Objectif
Projet configuré et prêt à développer.

### Actions

```bash
# Créer le projet
npx create-next-app@latest mon-app --typescript --tailwind --app

cd mon-app

# Ajouter les dépendances
npm install @supabase/supabase-js @supabase/ssr
npx shadcn@latest init

# Copier CLAUDE.md et AGENTS.md du Level 2
```

### Avec Claude

```
"Je veux créer [description de l'app].

Stack :
- Next.js 14 App Router
- Supabase pour la BDD
- Tailwind + shadcn/ui

Configure le projet avec la structure standard."
```

### Validation

- [ ] `npm run dev` fonctionne
- [ ] CLAUDE.md créé
- [ ] Supabase connecté

---

## Phase 2 : Structure

### Objectif
Avoir l'architecture de l'app en place.

### Ce qu'on définit

```
src/
├── app/
│   ├── (public)/      # Pages publiques
│   │   └── page.tsx   # Home
│   ├── (auth)/        # Auth pages
│   │   ├── login/
│   │   └── register/
│   └── (app)/         # App protégée
│       ├── layout.tsx
│       └── dashboard/
├── components/
│   ├── ui/            # shadcn
│   └── [feature]/     # Par feature
├── lib/
│   ├── supabase/
│   └── utils.ts
└── types/
```

### Avec Claude

```
"Crée la structure de base avec :
- Layout public (header, footer)
- Layout app (sidebar, navbar)
- Pages placeholder pour : [liste des pages]
- Navigation entre les pages"
```

### Validation

- [ ] Navigation fonctionne
- [ ] Layouts en place
- [ ] Responsive basique

---

## Phase 3 : Core Features

### Objectif
Implémenter les fonctionnalités principales.

### Approche

Pour chaque feature :

```
1. Définir la feature clairement
2. Créer le schéma BDD si nécessaire
3. Implémenter l'UI
4. Connecter au backend
5. Tester
```

### Exemple de prompt

```
"Feature : Liste de tâches

Fonctionnalités :
- Afficher les tâches de l'utilisateur
- Ajouter une nouvelle tâche
- Marquer comme complétée
- Supprimer une tâche

Crée :
1. Table Supabase 'tasks'
2. Composant TaskList
3. Composant AddTask
4. Server actions pour CRUD"
```

### Pattern recommandé

```typescript
// 1. Types
interface Task {
  id: string;
  title: string;
  completed: boolean;
  user_id: string;
}

// 2. Server Actions
// app/(app)/tasks/actions.ts
'use server'

export async function getTasks() { ... }
export async function createTask(title: string) { ... }
export async function toggleTask(id: string) { ... }
export async function deleteTask(id: string) { ... }

// 3. Components
// components/tasks/task-list.tsx
// components/tasks/add-task.tsx

// 4. Page
// app/(app)/tasks/page.tsx
```

### Validation par feature

- [ ] CRUD fonctionne
- [ ] Gestion d'erreurs
- [ ] Loading states
- [ ] Mobile OK

---

## Phase 4 : Polish

### Objectif
Rendre l'app agréable à utiliser.

### Checklist

```
UI/UX :
- [ ] Animations/transitions
- [ ] Empty states
- [ ] Error states
- [ ] Loading skeletons
- [ ] Toast notifications

Mobile :
- [ ] Navigation mobile
- [ ] Touch targets assez grands
- [ ] Pas de scroll horizontal

Performance :
- [ ] Images optimisées
- [ ] Lazy loading
- [ ] LCP < 2.5s
```

### Avec Claude

```
"Améliore l'UX de l'app :
- Ajoute des toasts pour les actions
- Ajoute des loading states
- Améliore les empty states
- Ajoute des animations subtiles"
```

---

## Phase 5 : Deploy

### Objectif
Mettre en production.

### Actions

```bash
# Build test
npm run build

# Si erreurs, corriger

# Deploy
vercel
```

### Configuration Vercel

```
Variables d'environnement :
- NEXT_PUBLIC_SUPABASE_URL
- NEXT_PUBLIC_SUPABASE_ANON_KEY
- SUPABASE_SERVICE_ROLE_KEY (si besoin)
```

### Validation

- [ ] Build passe
- [ ] Deploy OK
- [ ] Test en prod
- [ ] Domaine configuré (optionnel)

---

## Commandes utiles

| Phase | Ce qu'on fait |
|-------|---------------|
| Setup | `npx create-next-app`, config |
| Structure | Architecture, layouts |
| Features | CRUD par feature |
| Polish | UX, animations, mobile |
| Deploy | `vercel` |

---

## Tips

### Garder le contexte

```
"On travaille sur [app].
Feature actuelle : [feature]
Fichiers concernés : [liste]

[Ta demande]"
```

### Itérer rapidement

```
"Ça marche mais :
- [problème 1]
- [problème 2]

Corrige ces points."
```

### Documenter les patterns

Dans AGENTS.md, note les patterns qui marchent bien pour ce projet.

---

## Exemple complet : App de notes

### Setup
```
"Crée une app de notes avec Next.js + Supabase.
Features : créer, lire, modifier, supprimer des notes."
```

### Structure
```
"Structure avec :
- Page d'accueil publique
- Dashboard avec liste des notes
- Page de création/édition
- Sidebar avec navigation"
```

### Feature 1 : Afficher les notes
```
"Affiche les notes de l'utilisateur.
- Liste avec titre + preview
- Tri par date de modification
- Recherche par titre"
```

### Feature 2 : Créer une note
```
"Formulaire de création :
- Titre
- Contenu (textarea)
- Bouton sauvegarder
- Redirection vers la note après création"
```

### Feature 3 : Modifier une note
```
"Page d'édition :
- Charger la note existante
- Modifier titre/contenu
- Auto-save toutes les 30 secondes
- Indicateur 'sauvegardé'"
```

### Feature 4 : Supprimer
```
"Bouton supprimer avec :
- Confirmation modal
- Suppression
- Redirection vers dashboard
- Toast de confirmation"
```

### Polish
```
"Améliore l'UX :
- Empty state 'Pas de notes'
- Loading skeleton
- Animations de liste
- Responsive sidebar"
```

### Deploy
```bash
npm run build
vercel
```

---

## Ressources

- [Next.js App Router](https://nextjs.org/docs/app)
- [Supabase](https://supabase.com/docs)
- [shadcn/ui](https://ui.shadcn.com)
