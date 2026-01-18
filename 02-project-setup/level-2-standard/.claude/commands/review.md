---
name: review
description: "Code review basique avant commit"
---

# Code Review Basique

Review rapide des changements avant commit.

## Usage

```
/review
```

## Workflow

1. **Vérifier les changements**
   ```bash
   git diff --staged
   # ou si rien staged
   git diff
   ```

2. **Exécuter les checks**
   ```bash
   npm run typecheck
   npm run lint
   ```

3. **Review manuelle**
   - Pas de `any` TypeScript
   - Pas de secrets en dur
   - Imports corrects
   - Code lisible

4. **Rapport**
   ```
   ✅ TypeCheck: OK
   ✅ ESLint: OK
   ⚠️ Warnings: [liste si applicable]

   🎯 Verdict: READY TO COMMIT
   ```

## Si problèmes détectés

- TypeScript errors → Corriger avant commit
- ESLint errors → `npm run lint -- --fix`
- Secrets détectés → Supprimer immédiatement

## Après review

```
/commit
```
