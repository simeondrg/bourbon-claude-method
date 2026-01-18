# 🔧 Spécifications Techniques

## De business plan à specs techniques

Tu as maintenant :
- ✅ Idée validée
- ✅ Business Model Canvas
- ✅ Business Plan

**Prochaine étape** : Traduire ça en spécifications techniques pour Claude.

---

## Structure des specs techniques

```
1. Overview du projet
2. Stack technique
3. Architecture
4. Fonctionnalités (User Stories)
5. Design System
6. Intégrations
7. Sécurité
8. Déploiement
```

---

## Générer avec Claude

### Prompt

```markdown
À partir de mon business plan, génère des spécifications techniques
complètes pour le développement.

# Business Plan
[Colle ton business plan ou les parties clés]

# Mes préférences techniques
- Stack préférée : [Next.js/React/Vue/etc.]
- BDD : [Supabase/Firebase/PostgreSQL]
- Hébergement : [Vercel/AWS/autre]
- Budget infra : [Gratuit/Limité/Flexible]

# Mon niveau
- [Débutant/Intermédiaire/Avancé]

# Contraintes
- [Timeline, budget, autres contraintes]

Génère des specs complètes et actionables.
```

---

## Template de specs techniques

### 1. Overview

```markdown
# Spécifications Techniques - [Nom du Projet]

## Vision Produit
[1 paragraphe résumant le produit]

## Objectifs Techniques
- Performance : [LCP < 2.5s, etc.]
- Scalabilité : [X utilisateurs simultanés]
- Disponibilité : [99.9% uptime]

## Contraintes
- Budget : [X€/mois max]
- Timeline : [Livraison Y]
- Équipe : [Solo/Équipe]
```

### 2. Stack Technique

```markdown
## Stack Technique

### Frontend
- Framework : Next.js 14 (App Router)
- Styling : Tailwind CSS + shadcn/ui
- State : React hooks + Context
- Forms : React Hook Form + Zod

### Backend
- Runtime : Node.js (via Next.js API routes)
- BDD : Supabase (PostgreSQL)
- Auth : Supabase Auth
- Storage : Supabase Storage

### Infrastructure
- Hébergement : Vercel
- CDN : Vercel Edge
- Monitoring : Vercel Analytics

### Services Externes
- Paiements : Stripe
- Email : Resend
- IA : Claude API / Gemini API

### Outils Dev
- Package Manager : npm
- Linting : ESLint + Prettier
- Type Checking : TypeScript strict
- Git : GitHub
```

### 3. Architecture

```markdown
## Architecture

### Structure des dossiers
\`\`\`
src/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Routes authentification
│   ├── (dashboard)/       # Routes connectées
│   ├── (marketing)/       # Pages publiques
│   └── api/               # Routes API
├── components/
│   ├── ui/                # Composants génériques
│   └── [feature]/         # Composants par feature
├── lib/
│   ├── supabase/          # Client Supabase
│   ├── stripe/            # Utils Stripe
│   └── utils/             # Helpers
├── hooks/                 # Custom hooks
└── types/                 # Types TypeScript
\`\`\`

### Flux de données
\`\`\`
[User] → [Next.js Frontend] → [API Routes] → [Supabase]
                                    ↓
                              [External APIs]
                              (Stripe, Claude, etc.)
\`\`\`

### Base de données
\`\`\`sql
-- Tables principales
users (id, email, plan, created_at)
[feature_table] (id, user_id, data, created_at)
subscriptions (id, user_id, stripe_id, status)
\`\`\`
```

### 4. Fonctionnalités (User Stories)

