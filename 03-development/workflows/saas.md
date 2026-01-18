# 🚀 Workflow SaaS

## Vue d'ensemble

Le workflow complet pour créer un SaaS avec Claude Code.

**Niveau** : 🔴 Complete
**Durée estimée** : 1-6 mois
**Stack recommandée** : Next.js + Supabase + Stripe

---

## Les 6 phases

```
Phase 1: Setup (1-2 jours)
    │
    ▼
Phase 2: Auth & Users (3-5 jours)
    │
    ▼
Phase 3: Core Feature (1-3 semaines)
    │
    ▼
Phase 4: Paiements (3-5 jours)
    │
    ▼
Phase 5: Polish (1 semaine)
    │
    ▼
Phase 6: Launch (1-3 jours)
```

---

## Phase 1 : Setup

### Objectif
Avoir un projet configuré et prêt à développer.

### Actions

```bash
# Créer le projet Next.js
npx create-next-app@latest mon-saas --typescript --tailwind --app

cd mon-saas

# Ajouter Supabase
npm install @supabase/supabase-js @supabase/ssr

# Ajouter shadcn/ui
npx shadcn@latest init

# Copier les fichiers Level 3
# (CLAUDE.md, AGENTS.md, .claude/commands/, tasks/)
```

### Avec Claude

```
"Configure le projet avec :
- Supabase pour l'auth et la BDD
- Structure de dossiers standard
- ESLint + Prettier
- TypeScript strict"
```

### Validation

- [ ] `npm run dev` fonctionne
- [ ] `npm run build` passe
- [ ] CLAUDE.md configuré
- [ ] Git initialisé

---

## Phase 2 : Auth & Users

### Objectif
Permettre aux utilisateurs de s'inscrire et se connecter.

### PRD type

```json
{
  "id": "auth-system",
  "title": "Système d'authentification",
  "stories": [
    {
      "id": "US-001",
      "title": "Page inscription",
      "files": ["src/app/(auth)/register/page.tsx"]
    },
    {
      "id": "US-002",
      "title": "Page connexion",
      "files": ["src/app/(auth)/login/page.tsx"]
    },
    {
      "id": "US-003",
      "title": "Middleware auth",
      "files": ["src/middleware.ts"]
    },
    {
      "id": "US-004",
      "title": "Dashboard protégé",
      "files": ["src/app/(dashboard)/layout.tsx"]
    }
  ]
}
```

### Avec Claude

```
/prd auth-system Système d'authentification complet avec Supabase
```

Puis après validation :

```
/ralph auth-system
```

### Tests E2E à inclure dans le PRD

```json
{
  "tests": [
    "Inscription nouvel utilisateur fonctionne",
    "Connexion utilisateur existant fonctionne",
    "Redirection si non connecté sur /dashboard",
    "Déconnexion vide la session"
  ]
}
```

### Validation

- [ ] `/test auth-system` passe (4/4 tests)
- [ ] `/review` ne montre pas d'issues critiques

---

## Phase 3 : Core Feature

### Objectif
Implémenter LA fonctionnalité principale du SaaS.

### Approche

1. **Identifier** la feature #1 (celle qui justifie le paiement)
2. **Découper** en user stories atomiques
3. **Implémenter** avec Ralph
4. **Itérer** jusqu'à satisfaction

### Exemple : Génération de contenu IA

```
/prd content-generator Génération de contenu avec Claude API
```

### Structure type

```
src/
├── app/
│   └── (dashboard)/
│       └── generate/
│           ├── page.tsx        # UI
│           └── actions.ts      # Server actions
├── lib/
│   └── ai/
│       └── generate.ts         # Logique IA
└── components/
    └── generate/
        ├── form.tsx
        └── result.tsx
```

### Tests E2E à inclure

Définir des tests spécifiques à ta feature. Exemple pour génération de contenu :

```json
{
  "tests": [
    "Génération fonctionne avec prompt valide",
    "Erreur affichée si prompt vide",
    "Loading state pendant génération",
    "Résultat affiché correctement"
  ]
}
```

### Validation

