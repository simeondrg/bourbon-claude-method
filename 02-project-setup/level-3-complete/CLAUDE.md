# CLAUDE.md - [Nom du Projet]

## Projet

**[Nom]** : [description en 1 ligne]

- **Cible** : [qui utilise]
- **Stack** : Next.js 14 + Supabase + Vercel + Stripe

## Structure

```
src/
├── app/           # Routes (auth, dashboard, marketing, api)
├── components/    # UI (shadcn) + features
├── lib/           # Supabase, Stripe, utils
├── hooks/
└── types/

tasks/             # PRDs actifs
.claude/rules/     # Règles modulaires (automation, stack, quality, patterns)
```

## Commandes

```bash
npm run dev        # Développement
npm run build      # Build
npm run lint       # Lint
npm run typecheck  # Types
```

## Commandes Claude

| Commande | Action |
|----------|--------|
| `/compact` | Compresser le contexte (libérer tokens) |
| `/usage` | Voir consommation tokens |
| `/context` | Voir tokens utilisés |
| `/clear` | Nouveau départ |

## Raccourcis

| Touche | Action |
|--------|--------|
| `Ctrl+S` | Stash prompt |
| `Ctrl+C` | Interrompre |
| `!` | Autocomplete historique bash |
| `Escape` | Annuler input |

## Variables d'environnement

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
```

---

> Les règles détaillées sont dans `.claude/rules/` :
> - `automation.md` - Comportement auto
> - `stack.md` - Technologies
> - `quality.md` - Standards code
> - `patterns.md` - Patterns découverts (auto-rempli)
