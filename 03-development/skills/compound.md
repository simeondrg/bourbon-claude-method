# /compound - Documenter les Learnings

## Usage

```
/compound [feature-name]
```

Exemple :
```
/compound auth-system
```

---

## Ce que ça fait

Après avoir complété une feature, `/compound` :

1. Analyse ce qui a été fait
2. Identifie les patterns réutilisables
3. Note les erreurs évitées/corrigées
4. Met à jour AGENTS.md avec les learnings

---

## Philosophie Compound Engineering

```
"Chaque unité de travail doit rendre les suivantes plus faciles."
```

### Sans Compound

```
Feature 1 → oublié
Feature 2 → mêmes erreurs
Feature 3 → mêmes erreurs
Feature 4 → mêmes erreurs
```

### Avec Compound

```
Feature 1 → learning documenté
Feature 2 → évite erreur 1, nouveau learning
Feature 3 → évite erreurs 1+2, nouveau learning
Feature 4 → rapide grâce aux 3 learnings précédents
```

---

## Format de documentation

```markdown
## 🏗️ Pattern : [Nom du pattern]

**Date** : YYYY-MM-DD
**Feature** : [feature-name]
**Context** : [Situation qui a mené à ce learning]

**Learning** :
- Point clé 1
- Point clé 2
- Point clé 3

**Code Pattern** (si applicable) :
```typescript
// Exemple de code à réutiliser
```

**À éviter** :
- Anti-pattern 1
- Anti-pattern 2
```

---

## Exemple concret

Après avoir implémenté l'auth :

```
/compound auth-system
```

Génère dans AGENTS.md :

```markdown
## 🏗️ Pattern : Auth Supabase Next.js

**Date** : 2024-01-15
**Feature** : auth-system
**Context** : Implémentation auth email + Google

**Learning** :
- Utiliser `@supabase/ssr` pour les Server Components
- Middleware pour protéger les routes (pas de HOC)
- Stocker le user dans le cookie, pas localStorage

**Code Pattern** :
```typescript
// middleware.ts
export async function middleware(request: NextRequest) {
  const supabase = createServerClient(/* ... */);
  const { data: { user } } = await supabase.auth.getUser();

  if (!user && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
}
```

**À éviter** :
- `createClient` côté serveur (fuite de session)
- Vérifier l'auth dans chaque page (utiliser middleware)
- Stocker des données sensibles dans le JWT
```

---

## Quand utiliser /compound

### Après chaque feature significative

```
/ralph auth-system
# Feature complète

/compound auth-system
# Documenter les learnings
```

### Après avoir résolu un bug complexe

```
"J'ai passé 2h sur ce bug de refresh token"

/compound refresh-token-fix
```

### Après avoir découvert un pattern utile

```
"Cette manière de structurer les forms est géniale"

/compound form-pattern
```

---

## Structure dans AGENTS.md

```markdown
# AGENTS.md - [Projet]

Documentation des learnings (Compound Engineering).

---

## 🏗️ Architecture Patterns

### Pattern : Auth Supabase
[...]

### Pattern : Forms avec React Hook Form
[...]

---

## 🐛 Bugs Résolus

### Bug : Session perdue après refresh
[...]

### Bug : Hydration mismatch dates
[...]

---

## ⚡ Optimisations

### Optim : Lazy loading images
[...]

---

## 🚫 Anti-patterns à éviter

### Anti-pattern : useEffect pour fetch
[...]
```

---

## Implémentation

```markdown
# .claude/commands/compound.md

Documente les learnings d'une feature.

## Arguments
- feature-name : Nom de la feature (optionnel)

## Étapes

1. Analyser les changements récents (git diff, PRD)
2. Identifier :
   - Patterns réutilisables
   - Erreurs évitées/corrigées
   - Décisions techniques importantes
3. Formater en sections claires
4. Ajouter à AGENTS.md
5. Confirmer l'ajout

## Questions à se poser

- Qu'est-ce qui a bien marché ?
- Qu'est-ce qui a été difficile ?
- Qu'est-ce que je referais différemment ?
- Quel code peut être copié-collé ?
```

---

## Tips

### Compound immédiatement

```
❌ "Je documenterai plus tard"
   → On oublie toujours

✅ Juste après /ralph ou après un fix
   → Mémoire fraîche
```

### Être spécifique

```
❌ "L'auth c'est compliqué"

✅ "Le refresh token Supabase nécessite
    d'appeler getUser() dans le middleware
    car getSession() ne vérifie pas le JWT"
```

### Inclure du code

```
❌ "Utiliser le bon pattern pour les forms"

✅ Code complet copier-collable avec commentaires
```

---

## Bénéfices long terme

```
Mois 1  : AGENTS.md = 5 patterns
Mois 3  : AGENTS.md = 15 patterns
Mois 6  : AGENTS.md = 30 patterns
Mois 12 : AGENTS.md = 50+ patterns

Résultat : Chaque nouveau projet démarre
           avec 50 learnings de ton expérience
```

Claude lit AGENTS.md à chaque session et applique automatiquement ces patterns.

---

## Workflow complet

```bash
# 1. Planifier
/prd feature-name Description

# 2. Implémenter
/ralph feature-name

# 3. Review
git diff

# 4. Documenter les learnings
/compound feature-name

# 5. Commit
/commit
```
