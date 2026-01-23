# Règle : Qualité Code

## TypeScript
- Strict mode obligatoire
- Pas de `any` sans justification
- Types explicites sur exports

## Validation automatique
Après chaque modification :
1. `npm run typecheck`
2. `npm run lint`
3. Si erreur → fix auto → retry (max 3x)

## Commits
Format conventionnel :
```
feat(scope): description
fix(scope): description
```

Toujours inclure :
```
Co-Authored-By: Claude <noreply@anthropic.com>
```

## Sécurité
- Jamais de secrets en dur
- Validation Zod côté serveur
- Row Level Security sur Supabase
