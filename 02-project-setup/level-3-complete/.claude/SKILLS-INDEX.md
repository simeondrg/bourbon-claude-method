# SKILLS INDEX - Auto-Application Matrix

Ce fichier définit quand les skills sont automatiquement appliqués selon le contexte.

---

## 🏆 RÈGLE D'OR : Skills Contextuels

> **Au démarrage de chaque projet, installer les skills pertinents selon le type de projet, puis les appeler au fur et à mesure de l'avancée.**

Voir [06-skills-library/](../../../06-skills-library/) pour le catalogue complet.

---

## Skills Internes (Commands Locaux)

| Skill | Déclencheur | Auto-run |
|-------|-------------|----------|
| `/prd` | Demande de nouvelle feature | Non - manuel |
| `/check-stories` | Après `/prd` | Suggéré |
| `/ralph` | Après validation PRD | Non - manuel |
| `/test` | Après `/ralph` | Suggéré |
| `/review` | Avant `/commit` | Suggéré |
| `/security` | Avant `/commit` (quick scan) | Suggéré |
| `/commit` | Changements à commiter | Non - manuel |
| `/compound` | Après feature significative | Suggéré |
| `/extract` | Après debug non-trivial | Suggéré |
| `/qa` | Après deploy | Suggéré |
| `/notify` | Config notifications mobile | Non - one-time setup |

---

## Skills Externes (skills.sh)

### Installation par Type de Projet

```bash
# === TOUJOURS INSTALLER ===
npx skills add vercel-labs/agent-skills      # react, web-design
npx skills add anthropics/skills             # frontend-design, pdf, xlsx...
npx skills add obra/superpowers              # TDD, debugging, planning

# === SaaS ===
npx skills add supabase/agent-skills         # supabase-postgres
npx skills add stripe/ai                     # stripe-best-practices
npx skills add better-auth/skills            # auth

# === MARKETING ===
npx skills add coreyhaines31/marketingskills # seo, copywriting, ads...

# === MOBILE ===
npx skills add expo/skills                   # expo, react-native
npx skills add callstackincubator/agent-skills
```

### Appel Automatique par Contexte

| Contexte détecté | Skill externe à appeler |
|------------------|------------------------|
| Création composant React | `/vercel-react-best-practices` |
| Nouvelle table Supabase | `/supabase-postgres-best-practices` |
| Intégration Stripe | `/stripe-best-practices` |
| Setup authentification | `/better-auth-best-practices` |
| Rédaction copy | `/copywriting` |
| Création Meta Ad | `/paid-ads` |
| Optimisation conversion | `/page-cro` |
| Composant mobile | `/react-native-best-practices` |
| Export PDF/Excel/Word | `/pdf`, `/xlsx`, `/docx` |

---

## Stack-Based Auto-Application

### Next.js Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Création composant | `/vercel-react-best-practices` + Patterns AGENTS.md |
| Route API | `/api-design-principles` + Validation Zod |
| Page avec data | `/tanstack-query` + Loading states |
| Deploy | `/qa` suggéré |

### Supabase Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Nouvelle table | `/supabase-postgres-best-practices` + RLS obligatoire |
| Query complexe | Destructure `{ data, error }` |
| Insert/Update | Validation avant, error handling après |
| Realtime | Vérifier policy SELECT |

### Stripe Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Setup Stripe | `/stripe-best-practices` |
| Webhook | Vérification signature |
| Checkout | Error handling complet |
| Subscription | Idempotency keys |

### Marketing Projects

| Contexte | Skills à appliquer |
|----------|-------------------|
| Landing page | `/page-cro` + `/copywriting` |
| Meta Ads | `/paid-ads` + `/marketing-psychology` |
| Email campaign | `/email-sequence` |
| Launch | `/launch-strategy` |

### Mobile Projects (Expo)

| Contexte | Skills à appliquer |
|----------|-------------------|
| UI native | `/building-native-ui` |
| Data fetching | `/native-data-fetching` |
| Deploy stores | `/expo-deployment` |
| Styling | `/expo-tailwind-setup` |

---

## Trigger Keywords

Quand ces mots apparaissent, suggérer le skill associé :

