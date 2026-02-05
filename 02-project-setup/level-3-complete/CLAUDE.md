# CLAUDE.md - [Nom du Projet]
# Bourbon-Claude v2.2

## Projet
**[Nom]** : [description en 1 ligne]
- **Cible** : [qui utilise]
- **Stack** : Next.js 14 + Supabase + Vercel + Stripe

## Workflow Orchestration

### 1. Plan Mode Default
- Plan mode pour TOUTE tâche non-triviale (3+ étapes)
- Si ça dérape, STOP et re-plan immédiatement

### 2. Subagent Strategy
- Subagents pour garder le contexte principal propre
- Une tâche par subagent pour exécution focalisée

### 3. Self-Improvement Loop
- Après TOUTE correction : mettre à jour `tasks/lessons.md`
- Relire les leçons en début de session

### 4. Verification Before Done
- Ne jamais marquer terminé sans prouver que ça fonctionne
- Diff main vs changements quand pertinent

### 5. Demand Elegance (Équilibré)
- Non-trivial : "y a-t-il un moyen plus élégant ?"
- Simple/évident : ne pas over-engineer

### 6. Autonomous Bug Fixing
- Bug report → juste fixer. Pas de hand-holding

## Conventions
- TypeScript strict, Mobile-first, Français dans UI
- shadcn/ui, Tailwind uniquement, Server Components par défaut
- Jamais de secrets en dur, Validation Zod serveur, RLS Supabase
- LCP < 2.5s, CLS < 0.1

## Compound Engineering
**Où codifier** :
- `AGENTS.md` : guidance projet-wide
- `tasks/lessons.md` : erreurs à ne plus répéter
- `tasks/todo.md` : plan avec items cochables
- Tests : transformer bugs en tests de régression

## Skills Auto-Invocation
| Contexte | Skill |
|----------|-------|
| Composant React | `/vercel-react-best-practices` |
| Table Supabase | `/supabase-postgres-best-practices` |
| Paiement Stripe | `/stripe-best-practices` |
| Tests | `/test-driven-development` |
| Auth | `/better-auth-best-practices` |
| Debug complexe | `/systematic-debugging` |
| Fin de feature | `/verification-before-completion` |

## Commandes Projet
| Commande | Action |
|----------|--------|
| `/full-build [description]` | Pipeline complet idée → ship |
| `/prd [feature]` | Générer un PRD structuré |
| `/ralph [feature]` | Build autonome depuis PRD |
| `/commit` | Commit conventionnel |
| `/deploy` | Déployer sur Vercel |
| `/compound [feature]` | Documenter les apprentissages |
