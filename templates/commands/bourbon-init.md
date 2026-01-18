---
name: bourbon-init
description: "Initialise un projet Bourbon avec tout le nécessaire"
argument-hint: [type] (landing|webapp|saas|mobile)
allowed-tools: Bash(*), Write(*), Edit(*), Read(*), Glob(*), Grep(*)
---

# Bourbon Init - Initialisation Automatique

Tu initialises un projet complet pour un débutant. Chaque action doit être expliquée simplement.

## Arguments

- `$1` : Type de projet (landing, webapp, saas, mobile)

## Workflow d'Initialisation

### Phase 1 : Préparation (toujours afficher le progrès)

```
════════════════════════════════════════════════
🚀 INITIALISATION DU PROJET
════════════════════════════════════════════════

📦 Type : [TYPE]
📁 Dossier : [DOSSIER ACTUEL]

Je prépare tout... Ça prend environ 2 minutes.
Tu n'as rien à faire, regarde juste la magie opérer ! ✨

[████░░░░░░░░░░░░░░░░] 20% - Vérification des outils...
```

### Phase 2 : Actions selon le type

#### Si TYPE = "landing" (Site Vitrine)

1. **Créer le projet Next.js**
```bash
npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm
```

Afficher :
```
[████████░░░░░░░░░░░░] 40% - Création du projet...

💡 Ce que je fais : Je crée la structure de base de ton site.
   Next.js est un outil qui permet de faire des sites web modernes.
   Tailwind CSS permet de le rendre joli facilement.
```

2. **Installer les composants UI**
```bash
npx shadcn@latest init -d
npx shadcn@latest add button card
```

Afficher :
```
[████████████░░░░░░░░] 60% - Installation des composants...

💡 Ce que je fais : J'ajoute des "briques" réutilisables
   (boutons, cartes, formulaires) pour construire ton site.
```

3. **Créer la structure Bourbon**
- `.claude/commands/commit.md` (commit simplifié)
- `.claude/commands/deploy.md` (déploiement guidé)
- `.claude/commands/help.md` (aide contextuelle)
- `CLAUDE.md` (configuration projet)
- `AGENTS.md` (mémoire du projet)

4. **Créer la page d'accueil de base**

```
[████████████████░░░░] 80% - Création de la première page...
```

5. **Initialiser Git**
```bash
git init
git add .
git commit -m "feat: initial setup with Bourbon Claude Method"
```

```
[████████████████████] 100% - Terminé !
```

#### Si TYPE = "webapp" (Application Web)

Même process que landing, plus :
- Supabase setup (auth + database)
- Pages de login/register
- Layout avec navigation
- Middleware d'authentification

#### Si TYPE = "saas" (SaaS)

Même process que webapp, plus :
- Stripe setup (paiements)
- Plans de pricing
- Page de pricing
- Gestion des abonnements
- Dashboard utilisateur

#### Si TYPE = "mobile" (Application Mobile)

```bash
npx create-expo-app . --template blank-typescript
```

Plus :
- Navigation configurée
- Écrans de base
- Configuration iOS/Android

### Phase 3 : Message de fin

```
════════════════════════════════════════════════
🎉 TON PROJET EST PRÊT !
════════════════════════════════════════════════

✅ Structure créée
✅ Outils installés
✅ Première page prête
✅ Git initialisé

📁 Fichiers créés :
   └─ src/app/page.tsx      → Ta page d'accueil
   └─ src/components/       → Tes composants
   └─ CLAUDE.md             → Configuration pour moi
   └─ .claude/commands/     → Commandes personnalisées

════════════════════════════════════════════════

🎬 PROCHAINE ÉTAPE : Voir ton site !

Je vais lancer le serveur de développement.
Ton site sera visible à l'adresse : http://localhost:3000

Tape "ok" et je lance tout !
```

### Phase 4 : Lancement du serveur

Quand l'utilisateur dit ok :

```bash
npm run dev
```

Afficher :
```
🌐 TON SITE EST EN LIGNE !

Ouvre ton navigateur et va sur :
👉 http://localhost:3000

Tu devrais voir ta page d'accueil.

════════════════════════════════════════════════

📝 PROCHAINES ÉTAPES POSSIBLES :

1. "Modifie le texte de la page d'accueil"
2. "Ajoute une section À propos"
3. "Change les couleurs du site"
4. "Ajoute un formulaire de contact"

Dis-moi ce que tu veux faire, je m'en occupe ! 😊
```

## Fichiers à créer

### CLAUDE.md (adapté au type)

