---
description: "Pipeline complet : idée → specs → PRDs → build autonome → verify → ship"
argument-hint: [description du projet en une phrase]
allowed-tools: Read, Write, Edit, Bash(*), Glob, Grep, AskUserQuestion, Task, Skill(*)
model: opus
---

# Full Build - Pipeline Autonome Bourbon-Claude

Orchestre le pipeline complet de la conception au déploiement.

## Input

`$ARGUMENTS` = description du projet en une phrase (ex: "un simulateur de tarifs pour chauffeurs VTC à La Réunion")

## Phase 0 : BRAINSTORM GUIDÉ (avec l'utilisateur)

Poser des questions structurées pour définir le projet. Utiliser AskUserQuestion avec des options A/B/C/D pour réponses rapides.

**Questions obligatoires (max 8) :**
1. Quel problème résout ce projet ? Pour qui ?
2. Comment les utilisateurs résolvent ce problème aujourd'hui ?
3. Modèle de revenus ? (Abonnement / One-time / Freemium / Usage-based)
4. Prix cible et marché (taille estimée) ?
5. Features essentielles pour le MVP (top 3-5) ?
6. Intégrations nécessaires ? (Paiement, Email, Calendrier, Maps, etc.)
7. Type de projet ? (Landing / Webapp / SaaS / Mobile)
8. Deadline ou contrainte de temps ?

Regrouper les questions par 2-3 pour aller vite.

## Phase 1 : SPEC.md (le Mega PRD)

Après les réponses, générer automatiquement `SPEC.md` à la racine du projet :

```markdown
# SPEC - [Nom du Projet]

## Vision
[1 paragraphe : problème, solution, marché]

## Business Model
- Cible : [qui]
- Prix : [combien]
- Modèle : [type]
- Taille marché estimée : [TAM/SAM]

## Stack Technique
- Frontend : Next.js 14 (App Router) + Tailwind + shadcn/ui
- Backend : Supabase (PostgreSQL + Auth + Storage)
- Paiements : Stripe (si applicable)
- Déploiement : Vercel
- [Autres intégrations]

## Architecture
[Schéma des routes, composants principaux, tables BDD]

## Features (ordonnées par priorité)
### Feature 1 : [nom]
[Description courte, 1-2 phrases]
### Feature 2 : [nom]
...

## Non-Goals (Hors MVP)
- [Ce qui est explicitement exclu]

## Schéma Base de Données
[Tables, colonnes principales, relations, RLS]
```

## Phase 2 : DÉCOUPAGE EN SOUS-PRDs

Lire SPEC.md et générer automatiquement des sous-PRDs dans `tasks/` :

- `tasks/prd-001-setup.md` — Scaffolding, BDD, auth
- `tasks/prd-002-[feature-core].md` — Feature principale
- `tasks/prd-003-[feature-2].md` — Feature secondaire
- ...
- `tasks/prd-XXX-landing.md` — Landing page + SEO
- `tasks/prd-XXX-payments.md` — Stripe (si SaaS)

**Règles de découpage :**
- Chaque sous-PRD = 1 session de travail (2-4h max)
- Max 8 user stories par sous-PRD
- Chaque user story doit inclure "npm run typecheck passes"
- Les sous-PRDs sont ordonnés par dépendance (setup first)
- Inclure les critères d'acceptation vérifiables

**Afficher le plan au user :**
```
═══════════════════════════════════════
📋 PLAN DE BUILD - [Nom du Projet]
═══════════════════════════════════════

📄 SPEC.md → Créé ✅

📦 Sous-PRDs générés :
  1. tasks/prd-001-setup.md (4 stories)
  2. tasks/prd-002-core-feature.md (6 stories)
  3. tasks/prd-003-dashboard.md (5 stories)
  4. tasks/prd-004-payments.md (4 stories)
  5. tasks/prd-005-landing.md (3 stories)

⏱️ Estimation : ~[X] stories total
💰 Estimation tokens : ~$[X]

═══════════════════════════════════════

⚠️  CHECKPOINT : Avant de lancer le build autonome,
passe en mode auto-edit pour éviter les prompts de permission :
  → Tape Shift+Tab jusqu'à "auto-edit"

Prêt à lancer le build ? (oui/non)
═══════════════════════════════════════
```

## Phase 3 : BUILD AUTONOME

Après confirmation de l'utilisateur :

### Option A : Séquentiel (< 5 sous-PRDs)

Pour chaque sous-PRD dans l'ordre :
1. Lire le sous-PRD
2. Implémenter chaque user story
3. Après chaque story : `npm run typecheck` (quality gate)
4. Si le typecheck fail 3x : skip et noter dans tasks/lessons.md
5. Commit atomique par sous-PRD complété

### Option B : Agent Teams (>= 5 sous-PRDs)

Proposer une team avec répartition :
- **Teammate 1 (backend)** : setup + BDD + API routes
- **Teammate 2 (frontend)** : composants + pages + UI
- **Teammate 3 (intégrations)** : paiements + email + APIs externes

Chaque teammate reçoit ses sous-PRDs spécifiques dans le prompt de spawn.
Require plan approval pour chaque teammate.
Lead en delegate mode.

### Pendant le build :
- Logger le progrès dans `tasks/build-progress.md`
- Si bloqué 3x sur la même erreur : noter et passer à la suite
- Ne JAMAIS demander de permission pour écrire/éditer du code
- Commiter après chaque sous-PRD terminé

## Phase 4 : VERIFICATION

Après tous les sous-PRDs complétés :

1. `npm run typecheck` — doit passer
2. `npm run lint` — corriger les erreurs
3. `npm run build` — doit compiler
4. Lister les user stories non complétées (s'il y en a)
5. Diff total des changements

**Afficher :**
```
═══════════════════════════════════════
✅ BUILD TERMINÉ - [Nom du Projet]
═══════════════════════════════════════

📊 Résultat :
  ✅ [X]/[Y] sous-PRDs complétés
  ✅ [X]/[Y] user stories implémentées
  ⚠️  [X] stories skippées (voir tasks/lessons.md)

🔍 Vérification :
  ✅ TypeScript : OK
  ✅ Lint : OK
  ✅ Build : OK

📁 Fichiers créés/modifiés : [X]
📝 Commits : [X]

═══════════════════════════════════════

Prochaines étapes :
1. Vérifie visuellement (npm run dev)
2. /deploy quand tu es prêt
3. /compound pour documenter les apprentissages
═══════════════════════════════════════
```

## Phase 5 : COMPOUND

Exécuter automatiquement `/compound` pour :
- Capturer les patterns dans AGENTS.md
- Logger les erreurs rencontrées dans tasks/lessons.md
- Mettre à jour le CLAUDE.md du projet si pertinent

## Règles Globales

- **Jamais de prompt de permission** pendant Phase 3 (le user a confirmé)
- **Quality gate** : typecheck après chaque story, pas juste à la fin
- **Fail fast** : si bloqué 3x, noter et continuer
- **Atomic commits** : un commit par sous-PRD, pas par story
- **Budget** : afficher l'estimation de tokens avant de lancer
- **Pas de micromanagement** : le user ne doit intervenir qu'aux checkpoints
