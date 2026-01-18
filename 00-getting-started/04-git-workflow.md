# 🔄 Workflow Git

## Pourquoi Git dès le début ?

- **Sauvegardes** : Jamais perdre ton travail
- **Historique** : Revenir en arrière si besoin
- **Collaboration** : Partager avec d'autres
- **Déploiement** : Vercel/Netlify se connectent à GitHub

---

## Setup initial (une seule fois)

### 1. Créer le repo local

```bash
cd mon-projet

# Initialiser Git
git init

# Premier commit
git add .
git commit -m "feat: initial setup"
```

### 2. Créer le repo GitHub

```bash
# Avec GitHub CLI (recommandé)
gh repo create mon-projet --private --source=. --push

# Ou manuellement :
# 1. Aller sur github.com/new
# 2. Créer le repo
# 3. Suivre les instructions affichées
```

### 3. Vérifier

```bash
git remote -v
# Doit afficher origin → github.com/ton-user/mon-projet
```

---

## Workflow quotidien

### Règle d'or

```
Après chaque tâche significative → commit + push
```

### Ce qui est "significatif"

- ✅ Feature terminée
- ✅ Bug corrigé
- ✅ Refactoring d'un fichier
- ✅ Ajout d'un composant
- ✅ Fin de session de travail

### Ce qui n'est PAS significatif

- ❌ Sauvegarde toutes les 5 minutes
- ❌ Code qui ne compile pas
- ❌ "WIP" sans contexte

---

## Commandes essentielles

### Voir l'état

```bash
git status
```

### Ajouter les changements

```bash
# Tout ajouter
git add .

# Fichiers spécifiques
git add src/components/Button.tsx
```

### Commiter

```bash
# Message court
git commit -m "feat: ajout bouton de connexion"

# Avec Claude
/commit
```

### Pousser sur GitHub

```bash
git push
```

### Workflow complet

```bash
git add .
git commit -m "feat: description"
git push
```

---

## Format des commits

### Conventions

```
type(scope): description courte

Types :
- feat     : nouvelle fonctionnalité
- fix      : correction de bug
- docs     : documentation
- style    : formatage (pas de changement de code)
- refactor : restructuration du code
- test     : ajout de tests
- chore    : maintenance, dépendances
```

### Exemples

```bash
git commit -m "feat(auth): ajout page de connexion"
git commit -m "fix(cart): correction calcul total"
git commit -m "docs: mise à jour README"
git commit -m "refactor(api): simplification routes"
git commit -m "chore: mise à jour dépendances"
```

---

## Avec Claude Code

### Commit automatique

```
/commit
```

Claude analyse les changements et génère un message approprié.

### Après chaque /ralph

```
/ralph auth-system
# ... implémentation ...

# Quand terminé :
/commit
git push
```

### Workflow recommandé

```
1. /prd feature-name
2. /ralph feature-name
3. /commit
4. git push
5. /compound feature-name
```

---

## Branches (optionnel mais recommandé)

### Pour les features importantes

```bash
# Créer une branche
git checkout -b feature/auth-system

# Travailler...
git add .
git commit -m "feat(auth): login page"

# Pousser la branche
git push -u origin feature/auth-system

# Quand terminé, merger dans main
git checkout main
git merge feature/auth-system
git push
```

### Avec Claude

```
/prd auth-system
# Le PRD crée automatiquement la branche feature/auth-system

/ralph auth-system
# Ralph travaille sur cette branche

# Quand terminé :
git checkout main
git merge feature/auth-system
/commit
git push
```

---

## Récupérer le travail sur un autre PC

```bash
# Cloner le repo
git clone https://github.com/ton-user/mon-projet.git

cd mon-projet

# Installer les dépendances
npm install

# Prêt à travailler
```

---

## Erreurs courantes

### "J'ai oublié de commit depuis 3 jours"

```bash
# Pas de panique, commit maintenant
git add .
git commit -m "feat: multiple features (auth, dashboard, settings)"
git push
```

### "J'ai commit un secret"

```bash
# Supprimer le fichier du tracking
git rm --cached .env
echo ".env" >> .gitignore
git commit -m "fix: remove .env from tracking"
git push

# IMPORTANT: Changer les secrets exposés !
```

### "J'ai fait une erreur dans le dernier commit"

```bash
# Modifier le message
git commit --amend -m "nouveau message"

# Ajouter des fichiers oubliés
git add fichier-oublie.ts
git commit --amend --no-edit

# Attention: seulement si pas encore push !
```

---

## Checklist

### Début de projet
- [ ] `git init`
- [ ] `gh repo create` ou création manuelle
- [ ] Premier commit
- [ ] Premier push

### Chaque session
- [ ] `git pull` (si travail sur plusieurs machines)
- [ ] Travailler...
- [ ] `git add . && git commit && git push`

### Fin de feature
- [ ] `/commit` avec message descriptif
- [ ] `git push`
- [ ] Vérifier sur GitHub que c'est bien là
