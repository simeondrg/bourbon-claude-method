---
name: commit
description: "Commit conventionnel avec message structure"
---

# Commit Conventionnel

Crée un commit avec un message structuré suivant les conventions.

## Format

```
type(scope): description courte

[Corps optionnel]

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Types

| Type | Usage |
|------|-------|
| `feat` | Nouvelle fonctionnalité |
| `fix` | Correction de bug |
| `docs` | Documentation |
| `style` | Formatting, pas de changement logique |
| `refactor` | Refactoring sans ajout de feature |
| `test` | Ajout de tests |
| `chore` | Maintenance, dépendances |

## Workflow

1. Vérifier les changements : `git status`
2. Analyser le diff : `git diff`
3. Proposer un message adapté
4. Demander confirmation
5. Exécuter : `git add . && git commit`
6. **Push automatique : `git push`**

## Règles

- Message en anglais ou français (selon projet)
- Description < 50 caractères
- Scope optionnel mais recommandé
- Pas de point final dans la description
- **Toujours push après commit**
