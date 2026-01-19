---
name: commit
description: "Commit conventionnel avec message structuré"
---

# Commit Conventionnel

Exécute un commit Git avec la convention de messages suivante.

## Convention de Messages

```
<type>(<scope>): <description>

[body optionnel]

[footer optionnel]
```

### Types
- `feat` : Nouvelle fonctionnalité
- `fix` : Correction de bug
- `docs` : Documentation
- `style` : Formatage (pas de changement de code)
- `refactor` : Refactoring sans changement fonctionnel
- `test` : Ajout/modification de tests
- `chore` : Maintenance (deps, config, etc.)

### Scopes (à adapter selon projet)
- `auth` : Authentification
- `api` : Routes API
- `ui` : Composants UI
- `db` : Base de données / migrations
- `config` : Configuration
- `deps` : Dépendances

## Workflow

1. Vérifier le statut git
2. Analyser les changements (git diff --staged ou git diff)
3. Proposer un message de commit approprié
4. Exécuter le commit avec `--no-verify` si les hooks bloquent sur du formatting mineur
5. **Push automatiquement sur GitHub : `git push`**
6. Afficher le résultat
7. **Si sur une feature branch** : Demander "Merger sur main ? (oui/non)"
   - Si oui → `git checkout main && git merge <branch> && git push`
   - Si non → Laisser sur la branche, informer l'utilisateur

## Exemple

```bash
git add .
git commit -m "feat(onboarding): add step indicator component

- Created OnboardingWizard with 4 steps
- Added progress bar animation
- Integrated with Supabase user profile

Co-Authored-By: Claude <noreply@anthropic.com>"
```

## Instructions

Si l'utilisateur ne spécifie pas de message, analyse les fichiers modifiés et propose un message approprié.
