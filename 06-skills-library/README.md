# Skills Library - Bourbon Claude Method

> **Règle d'Or** : Au démarrage de chaque projet, installer les skills pertinents selon le type de projet, puis les appeler au fur et à mesure de l'avancée.

## Principe

Les skills de [skills.sh](https://skills.sh) sont des **capacités réutilisables** qui augmentent Claude avec des connaissances procédurales spécialisées.

```
1. DÉTECTION    → Identifier le type de projet (SaaS, landing, mobile, marketing)
2. INSTALLATION → Installer le bundle de skills correspondant
3. APPEL        → Invoquer /skill-name quand le contexte l'exige
4. COMPOUND     → Les learnings enrichissent AGENTS.md
```

---

## Installation Rapide

### Bundle CORE (Toujours installer)

```bash
npx skills add vercel-labs/agent-skills
npx skills add anthropics/skills
npx skills add obra/superpowers
```

**Skills inclus** : `vercel-react-best-practices`, `web-design-guidelines`, `frontend-design`, `pdf`, `xlsx`, `docx`, `pptx`, `brainstorming`, `test-driven-development`, `systematic-debugging`...

### Bundles par Type de Projet

| Type | Commande |
|------|----------|
| **SaaS** | `npx skills add supabase/agent-skills && npx skills add stripe/ai && npx skills add better-auth/skills` |
| **Marketing** | `npx skills add coreyhaines31/marketingskills` |
| **Mobile** | `npx skills add expo/skills && npx skills add callstackincubator/agent-skills` |
| **Sécurité** | `npx skills add trailofbits/skills` |

---

## Catalogue Complet par Catégorie

### Frontend / React / Next.js

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `vercel-react-best-practices` | vercel-labs/agent-skills | 34.5K | **Chaque composant React** |
| `web-design-guidelines` | vercel-labs/agent-skills | 26.2K | Principes design web |
| `frontend-design` | anthropics/skills | 5.2K | Design composants |
| `nextjs-app-router-patterns` | wshobson/agents | 179 | Routes App Router |
| `shadcn-ui` | giuseppe-trisciuoglio/developer-kit | 220 | Composants shadcn |
| `tailwind-design-system` | wshobson/agents | 262 | Système design |
| `tailwind-v4-shadcn` | jezweb/claude-skills | 126 | Config Tailwind v4 |
| `tanstack-query` | jezweb/claude-skills | 200 | Data fetching client |
| `responsive-design` | wshobson/agents | 178 | Mobile-first |
| `typescript-advanced-types` | wshobson/agents | 287 | Types complexes |

**Installation** :
```bash
npx skills add vercel-labs/agent-skills
npx skills add anthropics/skills
npx skills add wshobson/agents
npx skills add jezweb/claude-skills
npx skills add giuseppe-trisciuoglio/developer-kit
```

---

### Database / Supabase

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `supabase-postgres-best-practices` | supabase/agent-skills | 909 | **Chaque table/RLS** |
| `postgresql-table-design` | wshobson/agents | 229 | Design schéma |
| `sql-optimization-patterns` | wshobson/agents | 180 | Requêtes performantes |
| `database-migration` | wshobson/agents | 121 | Migrations |

**Installation** :
```bash
npx skills add supabase/agent-skills
```

---

### Authentification

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `better-auth-best-practices` | better-auth/skills | 1.9K | Setup auth |
| `create-auth-skill` | better-auth/skills | 990 | Auth custom |

**Installation** :
```bash
npx skills add better-auth/skills
```

---

### Paiements / Stripe

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `stripe-best-practices` | stripe/ai | 167 | **Intégration Stripe** |
| `upgrade-stripe` | stripe/ai | 94 | Migration API |
| `stripe-integration` | wshobson/agents | 139 | Patterns Stripe |

**Installation** :
```bash
npx skills add stripe/ai
```

---

### Marketing Digital

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `seo-audit` | coreyhaines31/marketingskills | 1.8K | Audit SEO |
| `copywriting` | coreyhaines31/marketingskills | 1.6K | Rédaction copy |
| `marketing-psychology` | coreyhaines31/marketingskills | 1.3K | Psychologie vente |
| `programmatic-seo` | coreyhaines31/marketingskills | 1.2K | SEO programmatique |
| `marketing-ideas` | coreyhaines31/marketingskills | 1.1K | Brainstorm marketing |
| `social-content` | coreyhaines31/marketingskills | 1.1K | Posts réseaux |
| `copy-editing` | coreyhaines31/marketingskills | 1.0K | Édition copy |
| `pricing-strategy` | coreyhaines31/marketingskills | 1.0K | Stratégie prix |
| `launch-strategy` | coreyhaines31/marketingskills | 978 | Plan lancement |
| `page-cro` | coreyhaines31/marketingskills | 965 | Optimisation conversion |
| `email-sequence` | coreyhaines31/marketingskills | 891 | Séquences email |
| `paid-ads` | coreyhaines31/marketingskills | 879 | **Meta Ads** |
| `signup-flow-cro` | coreyhaines31/marketingskills | 865 | Funnel inscription |
| `referral-program` | coreyhaines31/marketingskills | 835 | Programme parrainage |
| `ab-test-setup` | coreyhaines31/marketingskills | 814 | Tests A/B |
| `analytics-tracking` | coreyhaines31/marketingskills | 936 | Setup analytics |
| `competitor-alternatives` | coreyhaines31/marketingskills | 939 | Analyse concurrence |

**Installation** :
```bash
npx skills add coreyhaines31/marketingskills
```

---

### Mobile / Expo / React Native

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `building-native-ui` | expo/skills | 2.4K | UI native |
| `upgrading-expo` | expo/skills | 2.0K | Mise à jour Expo |
| `native-data-fetching` | expo/skills | 1.9K | Fetch data mobile |
| `expo-dev-client` | expo/skills | 1.8K | Dev client |
| `expo-deployment` | expo/skills | 1.7K | Déploiement stores |
| `expo-api-routes` | expo/skills | 1.7K | API routes Expo |
| `expo-tailwind-setup` | expo/skills | 1.6K | Tailwind + Expo |
| `expo-cicd-workflows` | expo/skills | 1.6K | CI/CD mobile |
| `use-dom` | expo/skills | 1.5K | DOM dans RN |
| `react-native-best-practices` | callstackincubator/agent-skills | 1.5K | Patterns RN |

**Installation** :
```bash
npx skills add expo/skills
npx skills add callstackincubator/agent-skills
```

---

### Productivité Dev

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `brainstorming` | obra/superpowers | 920 | Idéation |
| `test-driven-development` | obra/superpowers | 695 | TDD |
| `systematic-debugging` | obra/superpowers | 680 | Debug méthodique |
| `writing-plans` | obra/superpowers | 617 | Rédiger plans |
| `executing-plans` | obra/superpowers | 608 | Exécuter plans |
| `verification-before-completion` | obra/superpowers | 565 | QA avant merge |
| `dispatching-parallel-agents` | obra/superpowers | 534 | Agents parallèles |
| `requesting-code-review` | obra/superpowers | 556 | Demander review |
| `receiving-code-review` | obra/superpowers | 515 | Recevoir review |
| `using-git-worktrees` | obra/superpowers | 511 | Git worktrees |
| `finishing-a-development-branch` | obra/superpowers | 467 | Finaliser branche |

**Installation** :
```bash
npx skills add obra/superpowers
```

---

### Documents / Exports

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `pdf` | anthropics/skills | 1.1K | Générer PDF |
| `pptx` | anthropics/skills | 949 | Créer présentation |
| `xlsx` | anthropics/skills | 940 | Export Excel |
| `docx` | anthropics/skills | 890 | Document Word |

**Installation** :
```bash
npx skills add anthropics/skills
```

---

### Testing / QA

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `webapp-testing` | anthropics/skills | 797 | Tests E2E |
| `e2e-testing-patterns` | wshobson/agents | 163 | Patterns E2E |
| `javascript-testing-patterns` | wshobson/agents | 146 | Tests JS |

---

### Sécurité

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `ask-questions-if-underspecified` | trailofbits/skills | 160 | Clarifier specs |
| `semgrep` | trailofbits/skills | 130 | Analyse statique |
| `secure-workflow-guide` | trailofbits/skills | 122 | Workflow sécurisé |
| `property-based-testing` | trailofbits/skills | 120 | Tests propriétés |
| `codeql` | trailofbits/skills | 120 | CodeQL |

**Installation** :
```bash
npx skills add trailofbits/skills
```

---

### Vidéo / Remotion

| Skill | Repo | Installs | Usage |
|-------|------|----------|-------|
| `remotion-best-practices` | remotion-dev/skills | 14.8K | Vidéo programmatique |

**Installation** :
```bash
npx skills add remotion-dev/skills
```

---

## Matrice Installation × Type de Projet

| Bundle | SaaS | Landing | Mobile | Marketing |
|--------|:----:|:-------:|:------:|:---------:|
| vercel-labs/agent-skills | ✅ | ✅ | - | - |
| anthropics/skills | ✅ | ✅ | ✅ | ✅ |
| obra/superpowers | ✅ | ✅ | ✅ | ✅ |
| supabase/agent-skills | ✅ | - | ✅ | - |
| stripe/ai | ✅ | - | ✅ | - |
| better-auth/skills | ✅ | - | ✅ | - |
| coreyhaines31/marketingskills | ✅ | ✅ | - | ✅ |
| expo/skills | - | - | ✅ | - |
| callstackincubator/agent-skills | - | - | ✅ | - |
| remotion-dev/skills | - | - | - | ✅ |
| trailofbits/skills | ✅ | - | - | - |

---

## Appel Automatique (Logique Contextuelle)

Claude doit **proactivement** suggérer/utiliser les skills :

| Contexte détecté | Skill à appeler |
|------------------|-----------------|
| Création composant React | `/vercel-react-best-practices` |
| Nouvelle table Supabase | `/supabase-postgres-best-practices` |
| Intégration paiement | `/stripe-best-practices` |
| Écriture tests | `/test-driven-development` |
| Rédaction copy marketing | `/copywriting` |
| Création Meta Ad | `/paid-ads` |
| Setup authentification | `/better-auth-best-practices` |
| Optimisation landing | `/page-cro` |
| Debug complexe | `/systematic-debugging` |
| Fin de feature | `/verification-before-completion` |
| Composant mobile | `/react-native-best-practices` |
| Export document | `/pdf`, `/xlsx`, `/docx`, `/pptx` |

---

## Voir aussi

- [skills.sh](https://skills.sh) - Catalogue complet (350+ skills)
- [02-project-setup/](../02-project-setup/) - Templates CLAUDE.md par niveau
- [03-development/](../03-development/) - Workflows par type de projet
