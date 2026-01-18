# 🎯 Workflow Landing Page

## Vue d'ensemble

Le workflow rapide pour créer une landing page efficace.

**Niveau** : 🟢 Minimal
**Durée estimée** : 1-3 jours
**Stack recommandée** : HTML/CSS ou Next.js

---

## Les 4 étapes

```
1. Définir le message (30 min)
     │
     ▼
2. Structurer les sections (1h)
     │
     ▼
3. Développer avec Claude (2-4h)
     │
     ▼
4. Déployer (30 min)
```

---

## Étape 1 : Définir le message

### Les 5 questions

Avant de coder, réponds à :

1. **Pour qui ?** (cible précise)
2. **Quel problème ?** (douleur)
3. **Quelle solution ?** (ton produit)
4. **Pourquoi toi ?** (différenciation)
5. **Quelle action ?** (CTA)

### Template

```markdown
# Brief Landing Page

**Cible** : [Qui exactement]
**Problème** : [En 1 phrase]
**Solution** : [Ce que tu offres]
**Différenciation** : [Pourquoi toi]
**CTA principal** : [Action souhaitée]
**URL CTA** : [Où ça mène]
```

---

## Étape 2 : Structurer les sections

### Structure classique (qui marche)

```
1. HERO
   - Headline (promesse principale)
   - Subheadline (clarification)
   - CTA
   - Image/Visual

2. PROBLÈME
   - Décrire la douleur
   - Montrer les conséquences

3. SOLUTION
   - Présenter ton produit
   - 3 bénéfices clés

4. SOCIAL PROOF
   - Témoignages
   - Logos clients
   - Chiffres

5. FEATURES
   - Liste des fonctionnalités
   - Avec bénéfices

6. PRICING (optionnel)
   - Plans/Prix
   - CTA

7. FAQ (optionnel)
   - Objections courantes

8. CTA FINAL
   - Répéter l'action
   - Urgence/Scarcité

9. FOOTER
   - Liens légaux
   - Contact
```

---

## Étape 3 : Développer avec Claude

### Prompt initial

```markdown
Crée une landing page pour :

# Brief
[Colle ton brief de l'étape 1]

# Sections
[Liste des sections choisies]

# Style
- Moderne et épuré
- Couleur principale : [couleur]
- Mobile-first

# Technique
- HTML/CSS vanilla (ou Next.js si préféré)
- Pas de dépendances lourdes
- Optimisé performance

Commence par la structure HTML, puis on ajoutera le style.
```

### Itération

```
"Le hero manque d'impact. Rends le headline plus punchy."

"Ajoute une animation subtile au CTA."

"Le texte est trop long dans la section problème. Condense."
```

### Optimisation

```
"Optimise les images pour le web."

"Ajoute les meta tags SEO."

"Vérifie le responsive sur mobile."
```

---

## Étape 4 : Déployer

### Option A : Vercel (gratuit)

```bash
npm install -g vercel
vercel
```

### Option B : Netlify (gratuit)

```bash
npm install -g netlify-cli
netlify deploy --prod
```

### Option C : GitHub Pages (gratuit)

```bash
# Dans les settings du repo GitHub
# Activer Pages sur la branche main
```

### Checklist pré-deploy

- [ ] Titre et meta description
- [ ] Favicon
- [ ] Images optimisées
- [ ] Liens fonctionnels
- [ ] Formulaire testé (si applicable)
- [ ] Mobile responsive
- [ ] Vitesse OK (PageSpeed > 90)

---

## Templates de prompts

### Hero section

```
"Crée un hero section avec :
- Headline : [ta headline]
- Subheadline : [ta subheadline]
- CTA : [texte du bouton]
- Style : [ton style]"
```

### Section témoignages

```
"Crée une section témoignages avec :
- 3 témoignages clients
- Photo + Nom + Entreprise
- Citation de 2 lignes max
- Style cards avec ombre légère"
```

### Section pricing

```
"Crée une section pricing avec :
- 3 plans : [Starter, Pro, Business]
- Prix : [29€, 79€, 199€]
- Features différenciantes
- CTA sur chaque plan
- Badge 'Populaire' sur le plan du milieu"
```

---

## Exemples de headlines efficaces

### Formules qui marchent

```
"[Bénéfice] sans [douleur]"
→ "Des scripts vidéo viraux sans expertise marketing"

"Le [catégorie] pour [cible]"
→ "Le CRM pour freelances qui détestent les CRMs"

"[Action] en [temps]"
→ "Créez votre site en 10 minutes"

"Stop [problème]. Start [solution]"
→ "Stop au contenu médiocre. Start avec l'IA."
```

---

## Ressources

- [Landingfolio](https://www.landingfolio.com/) - Inspiration
- [Undraw](https://undraw.co/) - Illustrations gratuites
- [Unsplash](https://unsplash.com/) - Photos gratuites
- [PageSpeed Insights](https://pagespeed.web.dev/) - Test performance
