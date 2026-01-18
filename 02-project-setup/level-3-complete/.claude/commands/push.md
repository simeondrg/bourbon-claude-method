---
name: push
description: "Push les commits vers GitHub avec vérification"
---

# Push vers GitHub

Pousse les commits locaux vers le repo distant avec vérifications.

## Workflow

1. Vérifier qu'on est sur la bonne branche
2. Vérifier qu'il y a des commits à pusher (`git log origin/main..HEAD`)
3. Exécuter `git push origin <branch>`
4. Afficher le lien vers le repo

## Commandes

```bash
# Vérifier la branche
git branch --show-current

# Voir les commits à pusher
git log origin/main..HEAD --oneline

# Push
git push origin $(git branch --show-current)
```

## Si premier push

```bash
git push -u origin $(git branch --show-current)
```

## Si le repo distant n'existe pas

Créer le repo GitHub avec `gh` :

```bash
gh repo create vuvenu-v2 --private --source=. --remote=origin --push
```
