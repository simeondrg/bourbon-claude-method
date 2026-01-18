# ⌨️ Les Commandes Essentielles

## Commandes de base

| Commande | Action |
|----------|--------|
| `/help` | Afficher l'aide |
| `/clear` | Effacer la conversation |
| `/cost` | Voir la consommation tokens |
| `/compact` | Compacter le contexte (économise tokens) |
| `Ctrl+C` | Interrompre Claude |
| `Escape` | Annuler l'action en cours |
| `Shift+Enter` | Nouvelle ligne sans envoyer |

---

## Raccourcis clavier

| Raccourci | Action |
|-----------|--------|
| `↑` | Rappeler le dernier message |
| `Tab` | Autocomplétion |
| `Ctrl+L` | Effacer l'écran |

---

## Commandes de navigation

```bash
# Lancer Claude dans un dossier
cd mon-projet && claude

# Lancer avec un prompt initial
claude "Explique-moi la structure de ce projet"

# Lancer en mode plan (réfléchir avant d'agir)
claude --plan
```

---

## Les Skills (Slash Commands)

Les skills sont des commandes personnalisées qui automatisent des tâches.

### Skills intégrés

```
/commit          # Créer un commit conventionnel
/pr              # Créer une pull request
```

### Skills personnalisés

Tu peux créer tes propres skills dans `.claude/commands/`.

Exemple : `.claude/commands/deploy.md`

```markdown
---
name: deploy
description: "Déployer sur Vercel"
---

# Deploy

Déploie le projet sur Vercel.

## Steps
1. Vérifier que le build passe
2. Lancer `vercel --prod`
3. Confirmer le déploiement
```

Usage : `/deploy`

---

## Gestion du contexte

### Le problème du contexte

Claude a une limite de contexte (~200k tokens). Sur de longues sessions :
- Le contexte se remplit
- Les réponses ralentissent
- Les coûts augmentent

### Solutions

```
/compact     # Résumer et compacter le contexte
/clear       # Effacer complètement (perte d'historique)
```

### Bonne pratique

```
# Toutes les 30-60 minutes de travail
/cost        # Vérifier la consommation
/compact     # Si > $5, compacter
```

---

## Commandes Git intégrées

Claude comprend Git nativement :

```
"Montre-moi les changements non commités"
→ Claude exécute git status et git diff

"Crée un commit pour ces changements"
→ Claude stage, commit avec message conventionnel

"Pousse sur GitHub"
→ Claude push avec vérification
```

### Le skill /commit (recommandé)

```
/commit
```

Claude :
1. Analyse les changements (`git diff`)
2. Génère un message conventionnel
3. Crée le commit
4. Demande confirmation avant push

---

## Commandes de fichiers

```
"Lis le fichier src/app/page.tsx"
→ Claude affiche le contenu

"Crée un nouveau composant Button"
→ Claude crée le fichier avec le code

"Modifie la ligne 45 pour..."
→ Claude édite précisément
```

### Voir les fichiers modifiés

```
"Quels fichiers as-tu modifié ?"
→ Liste des modifications

"Annule les changements sur header.tsx"
→ Restaure le fichier
```

---

## Commandes de recherche

```
"Trouve tous les fichiers qui utilisent useState"
→ Recherche dans le codebase

"Où est définie la fonction generateScript ?"
→ Localise la définition

"Montre-moi la structure du projet"
→ Affiche l'arborescence
```

---

## Commandes avancées

### Mode Plan

```bash
claude --plan
```

Claude réfléchit et propose un plan AVANT d'agir. Utile pour :
- Nouvelles features complexes
- Refactoring important
- Quand tu n'es pas sûr de l'approche

### Modèle spécifique

```bash
claude --model opus    # Pour tâches complexes
claude --model haiku   # Pour tâches simples
```

### Continuer une session

```bash
claude --continue      # Reprendre la dernière session
```

---

## Template de commandes quotidiennes

### Début de journée

```bash
cd mon-projet
claude
```

```
"Rappelle-moi où on en était hier"
```

### Pendant le dev

```
"Implémente [feature]"
"Il y a une erreur : [erreur]"
"Optimise ce code"
```

### Fin de journée

```
/cost                  # Vérifier consommation
/commit                # Commiter les changements
"Résume ce qu'on a fait aujourd'hui"
```

---

## Créer tes propres skills

### Structure d'un skill

`.claude/commands/mon-skill.md` :

```markdown
---
name: mon-skill
description: "Description courte"
---

# Titre du Skill

Description de ce que fait le skill.

## Workflow

1. Étape 1
2. Étape 2
3. Étape 3

## Exemple

\`\`\`
Utilisateur: /mon-skill
Claude: [Ce que Claude fait]
\`\`\`
```

### Skills recommandés pour débuter

| Skill | Usage |
|-------|-------|
| `/commit` | Commits conventionnels |
| `/deploy` | Déploiement |
| `/test` | Lancer les tests |
| `/review` | Code review |

---

## Exercice

### 1. Crée un skill `/bonjour`

```bash
mkdir -p .claude/commands
```

`.claude/commands/bonjour.md` :

```markdown
---
name: bonjour
description: "Salutation personnalisée"
---

# Bonjour

Salue l'utilisateur et résume le projet actuel.

Inclure :
- Nom du projet (depuis package.json)
- Dernière modification
- Tâches en cours (si AGENTS.md existe)
```

### 2. Teste

```bash
claude
/bonjour
```

---

## Prochaine étape

→ [../01-idea-to-plan/01-validate-idea.md](../01-idea-to-plan/01-validate-idea.md) - Valider ton idée
