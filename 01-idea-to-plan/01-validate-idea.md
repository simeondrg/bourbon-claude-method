# 💡 Valider Ton Idée

## Avant de coder : valider

80% des projets échouent car ils résolvent un problème inexistant.

**Règle Bourbon** : Valide AVANT de coder, pas après.

---

## Le framework de validation

### Les 5 questions essentielles

```
1. PROBLÈME  : Quel problème tu résous ?
2. POUR QUI  : Qui a ce problème ?
3. SOLUTION  : Comment tu le résous ?
4. POURQUOI TOI : Pourquoi toi et pas un autre ?
5. ARGENT    : Comment tu gagnes de l'argent ?
```

---

## Utiliser Claude pour valider

### Prompt de validation

```markdown
Je veux valider une idée de projet avant de commencer à coder.

# Mon idée
[Décris ton idée en 2-3 phrases]

# Ce que je pense savoir
- Problème : [Le problème que tu penses résoudre]
- Cible : [Qui tu penses viser]
- Solution : [Comment tu penses le résoudre]

# Ce que je veux que tu fasses
1. Challenge mon idée (sois critique, pas complaisant)
2. Identifie les points faibles
3. Propose des questions à poser à ma cible
4. Suggère des alternatives si mon idée est faible

Sois honnête, même si ça fait mal.
```

---

## Exemple de validation

### L'idée

```
Je veux créer une app qui aide les restaurants à gérer leurs réservations.
```

### La réponse de Claude (honnête)

```
⚠️ Cette idée a des problèmes :

1. **Marché saturé**
   - OpenTable, TheFork, Resy existent déjà
   - Pourquoi quelqu'un te choisirait ?

2. **Questions à te poser**
   - As-tu parlé à des restaurateurs ?
   - Combien paieraient-ils ?
   - Qu'est-ce qui manque aux solutions existantes ?

3. **Pour que ça marche**
   Tu dois avoir UN avantage clair :
   - Niche spécifique (restaurants créoles La Réunion ?)
   - Feature unique que les autres n'ont pas
   - Prix significativement plus bas

4. **Validation recommandée**
   Avant de coder quoi que ce soit :
   - Parle à 10 restaurateurs
   - Demande-leur leurs problèmes actuels
   - Propose-leur de payer pour ta solution (même si elle n'existe pas)
```

---

## Les signaux d'une bonne idée

### ✅ Signaux positifs

- Tu as vécu le problème toi-même
- Des gens te demandent déjà cette solution
- Tu peux expliquer l'idée en 1 phrase
- Tu sais EXACTEMENT qui va payer
- Les gens sortent leur portefeuille quand tu en parles

### ❌ Signaux d'alerte

- "Ce serait cool si..."
- "Tout le monde pourrait l'utiliser"
- Tu ne connais personne avec ce problème
- La solution existe déjà (et marche bien)
- Tu ne sais pas combien les gens paieraient

---

## Template de validation rapide

Copie ce template et remplis-le :

```markdown
## Mon idée en 1 phrase
[Max 15 mots]

## Le problème
- Qui a ce problème : [Personne spécifique]
- À quelle fréquence : [Quotidien/Hebdo/Mensuel]
- Combien ça coûte de ne pas résoudre : [€ ou temps]

## Ma solution
- En quoi c'est différent de l'existant : [1 chose]
- Pourquoi moi : [Mon avantage unfair]

## Validation
- Nombre de personnes contactées : [X]
- Nombre qui paieraient : [Y]
- Prix qu'ils accepteraient : [€]

## Score
- Si Y >= 3 et ils donnent un prix concret → ✅ Go
- Sinon → 🔄 Pivoter ou abandonner
```

---

## La règle des 10 conversations

Avant de coder :

1. **Identifie 10 personnes** dans ta cible
2. **Contacte-les** (LinkedIn, email, téléphone)
3. **Pose ces questions** :
   - "Comment tu gères [problème] aujourd'hui ?"
   - "Qu'est-ce qui te frustre le plus ?"
   - "Si je créais [solution], tu paierais combien ?"
4. **Note les réponses** mot pour mot
5. **Analyse les patterns**

### Le test ultime

```
"Donne-moi 50€ et je te préviens quand c'est prêt"
```

Si 3+ personnes sur 10 acceptent → idée validée.

---

## Pivoter ou persévérer ?

### Pivot = changer de direction

- Même problème, autre solution
- Même solution, autre cible
- Problème adjacent découvert

### Persévérer = continuer

- Les retours sont positifs
- Les gens veulent payer
- Tu as un avantage clair

### Abandonner = ok aussi

- Personne ne veut payer
- Le problème n'existe pas vraiment
- Tu n'as aucun avantage

**C'est OK d'abandonner une mauvaise idée. C'est même intelligent.**

---

## Exercice : Valide ton idée

### 1. Utilise Claude

```bash
claude
```

```
Je veux valider mon idée de projet. Voici le contexte :

[Colle le template de validation rempli]

Challenge cette idée sans complaisance.
```

### 2. Note le verdict

- ✅ Validée → Passe au business plan
- 🔄 À pivoter → Refais l'exercice avec le pivot
- ❌ À abandonner → Trouve une autre idée

---

## Prochaine étape

→ [02-business-model-canvas.md](./02-business-model-canvas.md) - Créer ton Business Model Canvas