```markdown
## Fonctionnalités

### MVP (Phase 1)

#### Auth
- [ ] US-001 : En tant qu'utilisateur, je peux m'inscrire avec email
- [ ] US-002 : En tant qu'utilisateur, je peux me connecter
- [ ] US-003 : En tant qu'utilisateur, je peux réinitialiser mon mot de passe

#### Core Feature
- [ ] US-010 : En tant qu'utilisateur, je peux [action principale]
- [ ] US-011 : En tant qu'utilisateur, je peux [action secondaire]

#### Paiement
- [ ] US-020 : En tant qu'utilisateur, je peux voir les plans
- [ ] US-021 : En tant qu'utilisateur, je peux souscrire à un plan
- [ ] US-022 : En tant qu'utilisateur, je peux gérer mon abonnement

### Phase 2
[...]
```

### 5. Design System

```markdown
## Design System

### Couleurs
\`\`\`css
--primary: #BFFF00;      /* Action principale */
--secondary: #60A5FA;    /* Éléments secondaires */
--background: #FFFBEB;   /* Fond */
--foreground: #0F172A;   /* Texte */
\`\`\`

### Typographie
- Titres : [Font] (font-display)
- Corps : Inter (font-sans)
- Code : JetBrains Mono (font-mono)

### Composants
- Boutons : Utiliser shadcn/ui Button
- Forms : Utiliser shadcn/ui + React Hook Form
- Cards : Utiliser shadcn/ui Card
- Modals : Utiliser shadcn/ui Dialog

### Responsive
- Mobile first
- Breakpoints : sm(640) md(768) lg(1024) xl(1280)
```

### 6. Intégrations

```markdown
## Intégrations

### Supabase
- Auth : Email/Password, Magic Link
- Database : PostgreSQL
- RLS : Activé sur toutes les tables
- Storage : Bucket pour uploads utilisateurs

### Stripe
- Mode : Payment Links + Webhooks
- Produits : [Liste des produits/prix]
- Webhooks :
  - checkout.session.completed
  - customer.subscription.updated
  - customer.subscription.deleted

### Claude API (si applicable)
- Modèle : claude-sonnet-4-20250514
- Rate limiting : [X] requêtes/minute
- Fallback : [Stratégie si API down]
```

### 7. Sécurité

```markdown
## Sécurité

### Authentification
- Sessions : JWT via Supabase
- Tokens : HttpOnly cookies
- Refresh : Automatique

### Autorisation
- RLS : Toutes tables user-facing
- API : Vérification auth sur chaque route

### Data
- Validation : Zod sur tous les inputs
- Sanitization : Escape HTML
- Encryption : HTTPS only

### Secrets
- Stockage : Variables d'environnement
- Jamais en dur dans le code
- .env.local ignoré par Git
```

### 8. Déploiement

```markdown
## Déploiement

### Environnements
- Development : localhost:3000
- Preview : Vercel preview branches
- Production : [domain.com]

### CI/CD
- Push main → Deploy auto Vercel
- PR → Preview deployment

### Variables d'environnement
\`\`\`
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
[AUTRES_APIS]=
\`\`\`

### Monitoring
- Erreurs : Vercel Logs
- Performance : Vercel Analytics
- Uptime : [Service de monitoring]
```

---

## Exemple complet : VuVenu

[Voir `/Users/simeon/projects/vuvenu-v2/reference/foundations/04-TECHNICAL-ARCHITECTURE.md`]

---

## Exercice

### 1. Génère tes specs

```bash
claude
```

```
À partir de mon business plan, génère des spécifications techniques.

[Colle ton business plan]

Stack préférée : Next.js + Supabase + Vercel
Mon niveau : [Ton niveau]
```

### 2. Sauvegarde

Crée `docs/technical-specs.md` dans ton projet.

### 3. Valide avec Claude

```
"Ces specs sont-elles réalistes pour un développeur solo en 4 semaines ?"
"Qu'est-ce que je pourrais simplifier pour le MVP ?"
```

---

## Prochaine étape

Tu as maintenant :
- ✅ Idée validée
- ✅ Business Model Canvas
- ✅ Business Plan
- ✅ Spécifications Techniques

→ [../02-project-setup/README.md](../02-project-setup/README.md) - Configurer ton projet
