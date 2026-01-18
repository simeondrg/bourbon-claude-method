# 📊 Business Model Canvas

## C'est quoi ?

Le Business Model Canvas est un outil visuel pour décrire ton business en 1 page.

9 blocs qui répondent à : **Comment tu crées et captures de la valeur ?**

---

## Les 9 blocs

```
┌─────────────────┬─────────────────┬─────────────────┬─────────────────┬─────────────────┐
│                 │                 │                 │                 │                 │
│   PARTENAIRES   │   ACTIVITÉS     │   PROPOSITION   │   RELATIONS     │   SEGMENTS      │
│   CLÉS          │   CLÉS          │   DE VALEUR     │   CLIENTS       │   CLIENTS       │
│                 │                 │                 │                 │                 │
│   Qui t'aide ?  │   Que fais-tu ? │   Pourquoi      │   Comment tu    │   Pour qui ?    │
│                 │                 │   te choisir ?  │   communiques ? │                 │
├─────────────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┤
│                 │                 │                 │                 │                 │
│                 │   RESSOURCES    │                 │   CANAUX        │                 │
│                 │   CLÉS          │                 │                 │                 │
│                 │                 │                 │   Comment tu    │                 │
│                 │   De quoi       │                 │   livres ?      │                 │
│                 │   as-tu besoin? │                 │                 │                 │
├─────────────────┴─────────────────┴─────────────────┴─────────────────┴─────────────────┤
│                                                                                         │
│   STRUCTURE DE COÛTS                         │   SOURCES DE REVENUS                     │
│   Combien ça coûte ?                         │   Comment tu gagnes ?                    │
│                                                                                         │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Générer avec Claude

### Prompt

```markdown
Génère un Business Model Canvas complet pour mon projet.

# Mon projet
[Nom] : [Nom du projet]
[Description] : [1-2 phrases]
[Cible] : [Qui tu vises]
[Problème] : [Ce que tu résous]

# Format souhaité
Pour chaque bloc, donne :
- 3-5 points concrets
- Pas de blabla générique

Sois spécifique à MON projet, pas des conseils génériques.
```

---

## Exemple complet : VuVenu

### Le projet

```
Nom : VuVenu
Description : SaaS qui génère du contenu marketing (scripts vidéo + Meta Ads) pour commerces locaux
Cible : Commerçants français (restaurants, salons, boutiques)
Problème : Ils n'ont pas le temps/compétences pour créer du contenu marketing
```

### Business Model Canvas généré

```markdown
## 1. Segments Clients
- Restaurants indépendants (10-50 couverts)
- Salons de coiffure/beauté
- Boutiques de proximité
- Artisans locaux
- Budget marketing : 100-500€/mois

## 2. Proposition de Valeur
- Génère des scripts vidéo viraux en 30 secondes
- Crée des campagnes Meta Ads complètes
- Adapté au marché français/local
- 10x moins cher qu'une agence
- Pas besoin de compétences marketing

## 3. Canaux
- Acquisition : Meta Ads, SEO local, bouche-à-oreille
- Activation : Essai gratuit 7 jours
- Livraison : App web (SaaS)
- Support : Chat in-app, email

## 4. Relations Clients
- Self-service (autonome)
- Onboarding guidé
- Templates par industrie
- Communauté Facebook

## 5. Sources de Revenus
- Abonnement mensuel :
  - Starter : 29€/mois (2 scripts)
  - Pro : 79€/mois (10 scripts)
  - Business : 199€/mois (illimité)
- Upsell : crédits Meta Ads
- MRR cible : 10k€ à 6 mois

## 6. Ressources Clés
- Plateforme SaaS (Next.js + Supabase)
- APIs IA (Claude, Gemini)
- Base de données tendances virales
- Expertise marketing local

## 7. Activités Clés
- Développement produit
- Curation tendances virales
- Support client
- Création contenu éducatif

## 8. Partenaires Clés
- Anthropic (API Claude)
- Google (API Gemini)
- Stripe (paiements)
- Vercel (hébergement)

## 9. Structure de Coûts
- Fixe :
  - Hébergement : 50€/mois
  - Domaine : 15€/an
  - Mon temps : valeur X
- Variable :
  - APIs IA : ~0.10€/génération
  - Stripe : 1.4% + 0.25€/transaction
- Point mort : ~50 clients Starter
```

---

## Les erreurs à éviter

### ❌ Trop vague

```
Segment : "Tout le monde"
Proposition : "La meilleure app"
Revenus : "Pub et premium"
```

### ✅ Spécifique

```
Segment : "Restaurateurs 10-50 couverts, France, budget marketing 100-500€/mois"
Proposition : "Génère un script vidéo viral adapté à ton restaurant en 30 secondes"
Revenus : "Abo 29-199€/mois, upsell crédits pub"
```

---

## Template vierge

```markdown
## 1. Segments Clients
-
-
-

## 2. Proposition de Valeur
-
-
-

## 3. Canaux
- Acquisition :
- Livraison :
- Support :

## 4. Relations Clients
-
-

## 5. Sources de Revenus
-
-
- MRR cible :

## 6. Ressources Clés
-
-
-

## 7. Activités Clés
-
-
-

## 8. Partenaires Clés
-
-
-

## 9. Structure de Coûts
- Fixe :
- Variable :
- Point mort :
```

---

## Exercice

### 1. Génère ton canvas avec Claude

```bash
claude
```

```
Génère un Business Model Canvas pour mon projet :

[Nom] :
[Description] :
[Cible] :
[Problème] :

Sois spécifique et concret, pas de blabla générique.
```

### 2. Sauvegarde-le

Crée `docs/business-model-canvas.md` dans ton projet.

### 3. Review critique

```
Maintenant, critique ce canvas. Quels sont les points faibles ?
Quelles hypothèses dois-je valider en priorité ?
```

---

## Prochaine étape

→ [03-business-plan.md](./03-business-plan.md) - Générer un business plan complet