- [ ] `/test [feature-name]` passe
- [ ] `/review` OK
- [ ] Mobile responsive vérifié

---

## Phase 4 : Paiements

### Objectif
Permettre aux utilisateurs de payer.

### PRD type

```json
{
  "id": "stripe-payments",
  "title": "Intégration Stripe",
  "stories": [
    {
      "id": "US-001",
      "title": "Page pricing",
      "files": ["src/app/(marketing)/pricing/page.tsx"]
    },
    {
      "id": "US-002",
      "title": "Checkout Stripe",
      "files": ["src/app/api/stripe/checkout/route.ts"]
    },
    {
      "id": "US-003",
      "title": "Webhooks Stripe",
      "files": ["src/app/api/stripe/webhook/route.ts"]
    },
    {
      "id": "US-004",
      "title": "Gestion abonnement",
      "files": ["src/app/(dashboard)/settings/billing/page.tsx"]
    }
  ]
}
```

### Configuration Stripe

1. Créer compte Stripe
2. Créer produits/prix dans Dashboard
3. Configurer webhooks
4. Ajouter variables d'env

### Tests E2E à inclure

```json
{
  "tests": [
    "Redirection vers Stripe Checkout fonctionne",
    "Webhook stripe reçu et traité",
    "Statut premium reflété dans UI",
    "Accès features premium autorisé"
  ]
}
```

### Validation

- [ ] `/test stripe-payments` passe
- [ ] Webhook testé avec Stripe CLI
- [ ] `/review` OK (sécurité critique ici)

---

## Phase 5 : Polish

### Objectif
Rendre le produit "shippable".

### Checklist

```
/prd polish Amélioration UX et finitions
```

Stories types :
- Landing page attractive
- Onboarding utilisateur
- Emails transactionnels
- Page settings complète
- Footer, mentions légales
- Favicon, OG images

### Tests & Validation

```bash
# Tests E2E complets
/test polish

# Review finale
/review
```

- [ ] Tous les parcours critiques testés
- [ ] Pas d'erreurs console
- [ ] Mobile OK
- [ ] Performance OK (LCP < 2.5s)
- [ ] `/review` ne montre aucune issue

---

## Phase 6 : Launch

### Objectif
Mettre en production.

### Actions

```
/deploy
```

1. **Vérifier** variables d'env production
2. **Déployer** sur Vercel
3. **Configurer** domaine
4. **Activer** Stripe mode live
5. **Tester** parcours complet en prod

### Post-launch

```
/compound [feature-principale]
```

Documenter les learnings pour le prochain projet.

---

## Commandes récapitulatives

| Phase | Workflow complet |
|-------|------------------|
| Setup | `npx create-next-app`, config |
| Auth | `/prd auth` → `/ralph auth` → `/test auth` → `/review` → `/commit` → `/compound` |
| Core | `/prd feature` → `/ralph feature` → `/test feature` → `/review` → `/commit` → `/compound` |
| Paiements | `/prd stripe` → `/ralph stripe` → `/test stripe` → `/review` → `/commit` → `/compound` |
| Polish | `/prd polish` → `/ralph polish` → `/test polish` → `/review` → `/commit` |
| Launch | `/deploy` → `/compound` |

### Workflow par défaut (à mémoriser)

```
/prd → /ralph → /test → /review → /commit → /compound (optionnel)
```

Chaque feature suit ce même cycle. Les tests sont définis dans le PRD et exécutés automatiquement.

### Fast-Track (micro-changements)

Pour les changements triviaux (typo, couleur, texte) :

```
[modifie directement] → /commit
```

### Rollback (bug en prod)

```bash
git revert <commit-hash> && git push origin main
/prd fix-{bug-name}
```

### Types de Tests

| Type | Outil | Usage |
|------|-------|-------|
| E2E | Playwright | Features UI |
| Unitaires | Vitest | Logique métier |
| Intégration | Vitest + MSW | API endpoints |

---

## Ressources

- [Supabase Docs](https://supabase.com/docs)
- [Stripe Docs](https://stripe.com/docs)
- [Next.js Docs](https://nextjs.org/docs)
- [Vercel Docs](https://vercel.com/docs)
