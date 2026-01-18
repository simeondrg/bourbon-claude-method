# 💰 Monetize - De projet à business

## Vue d'ensemble

Tu as un projet qui fonctionne. Maintenant, transformons-le en business.

---

## Les 4 piliers

```
┌─────────────────────────────────────────────────────────────┐
│                    MONETIZATION                             │
└─────────────────────────────────────────────────────────────┘

    PRICING              PAYMENT            MARKETING          GROWTH
       │                    │                   │                │
       ▼                    ▼                   ▼                ▼
┌─────────────┐      ┌─────────────┐    ┌─────────────┐  ┌─────────────┐
│ Stratégie   │      │ Stripe      │    │ Lancement   │  │ Premiers    │
│ de prix     │      │ Setup       │    │             │  │ clients     │
└─────────────┘      └─────────────┘    └─────────────┘  └─────────────┘
```

---

## Guides disponibles

| Sujet | Fichier |
|-------|---------|
| Stratégie de pricing | [pricing-strategy.md](./pricing-strategy.md) |
| Configuration Stripe | [stripe-setup.md](./stripe-setup.md) |
| Marketing de lancement | [launch-marketing.md](./launch-marketing.md) |
| Acquérir ses premiers clients | [first-customers.md](./first-customers.md) |

---

## Modèles de monétisation

### 1. Abonnement (SaaS)

```
Avantages:
+ Revenus récurrents (MRR)
+ Prévisibilité
+ Relation client long-terme

Inconvénients:
- Churn à gérer
- Feature creep
- Support continu
```

**Idéal pour** : Outils utilisés régulièrement

### 2. One-time (achat unique)

```
Avantages:
+ Simple à gérer
+ Pas de churn
+ Cash immédiat

Inconvénients:
- Pas de récurrence
- Besoin de nouveaux clients constants
- Difficile de justifier les updates
```

**Idéal pour** : Templates, cours, outils simples

### 3. Freemium

```
Avantages:
+ Acquisition facile
+ Viralité
+ Upsell naturel

Inconvénients:
- Coût des users gratuits
- Taux de conversion ~2-5%
- Trouver la bonne limite
```

**Idéal pour** : Produits avec effet réseau

### 4. Usage-based

```
Avantages:
+ Aligné avec la valeur
+ Pas de limite artificielle
+ Scale naturel

Inconvénients:
- Revenus variables
- Difficile à prévoir
- Peut effrayer les users
```

**Idéal pour** : APIs, infrastructure

---

## Framework de pricing

### Étape 1 : Définir la valeur

```
Combien mon produit fait économiser/gagner au client ?

Exemple :
- Agence facture 500€ pour un script vidéo
- Mon SaaS génère le même en 30 secondes
- Valeur perçue : ~100-200€
```

### Étape 2 : Segmenter

```
Segment 1: Occasionnel
- Usage: 1-2x/mois
- Willing to pay: 20-30€

Segment 2: Régulier
- Usage: 10x/mois
- Willing to pay: 50-100€

Segment 3: Intensif
- Usage: Illimité
- Willing to pay: 150-300€
```

### Étape 3 : Structurer les plans

```
Plan          | Prix    | Pour qui
------------- | ------- | --------
Starter       | 29€/m   | Occasionnel
Pro           | 79€/m   | Régulier
Business      | 199€/m  | Intensif
```

### Étape 4 : Différencier

| Feature | Starter | Pro | Business |
|---------|---------|-----|----------|
| Générations/mois | 2 | 10 | Illimité |
| Support | Email | Email | Prioritaire |
| Templates | Base | Tous | Custom |
| Export | PDF | PDF+Video | Tous formats |

---

## Métriques clés

### MRR (Monthly Recurring Revenue)

```
MRR = Nombre de clients × Prix moyen mensuel

Exemple: 50 clients × 60€ = 3000€ MRR
```

### Churn (taux d'attrition)

```
Churn = Clients perdus / Clients totaux × 100

Objectif: < 5% mensuel
```

### LTV (Lifetime Value)

```
LTV = Prix moyen / Churn mensuel

Exemple: 60€ / 5% = 1200€
```

### CAC (Customer Acquisition Cost)

```
CAC = Dépenses marketing / Nouveaux clients

Objectif: LTV/CAC > 3
```

---

## Quick Start Stripe

### 1. Créer un compte

[stripe.com](https://stripe.com) → Inscription

### 2. Créer les produits

Dashboard → Products → Add Product

### 3. Intégrer dans ton app

```bash
npm install stripe @stripe/stripe-js
```

### 4. Créer une checkout session

```typescript
// app/api/stripe/checkout/route.ts
import Stripe from 'stripe';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!);

export async function POST(req: Request) {
  const { priceId } = await req.json();

  const session = await stripe.checkout.sessions.create({
    mode: 'subscription',
    payment_method_types: ['card'],
    line_items: [{ price: priceId, quantity: 1 }],
    success_url: `${process.env.NEXT_PUBLIC_APP_URL}/success`,
    cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/pricing`,
  });

  return Response.json({ url: session.url });
}
```

### 5. Gérer les webhooks

```typescript
// app/api/stripe/webhook/route.ts
export async function POST(req: Request) {
  const body = await req.text();
  const sig = req.headers.get('stripe-signature')!;

  const event = stripe.webhooks.constructEvent(
    body, sig, process.env.STRIPE_WEBHOOK_SECRET!
  );

  switch (event.type) {
    case 'checkout.session.completed':
      // Activer l'abonnement
      break;
    case 'customer.subscription.deleted':
      // Désactiver l'abonnement
      break;
  }

  return Response.json({ received: true });
}
```

---

## Marketing de lancement

### Semaine -2 : Teasing

- Annoncer sur tes réseaux
- Liste d'attente
- Contenu "behind the scenes"

### Semaine -1 : Préparation

- Préparer le post de lancement
- Contacter des bêta-testeurs
- Préparer les réponses FAQ

### Jour J : Lancement

- Post sur LinkedIn/Twitter
- Product Hunt (optionnel)
- Email à ta liste
- Demander des partages

### Semaine +1 : Suivi

- Répondre à tous les feedbacks
- Corriger les bugs rapidement
- Collecter les témoignages

---

## Acquérir les premiers clients

### Les 3 méthodes qui marchent

1. **Ton réseau personnel**
   - Amis, famille, collègues
   - Anciens clients
   - Contacts LinkedIn

2. **Communautés**
   - Groupes Facebook
   - Discord/Slack
   - Forums spécialisés

3. **Contenu**
   - Articles de blog
   - Posts LinkedIn
   - Vidéos tutoriels

### Objectif premiers mois

```
Mois 1: 10 clients (validation)
Mois 2: 30 clients (traction)
Mois 3: 100 clients (croissance)
```

---

## Prochaine étape

Choisis ton guide selon ta priorité :

→ [pricing-strategy.md](./pricing-strategy.md) - Définir tes prix
→ [stripe-setup.md](./stripe-setup.md) - Configurer Stripe
→ [launch-marketing.md](./launch-marketing.md) - Préparer le lancement
→ [first-customers.md](./first-customers.md) - Trouver tes premiers clients
