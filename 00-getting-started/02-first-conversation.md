# 💬 Ta Première Conversation Productive

## Le problème des débutants

La plupart des gens utilisent Claude Code comme un chatbot :
- "Fais-moi un site web"
- "Code-moi une app"

**Résultat** : Code générique, pas adapté, frustration.

---

## La méthode Bourbon

### Principe : Contexte → Clarification → Action

```
1. CONTEXTE    : Qui tu es, ce que tu veux faire
2. CLARIFICATION : Claude pose des questions
3. ACTION      : Claude code avec toutes les infos
```

---

## Template de première conversation

```markdown
# Contexte
Je suis [ton profil] et je veux créer [type de projet].

# Objectif
[Ce que le projet doit accomplir]

# Contraintes
- Budget : [gratuit/limité/flexible]
- Timeline : [urgent/normal/pas de rush]
- Stack préférée : [si tu en as une, sinon "à recommander"]

# Ce que j'ai déjà
- [Domaine acheté ? Hébergement ? Design ?]

# Questions
Avant de commencer, quelles questions as-tu pour moi ?
```

---

## Exemple concret

### ❌ Mauvaise approche

```
Utilisateur: Crée-moi un site pour mon restaurant

Claude: *génère un site générique sans personnalité*
```

### ✅ Bonne approche

```
Utilisateur:
# Contexte
Je suis restaurateur à Saint-Denis (La Réunion) et je veux créer
un site vitrine pour mon restaurant créole "Chez Mamie Zaza".

# Objectif
- Présenter le restaurant et l'ambiance
- Afficher le menu avec les prix
- Permettre les réservations (téléphone ou formulaire simple)
- Montrer les avis Google

# Contraintes
- Budget : Gratuit (hébergement Vercel)
- Timeline : 1 semaine
- Stack : Next.js (je veux apprendre)

# Ce que j'ai déjà
- Domaine : chezmamiezaza.re
- Photos du restaurant (10 photos)
- Menu PDF à convertir

# Questions
Avant de commencer, quelles questions as-tu pour moi ?

Claude:
Excellent projet ! J'ai quelques questions pour bien cadrer :

1. **Style visuel** : Tu préfères un design moderne/épuré ou
   chaleureux/traditionnel créole ?

2. **Réservations** : Formulaire simple (email) ou système
   avec créneaux horaires ?

3. **Menu** : Combien de plats environ ? Catégories (entrées,
   plats, desserts, boissons) ?

4. **Langues** : Français uniquement ou aussi anglais pour
   les touristes ?

5. **Réseaux sociaux** : Tu as Instagram/Facebook à lier ?
```

---

## Les questions magiques à poser à Claude

### Au début d'un projet

```
"Avant de coder, quelles questions as-tu pour moi ?"
```

### Quand tu es bloqué

```
"Je suis bloqué sur [problème]. Quelles sont mes options ?"
```

### Pour challenger une décision

```
"Tu proposes [solution]. Quels sont les inconvénients ?
Y a-t-il des alternatives ?"
```

### Pour apprendre

```
"Explique-moi pourquoi tu as fait ce choix plutôt qu'un autre."
```

---

## Créer ton CLAUDE.md personnel

Le fichier `~/.claude/CLAUDE.md` est lu par Claude à chaque conversation.

### Template de base

```markdown
# Instructions Globales - [Ton Nom]

## Qui je suis
- [Ton métier/rôle]
- [Ton niveau technique : débutant/intermédiaire/avancé]
- [Tes préférences]

## Stack préférée
- Frontend : [React/Vue/autre]
- Backend : [Node/Python/autre]
- Base de données : [Supabase/Firebase/autre]
- Hébergement : [Vercel/Netlify/autre]

## Conventions
- Langue : Français dans le code et commentaires
- Style : [Mobile-first/Desktop-first]

## Ce que je NE veux PAS
- [Choses à éviter]
```

### Exemple complet

```markdown
# Instructions Globales - Siméon (Bourbon Media)

## Qui je suis
- Entrepreneur digital à La Réunion
- Niveau intermédiaire en dev (je comprends le code, je ne suis pas expert)
- Je préfère la qualité à la quantité

## Stack préférée
- Frontend : Next.js + Tailwind + shadcn/ui
- Backend : Supabase (auth + BDD + storage)
- Paiements : Stripe
- Hébergement : Vercel
- IA : Claude API pour les features IA

## Conventions
- TypeScript strict obligatoire
- Mobile-first toujours
- Français dans l'UI, anglais dans le code
- Pas de fichiers > 300 lignes

## Ce que je NE veux PAS
- CSS modules (Tailwind only)
- Over-engineering
- Dépendances inutiles
- Code commenté laissé dans le projet

## Budget tokens
- Session max : ~$10
- Utiliser Haiku pour tâches simples
```

---

## Exercice pratique

### 1. Crée ton CLAUDE.md

```bash
mkdir -p ~/.claude
nano ~/.claude/CLAUDE.md
# ou
code ~/.claude/CLAUDE.md
```

### 2. Lance une conversation test

```bash
claude
```

```
Toi: Salut ! Lis mon CLAUDE.md et dis-moi ce que tu as compris
     de mes préférences.

Claude: [Devrait résumer tes préférences correctement]
```

### 3. Teste avec un mini-projet

```
Toi: Je veux créer une page de coming soon pour un nouveau
     projet. Avant de coder, quelles questions as-tu ?
```

---

## Checklist première conversation

- [ ] Claude connaît ton profil (via CLAUDE.md)
- [ ] Tu as donné le contexte du projet
- [ ] Claude a posé des questions de clarification
- [ ] Tu as répondu aux questions
- [ ] Claude a commencé avec une compréhension claire

---

## Prochaine étape

→ [03-essential-commands.md](./03-essential-commands.md) - Les commandes essentielles
