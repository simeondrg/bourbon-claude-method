# CLAUDE.md - [Nom du Projet]

---

## RÈGLE D'OR : AUTOMATISATION MAXIMALE

**L'utilisateur ne doit JAMAIS deviner quoi faire.**

Quand l'utilisateur dit quelque chose → Claude agit immédiatement.

### Ce que ça signifie concrètement :

| ❌ AVANT (mauvais) | ✅ APRÈS (bon) |
|-------------------|----------------|
| "Tu veux que je crée un PRD ?" | [Crée le PRD] "Voici le plan, j'exécute..." |
| "On continue ?" | [Continue automatiquement] |
| "Valide ce plan ?" | [Exécute] "C'est fait. Prochaine étape..." |
| "Je peux lancer les tests ?" | [Lance les tests] "Tests passés ✅" |

**La seule question autorisée** : Demander des précisions sur le QUOI (la demande), jamais sur le COMMENT (l'exécution).

---

## Projet

**[Nom]** est un [type de produit] qui permet à [cible] de [bénéfice principal].

- **Cible** : [Description précise]
- **Produit** : [Core features]
- **Stack** : Next.js 14 + Supabase + Vercel + Stripe

---

## WORKFLOW AUTOMATIQUE (pas de validation intermédiaire)

```
L'utilisateur demande quelque chose
         │
         ▼
┌─────────────────────────────────────────┐
│  DÉTECTION AUTOMATIQUE DU TYPE          │
└─────────────────────────────────────────┘
         │
         ├── Fast-track? (< 5 lignes) ──→ Edit direct → /commit
         │
         ├── Bug/Erreur? ──→ Debug → Fix → Test → /commit
         │
         ├── Feature? ──→ /prd (silencieux) → /ralph → /commit
         │
         └── Design? ──→ Browser → Analyse → Fix → /commit

         ▼
┌─────────────────────────────────────────┐
│  EXÉCUTION + FEEDBACK VISUEL            │
│  (progress bar, pas de questions)       │
└─────────────────────────────────────────┘
         │
         ▼
    "C'est fait. [résumé]. Autre chose ?"
```

### Mapping Automatique : Ce que dit l'utilisateur → Ce que fait Claude

| L'utilisateur dit | Claude fait (sans demander) |
|-------------------|----------------------------|
| "ajoute X" | PRD → Ralph → Commit |
| "change Y" | Edit direct → Commit |
| "c'est moche" | Browser → Analyse → Design fix |
| "ça marche pas" | Console → Debug → Fix → Test |
| "mets en ligne" | Test → Review → Deploy |
| "j'ai fini" | Security → Review → Commit → PR |
| "fix le bug" | Debug loop jusqu'à résolution |

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
- Browser Testing : Browser Use CLI (`npx browser-use`)

---

## Codebase Patterns

> Cette section se remplit automatiquement via `/compound` après chaque feature significative.
> Claude la lit au début de chaque session pour éviter de répéter les erreurs.

### 🏗️ Architecture Patterns
[Auto-documenté]

### 🎨 UI/UX Patterns
[Auto-documenté]

### 🐛 Gotchas (pièges à éviter)
[Auto-documenté]

### 📝 Conventions établies
[Auto-documenté]

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

tasks/                     # PRDs actifs
└── archive/               # PRDs terminés
```

---

## Conventions

### TypeScript
- Strict mode obligatoire
- Pas de `any` sans justification
- Types explicites sur exports

### Commits (format auto via /commit)
```
feat(scope): description courte

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Commandes

```bash
npm run dev        # Développement
npm run build      # Build
npm run lint       # Lint
npm run typecheck  # Types
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

# Notifications (optionnel)
NTFY_TOPIC=
```

---

## Raccourcis Claude Code

| Raccourci | Action |
|-----------|--------|
| `Ctrl+S` | Stash ton prompt (sauvegarde temporaire) |
| `Ctrl+C` | Interrompre proprement |
| `/clear` | Vider le contexte (nouveau départ) |
| `Escape` | Annuler l'input en cours |

---

## Ce que Claude fait AUTOMATIQUEMENT

- Lire ce fichier au début de chaque session
- Détecter le type de demande et agir immédiatement
- Valider avec typecheck + lint après chaque changement
- Enchaîner les étapes sans demander confirmation
- Proposer la prochaine action logique
- Documenter les nouveaux patterns (section Codebase Patterns)

## Ce que Claude NE fait JAMAIS

- Demander "tu veux que je...?" pour une action évidente
- Attendre une validation pour continuer
- Réécrire du code qui fonctionne sans demande explicite
- Ajouter des features non demandées
- Créer de la documentation non demandée
- Poser plus d'une question à la fois

---

## Fast-Track vs Full Workflow

| Critère | Fast-Track | Full Workflow |
|---------|------------|---------------|
| Lignes modifiées | < 5 | > 5 |
| Fichiers touchés | 1 | > 1 |
| Impact logique | Aucun | Oui |
| Exemple | Typo, couleur, texte | Nouvelle feature |
| Workflow | Edit → /commit | /prd → /ralph → /commit |

**Règle des 5 secondes** : Si tu hésites > 5 secondes sur fast-track ou non → Full Workflow.

---

## Gestion des Erreurs

```
Erreur détectée
     │
     ├── Erreur TypeScript → Fix auto → Retry
     │
     ├── Erreur Lint → Fix auto → Retry
     │
     ├── Erreur Build → Analyser → Fix → Retry
     │
     └── Erreur 3x même → STOP → Demander aide humaine
```

Maximum 3 tentatives automatiques, puis escalade.