| Keyword | Skill suggéré |
|---------|---------------|
| "nouvelle feature", "ajouter", "créer" | `/prd` |
| "bug", "erreur", "ne marche pas" | `/systematic-debugging` → `/extract` si résolu |
| "déployer", "production", "live" | `/qa` |
| "commit", "push", "PR" | `/security quick` → `/review` → `/commit` |
| "optimiser", "performance", "lent" | `/lighthouse` |
| "sécurité", "vulnérabilité", "secrets" | `/security` |
| "composant", "react", "tsx" | `/vercel-react-best-practices` |
| "table", "supabase", "bdd" | `/supabase-postgres-best-practices` |
| "paiement", "stripe", "checkout" | `/stripe-best-practices` |
| "marketing", "copy", "landing" | `/copywriting`, `/page-cro` |
| "pub", "ads", "meta" | `/paid-ads` |
| "mobile", "app", "expo" | `/building-native-ui` |
| "pdf", "excel", "document" | `/pdf`, `/xlsx`, `/docx` |

---

## Quality Gates Automatiques

### Avant Commit

```
Changements staged ?
    ↓
Est-ce > 5 lignes ou > 1 fichier ?
    ↓ OUI
Suggérer: /security quick → /review → /commit
```

### Après Debug Significatif (>10 min)

```
Solution trouvée ?
    ↓ OUI
Était-ce non-évident ?
    ↓ OUI
Suggérer: /extract pour sauvegarder le learning
```

### Après Feature Complète

```
Feature mergée ?
    ↓ OUI
A-t-on appris quelque chose de nouveau ?
    ↓ OUI
Suggérer: /compound pour documenter dans AGENTS.md
```

---

## Skill Dependencies

```
/prd
  └── /check-stories (recommandé)
        └── /ralph ─────────────────────────┐
              │                              │
              ├── Skills contextuels:        │
              │   - React: /vercel-react-best-practices
              │   - Supabase: /supabase-postgres-best-practices
              │   - Stripe: /stripe-best-practices
              │   - Mobile: /react-native-best-practices
              │                              │
              ├── 📱 Notifications (ntfy.sh) │
              │   - Start: "🚀 Ralph started"│
              │   - Story done: "✅ X/N"     │
              │   - Complete: "🎉 Done"      │
              │   - Error: "❌ Stuck"        │
              │                              │
              └── /test                      │
                    └── /security quick      │
                          └── /review        │
                                └── /commit  │
                                      │      │
                                      ├──────┘
                                      │
                                      └── /compound (optionnel)
                                      └── /qa (si deploy)
```

---

## File Type Triggers

| Extension | Contexte | Skill externe | Rappel interne |
|-----------|----------|---------------|----------------|
| `.tsx` | React component | `/vercel-react-best-practices` | Mobile-first, TypeScript strict |
| `route.ts` | API route | `/api-design-principles` | Zod validation |
| `.sql` | Migration | `/supabase-postgres-best-practices` | RLS policies |
| `page.tsx` | Page | `/tanstack-query` | Loading/error states |
| `.test.ts` | Test | `/test-driven-development` | Coverage > 80% |

---

## Session Triggers

### Début de Session

1. Lire AGENTS.md (Codebase Patterns en premier)
2. Vérifier PRDs en cours dans `tasks/`
3. Rappeler workflow : `/prd → /ralph → /test → /review → /commit`
4. **Vérifier skills installés** : `ls ~/.claude/skills/`

### Fin de Session

1. Y a-t-il des learnings non documentés ?
   - OUI → Suggérer `/extract` ou `/compound`
2. Y a-t-il des changements non commités ?
   - OUI → Suggérer `/commit`
3. Y a-t-il une feature complète non testée en prod ?
   - OUI → Suggérer `/qa`

---

## Escalation Rules

### Story trop grosse

```
Story > 3 fichiers OU > 50 lignes de changement
    ↓
Suggérer split avant /ralph
```

### Bug critique découvert

```
Bug sévérité CRITICAL
    ↓
Stopper workflow actuel
    ↓
Créer hotfix branch
    ↓
Fix → /test → /review → /commit → Deploy
```

### Build failure répété (3x)

```
Même erreur 3 fois
    ↓
Arrêter loop Ralph
    ↓
Analyser root cause avec /systematic-debugging
    ↓
Possiblement extraire en skill si non-évident
```

---

## Référence

- [06-skills-library/](../../../06-skills-library/) - Catalogue complet des skills
- [skills.sh](https://skills.sh) - Marketplace skills (350+)
