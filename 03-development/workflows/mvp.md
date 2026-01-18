# ⚡ Workflow MVP / Prototype

## Vue d'ensemble

Le workflow pour créer un MVP rapidement et valider ton idée.

**Niveau** : 🟡 Standard
**Durée estimée** : 1-2 semaines
**Stack recommandée** : Ce qui va le plus vite

---

## Philosophie MVP

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│   "Si tu n'as pas honte de la v1,                  │
│    tu as lancé trop tard."                         │
│                                 - Reid Hoffman      │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### Ce qu'est un MVP

- **Minimum** : Le strict nécessaire
- **Viable** : Qui résout le problème
- **Product** : Utilisable par de vrais users

### Ce que n'est PAS un MVP

- ❌ Un prototype non fonctionnel
- ❌ Un produit avec toutes les features
- ❌ Une démo technique
- ❌ Un POC interne

---

## Les 4 phases

```
1. Définir le Core (2h)
     │
     ▼
2. Setup Express (2h)
     │
     ▼
3. Build le Core (3-7 jours)
     │
     ▼
4. Ship & Learn (1-3 jours)
```

---

## Phase 1 : Définir le Core (2h)

### La question clé

```
"Si mon produit ne pouvait faire qu'UNE SEULE chose,
 ce serait quoi ?"
```

### Exercice : MoSCoW

```
MUST HAVE (v1)     : Feature sans laquelle le produit est inutile
SHOULD HAVE (v1.1) : Important mais peut attendre
COULD HAVE (v2)    : Nice to have
WON'T HAVE         : Out of scope
```

### Exemple : App de réservation restaurant

```
MUST HAVE :
- Voir les restaurants dispo
- Réserver une table
- Confirmation

SHOULD HAVE :
- Filtre par cuisine
- Photos des plats
- Avis clients

COULD HAVE :
- Programme fidélité
- Commande en avance
- Paiement intégré

WON'T HAVE :
- Livraison
- Social features
- Chat avec resto
```

### Avec Claude

```
"Je veux créer [idée].

Le problème : [problème]
La cible : [qui]

Aide-moi à identifier :
1. LA feature core (une seule)
2. Le minimum pour que ce soit utilisable
3. Ce qu'on peut ignorer pour la v1"
```

---

## Phase 2 : Setup Express (2h)

### Règle d'or

```
Utilise ce que tu connais déjà.
Pas de nouvelle techno pour un MVP.
```

### Options rapides

| Besoin | Solution Express |
|--------|-----------------|
| Landing + waitlist | Carrd + Mailchimp |
| CRUD simple | Next.js + Supabase |
| App mobile | Expo + Supabase |
| Automatisation | n8n / Make |
| No-code | Bubble / Softr |

### Setup recommandé (code)

```bash
# Le plus rapide pour un dev web
npx create-next-app@latest mvp --typescript --tailwind --app

cd mvp

npm install @supabase/supabase-js @supabase/ssr
npx shadcn@latest init

# Prêt en 10 minutes
```

### Avec Claude

```
"MVP : [description courte]

Core feature : [feature]

Setup le projet avec le minimum :
- Next.js + Supabase
- Auth basique
- Une seule page pour [feature]
- Pas de fioriture"
```

---

## Phase 3 : Build le Core (3-7 jours)

### Règles du MVP

1. **Pas de refactoring** : Code qui marche > code propre
2. **Pas d'edge cases** : Happy path only
3. **Pas d'optimisation** : Performance plus tard
4. **Pas de tests** : On teste manuellement
5. **Pas de design** : shadcn default est suffisant

### Structure minimale

```
src/
├── app/
│   ├── page.tsx           # Landing ou core feature
│   ├── api/               # API si nécessaire
│   └── [feature]/         # Une feature = un dossier
├── components/
│   └── [feature]/         # Composants de la feature
└── lib/
    └── supabase.ts        # Config BDD
```

### Exemple de session avec Claude

```
Jour 1 : Setup + Auth
"Configure auth Supabase. Login/register uniquement.
Pas de reset password, pas de social login."

Jour 2-3 : Core Feature
"Implémente [feature core].
Focus sur le happy path.
Ignore les erreurs edge case."

Jour 4-5 : Finitions
"Ajoute :
- Page de succès
- Email de confirmation basique
- Fix les bugs évidents"

Jour 6-7 : Buffer pour imprévus
```

### Ce qu'on skippe volontairement