```markdown
# CLAUDE.md - [Nom du Projet]

## Projet

Ce projet a été créé avec la Bourbon Claude Method.

- **Type** : [TYPE]
- **Créé le** : [DATE]
- **Stack** : Next.js 14 + Tailwind CSS + shadcn/ui

## Commandes disponibles

| Commande | Description |
|----------|-------------|
| `/help` | Aide et suggestions |
| `/commit` | Sauvegarder les changements |
| `/deploy` | Mettre en ligne |

## Comment ça marche

Ce fichier m'aide à comprendre ton projet.
Tu n'as pas besoin de le modifier - je le fais automatiquement.

## Règles

- Je t'explique tout ce que je fais
- Je demande confirmation avant les actions importantes
- Je célèbre chaque victoire avec toi ! 🎉
```

### .claude/commands/help.md

```markdown
---
name: help
description: "Aide contextuelle pour le projet"
---

# Aide Bourbon

Affiche une aide adaptée au contexte actuel.

## Réponse

```
🆘 AIDE - QUE VEUX-TU FAIRE ?

📝 MODIFIER LE CONTENU
   → "Change le titre en..."
   → "Ajoute un paragraphe sur..."
   → "Mets une image de..."

🎨 MODIFIER L'APPARENCE
   → "Change la couleur en..."
   → "Rends le bouton plus grand"
   → "Centre ce texte"

➕ AJOUTER DES ÉLÉMENTS
   → "Ajoute un formulaire de contact"
   → "Crée une page À propos"
   → "Mets un menu de navigation"

🚀 METTRE EN LIGNE
   → Tape "/deploy" quand tu es prêt

💾 SAUVEGARDER
   → Tape "/commit" pour sauvegarder ton travail

💡 ASTUCE : Décris simplement ce que tu veux,
   je me charge de le faire !
```
```

### .claude/commands/commit.md

```markdown
---
name: commit
description: "Sauvegarde simplifiée pour débutants"
allowed-tools: Bash(git *)
---

# Sauvegarde des changements

Sauvegarde le travail de l'utilisateur de manière simple.

## Workflow

1. Afficher :
```
💾 SAUVEGARDE EN COURS...

Je sauvegarde tout ton travail.
```

2. Exécuter :
```bash
git add .
git status
```

3. Analyser les changements et créer un message simple

4. Afficher :
```
📝 Voici ce que j'ai sauvegardé :
[LISTE DES FICHIERS MODIFIÉS EN LANGAGE SIMPLE]

Message de sauvegarde : "[MESSAGE]"

Je sauvegarde ? (oui/non)
```

5. Si oui :
```bash
git commit -m "[MESSAGE]"
```

6. Afficher :
```
✅ SAUVEGARDE RÉUSSIE !

Ton travail est en sécurité.
Tu peux continuer à modifier ton site.

💡 Pour mettre en ligne : tape "/deploy"
```
```

### .claude/commands/deploy.md

```markdown
---
name: deploy
description: "Déploiement guidé sur Vercel"
allowed-tools: Bash(*)
---

# Déploiement sur Vercel

Guide l'utilisateur pour mettre son site en ligne.

## Workflow

1. Vérifier si Vercel CLI est installé :
```bash
command -v vercel
```

2. Si pas installé :
```
🌐 MISE EN LIGNE

Pour mettre ton site en ligne, on va utiliser Vercel.
C'est gratuit et très simple !

Étape 1 : J'installe l'outil nécessaire...
```

```bash
npm install -g vercel
```

3. Vérifier si connecté :
```bash
vercel whoami
```

4. Si pas connecté :
```
Étape 2 : Connexion à Vercel

Tu vas voir une page s'ouvrir dans ton navigateur.
Crée un compte (c'est gratuit) ou connecte-toi.

Je lance la connexion...
```

```bash
vercel login
```

5. Une fois connecté :
```
Étape 3 : Mise en ligne !

Je mets ton site en ligne. Ça prend environ 1 minute...
```

```bash
vercel --prod
```

6. Afficher le résultat :
```
════════════════════════════════════════════════
🎉 TON SITE EST EN LIGNE !
════════════════════════════════════════════════

🌐 Adresse de ton site :
   👉 [URL VERCEL]

Tu peux partager ce lien avec tout le monde !

════════════════════════════════════════════════

💡 PROCHAINES ÉTAPES :

1. Ajouter un nom de domaine personnalisé
   → "Comment ajouter mon propre nom de domaine ?"

2. Continuer à modifier le site
   → Les modifications seront automatiquement en ligne

Félicitations ! 🎊
```
```

## Messages d'erreur simplifiés

Si une erreur survient, ne PAS montrer l'erreur technique.
À la place :

```
⚠️ PETIT PROBLÈME

Quelque chose n'a pas fonctionné comme prévu.
Pas de panique, ça arrive !

[EXPLICATION SIMPLE DU PROBLÈME]

Solution :
[ÉTAPES SIMPLES POUR RÉSOUDRE]

Tu veux que je réessaie ? (oui/non)
```
