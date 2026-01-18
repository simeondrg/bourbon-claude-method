# /commit - Commit Conventionnel

## Usage

```
/commit
```

Ou avec message :

```
/commit feat: ajout système de paiement
```

---

## Ce que ça fait

1. Analyse les changements (`git diff`)
2. Génère un message de commit conventionnel
3. Exécute le commit
4. **Push automatiquement sur GitHub**

---

## Format du message

```
type(scope): description

[Corps optionnel avec détails]

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Types

| Type | Quand l'utiliser |
|------|-----------------|
| `feat` | Nouvelle fonctionnalité |
| `fix` | Correction de bug |
| `docs` | Documentation |
| `style` | Formatage (pas de changement de code) |
| `refactor` | Refactoring |
| `perf` | Amélioration performance |
| `test` | Ajout/modification de tests |
| `chore` | Maintenance, dépendances |

---

## Exemples

```bash
feat(auth): ajout connexion Google
fix(cart): correction calcul TVA
docs: mise à jour README
refactor(api): simplification routes utilisateur
```

---

## Implémentation

```markdown
# .claude/commands/commit.md

Crée un commit conventionnel et push sur GitHub.

## Étapes

1. Exécute `git diff --staged` et `git diff`
2. Analyse les changements
3. Détermine le type approprié
4. Génère un message clair et concis
5. Exécute `git add .` puis `git commit`
6. Exécute `git push` automatiquement

## Règles

- Message en français ou anglais (selon le projet)
- Description < 50 caractères
- Corps si changements complexes
- Toujours ajouter Co-Authored-By
- Toujours push après commit (sauf si pas de remote)
```