```
❌ Responsive parfait (desktop first)
❌ Animations
❌ Dark mode
❌ Internationalisation
❌ Tests automatisés
❌ CI/CD élaboré
❌ Monitoring
❌ Analytics avancés
```

---

## Phase 4 : Ship & Learn (1-3 jours)

### Deploy vite

```bash
# Option 1 : Vercel (recommandé)
vercel

# Option 2 : Netlify
netlify deploy --prod
```

### Trouver des testeurs

```
1. Ton réseau proche (10 personnes)
2. Communautés pertinentes
3. LinkedIn / Twitter
```

### Message type

```
"Hey [prénom],

Je build [produit] qui permet de [bénéfice].

J'ai une v1 ultra basique et je cherche 10 personnes
pour tester. Ça prend 5 minutes.

Tu veux essayer ? [lien]

En échange, je t'offre [X] quand ce sera prêt."
```

### Collecter du feedback

```
Questions à poser :
1. Tu as compris ce que ça fait ?
2. Tu as réussi à faire [action core] ?
3. Qu'est-ce qui t'a bloqué ?
4. Tu paierais combien pour ça ?
5. C'est quoi LA feature qui manque ?
```

### Outils simples pour feedback

- Google Form
- Typeform (gratuit limité)
- DM direct
- Call de 15 min

---

## Décider après le MVP

### Signal positif

```
✅ Users reviennent sans qu'on leur demande
✅ Users paient (même 1€)
✅ Users recommandent
✅ Demandes de features spécifiques
```

→ **Continue et améliore**

### Signal négatif

```
❌ Personne ne comprend
❌ Personne ne revient
❌ "C'est cool" mais pas d'action
❌ Pas de willingness to pay
```

→ **Pivot ou abandonne**

### Signal mitigé

```
🟡 Quelques users engagés
🟡 Feedback contradictoires
🟡 Intérêt mais pas d'action
```

→ **Itère sur le core, ne rajoute pas de features**

---

## Exemple concret : MVP "Resto Finder"

### Jour 0 : Définition

```
Core : Trouver un resto dispo ce soir
MUST : Liste restos + dispo + réserver
Skip : Photos, avis, filtres, paiement
```

### Jour 1 : Setup

```
"MVP resto finder.
- Next.js + Supabase
- Pas d'auth user (juste admin)
- Table 'restaurants' avec dispo
- Formulaire réservation simple"
```

### Jour 2-3 : Build

```
"Page d'accueil :
- Liste des restos (nom, cuisine, places dispo ce soir)
- Bouton 'Réserver' → formulaire (nom, tel, heure)
- Envoi email au resto"
```

### Jour 4 : Polish minimal

```
"Ajoute :
- Message de confirmation
- Validation basique du formulaire
- Style shadcn propre"
```

### Jour 5 : Ship

```bash
vercel
# Partager le lien
# Collecter feedback
```

### Résultat

- Build time : 4 jours
- Coût : 0€ (tier gratuit)
- Features : 1 (réserver)
- Feedback : "J'aimerais voir les photos" → v1.1

---

## Avec Claude : Prompts MVP

### Définir le scope

```
"Je veux valider l'idée de [X].
Ma cible : [qui]
Le problème : [quoi]

Définis un MVP en :
- 1 feature core
- Maximum 5 jours de dev
- Zéro fioriture"
```

### Implémenter vite

```
"Build mode MVP.

Règles :
- Happy path only
- Pas de edge cases
- Pas de refacto
- Code qui marche > code propre

Feature : [description]"
```

### Review rapide

```
"Review ce MVP.
Objectif : shipper demain.

Ce qui manque vraiment ?
Ce qu'on peut supprimer ?
Bugs bloquants ?"
```

---

## Checklist MVP

### Avant de build
- [ ] Core feature définie (UNE seule)
- [ ] Target users identifiés
- [ ] Stack choisie (familière)

### Pendant le build
- [ ] Focus sur happy path
- [ ] Pas de refactoring
- [ ] Ship quelque chose chaque jour

### Avant de ship
- [ ] La feature core marche
- [ ] Un user peut l'utiliser seul
- [ ] Landing page explique le produit

### Après le ship
- [ ] 10+ testeurs contactés
- [ ] Feedback collecté
- [ ] Décision : continue/pivot/stop

---

## Ressources

- [The Lean Startup](https://theleanstartup.com/) - Eric Ries
- [Running Lean](https://leanstack.com/running-lean-book) - Ash Maurya
- [Mom Test](https://www.momtestbook.com/) - Rob Fitzpatrick
