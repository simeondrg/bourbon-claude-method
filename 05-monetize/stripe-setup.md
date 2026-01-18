# 💳 Configuration Stripe

## Vue d'ensemble

Guide complet pour intégrer Stripe dans ton projet.

---

## Étape 1 : Créer un compte Stripe

1. Va sur [stripe.com](https://stripe.com)
2. Crée un compte
3. Active ton compte (vérification identité)

**Note** : Tu peux commencer en mode Test sans activer.

---

## Étape 2 : Créer les produits

### Dans le Dashboard Stripe

1. **Products** → **Add Product**

2. Pour chaque plan :
   ```
   Name: [Nom du plan]
   Description: [Description]
   Price: [Prix]
   Billing: Monthly/Yearly
   ```

3. Copie les **Price IDs** (format `price_xxxxx`)

### Exemple structure

```
Product: Mon SaaS
├── Price: Starter Monthly (price_starter_monthly)
│   └── 29€/mois
├── Price: Starter Yearly (price_starter_yearly)
│   └── 290€/an
├── Price: Pro Monthly (price_pro_monthly)
│   └── 79€/mois
└── etc.
```

---

## Étape 3 : Variables d'environnement

### .env.local

```bash
# Clés Stripe (mode TEST)
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_xxxxx
STRIPE_SECRET_KEY=sk_test_xxxxx
STRIPE_WEBHOOK_SECRET=whsec_xxxxx

# Price IDs
STRIPE_PRICE_STARTER_MONTHLY=price_xxxxx
STRIPE_PRICE_STARTER_YEARLY=price_xxxxx
STRIPE_PRICE_PRO_MONTHLY=price_xxxxx
STRIPE_PRICE_PRO_YEARLY=price_xxxxx
```

### Où trouver les clés

- **Publishable key** : Dashboard → Developers → API keys
- **Secret key** : Dashboard → Developers → API keys
- **Webhook secret** : Dashboard → Developers → Webhooks → Endpoint → Signing secret

---

## Étape 4 : Installer les packages

```bash
npm install stripe @stripe/stripe-js
```

---

## Étape 5 : Créer les routes API

### Route Checkout

```typescript
// src/app/api/stripe/checkout/route.ts
import { NextRequest, NextResponse } from 'next/server';
import Stripe from 'stripe';
import { createClient } from '@/lib/supabase/server';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-12-18.acacia',
});

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json(
        { error: 'Non authentifié' },
        { status: 401 }
      );
    }

    const { priceId } = await request.json();

    // Créer ou récupérer le customer Stripe
    let customerId: string;

    const { data: profile } = await supabase
      .from('users')
      .select('stripe_customer_id')
      .eq('id', user.id)
      .single();

    if (profile?.stripe_customer_id) {
      customerId = profile.stripe_customer_id;
    } else {
      const customer = await stripe.customers.create({
        email: user.email,
        metadata: { userId: user.id },
      });
      customerId = customer.id;

      await supabase
        .from('users')
        .update({ stripe_customer_id: customerId })
        .eq('id', user.id);
    }

    // Créer la session checkout
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      mode: 'subscription',
      payment_method_types: ['card'],
      line_items: [{ price: priceId, quantity: 1 }],
      success_url: `${process.env.NEXT_PUBLIC_APP_URL}/dashboard?success=true`,
      cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/pricing`,
      metadata: { userId: user.id },
    });

    return NextResponse.json({ url: session.url });
  } catch (error) {
    console.error('Stripe checkout error:', error);
    return NextResponse.json(
      { error: 'Erreur lors de la création du checkout' },
      { status: 500 }
    );
  }
}
```

### Route Webhook

```typescript
// src/app/api/stripe/webhook/route.ts
import { NextRequest, NextResponse } from 'next/server';
import Stripe from 'stripe';
import { createClient } from '@supabase/supabase-js';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-12-18.acacia',
});

// Client admin Supabase (bypass RLS)
const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

export async function POST(request: NextRequest) {
  const body = await request.text();
  const signature = request.headers.get('stripe-signature')!;

  let event: Stripe.Event;

  try {
    event = stripe.webhooks.constructEvent(
      body,
      signature,
      process.env.STRIPE_WEBHOOK_SECRET!
    );
  } catch (err) {
    console.error('Webhook signature verification failed');
    return NextResponse.json({ error: 'Invalid signature' }, { status: 400 });
  }

  try {
    switch (event.type) {
      case 'checkout.session.completed': {
        const session = event.data.object as Stripe.Checkout.Session;
        const userId = session.metadata?.userId;
        const subscriptionId = session.subscription as string;

        // Récupérer les détails de l'abonnement
        const subscription = await stripe.subscriptions.retrieve(subscriptionId);
        const priceId = subscription.items.data[0].price.id;

        // Déterminer le plan
        let plan = 'free';
        if (priceId.includes('starter')) plan = 'starter';
        else if (priceId.includes('pro')) plan = 'pro';
        else if (priceId.includes('business')) plan = 'business';

        // Mettre à jour l'utilisateur
        await supabaseAdmin
          .from('users')
          .update({
            plan,
            stripe_subscription_id: subscriptionId,
            subscription_status: 'active',
          })
          .eq('id', userId);

        break;
      }

      case 'customer.subscription.updated': {
        const subscription = event.data.object as Stripe.Subscription;
        const customerId = subscription.customer as string;

        const { data: user } = await supabaseAdmin
          .from('users')
          .select('id')
          .eq('stripe_customer_id', customerId)
          .single();

        if (user) {
          await supabaseAdmin
            .from('users')
            .update({
              subscription_status: subscription.status,
            })
            .eq('id', user.id);
        }
        break;
      }

      case 'customer.subscription.deleted': {
        const subscription = event.data.object as Stripe.Subscription;
        const customerId = subscription.customer as string;

        const { data: user } = await supabaseAdmin
          .from('users')
          .select('id')
          .eq('stripe_customer_id', customerId)
          .single();

        if (user) {
          await supabaseAdmin
            .from('users')
            .update({
              plan: 'free',
              stripe_subscription_id: null,
              subscription_status: 'canceled',
            })
            .eq('id', user.id);
        }
        break;
      }
    }

    return NextResponse.json({ received: true });
  } catch (error) {
    console.error('Webhook handler error:', error);
    return NextResponse.json(
      { error: 'Webhook handler failed' },
      { status: 500 }
    );
  }
}
```

### Route Portal (gestion abonnement)

```typescript
// src/app/api/stripe/portal/route.ts
import { NextRequest, NextResponse } from 'next/server';
import Stripe from 'stripe';
import { createClient } from '@/lib/supabase/server';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-12-18.acacia',
});

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json(
        { error: 'Non authentifié' },
        { status: 401 }
      );
    }

    const { data: profile } = await supabase
      .from('users')
      .select('stripe_customer_id')
      .eq('id', user.id)
      .single();

    if (!profile?.stripe_customer_id) {
      return NextResponse.json(
        { error: 'Pas de compte Stripe' },
        { status: 400 }
      );
    }

    const session = await stripe.billingPortal.sessions.create({
      customer: profile.stripe_customer_id,
      return_url: `${process.env.NEXT_PUBLIC_APP_URL}/settings`,
    });

    return NextResponse.json({ url: session.url });
  } catch (error) {
    console.error('Stripe portal error:', error);
    return NextResponse.json(
      { error: 'Erreur lors de la création du portal' },
      { status: 500 }
    );
  }
}
```

---

## Étape 6 : Configurer les Webhooks

### En local (pour tester)

```bash
# Installer Stripe CLI
brew install stripe/stripe-cli/stripe

# Login
stripe login

# Écouter les webhooks
stripe listen --forward-to localhost:3000/api/stripe/webhook
```

### En production

1. Dashboard Stripe → Developers → Webhooks
2. "Add endpoint"
3. URL : `https://ton-domaine.com/api/stripe/webhook`
4. Events à écouter :
   - `checkout.session.completed`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`

---

## Étape 7 : Composant Pricing

```tsx
// src/components/pricing/pricing-card.tsx
'use client';

import { useState } from 'react';
import { Button } from '@/components/ui/button';

interface PricingCardProps {
  name: string;
  price: number;
  priceId: string;
  features: string[];
  popular?: boolean;
}

export function PricingCard({
  name,
  price,
  priceId,
  features,
  popular,
}: PricingCardProps) {
  const [loading, setLoading] = useState(false);

  const handleSubscribe = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/stripe/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ priceId }),
      });

      const { url } = await response.json();
      window.location.href = url;
    } catch (error) {
      console.error('Checkout error:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className={`p-6 rounded-lg border ${popular ? 'border-primary' : ''}`}>
      {popular && (
        <span className="bg-primary text-primary-foreground px-2 py-1 text-sm rounded">
          Populaire
        </span>
      )}
      <h3 className="text-xl font-bold mt-2">{name}</h3>
      <p className="text-3xl font-bold mt-4">
        {price}€<span className="text-sm font-normal">/mois</span>
      </p>
      <ul className="mt-4 space-y-2">
        {features.map((feature, i) => (
          <li key={i} className="flex items-center gap-2">
            <span>✓</span> {feature}
          </li>
        ))}
      </ul>
      <Button
        onClick={handleSubscribe}
        disabled={loading}
        className="w-full mt-6"
      >
        {loading ? 'Chargement...' : 'Souscrire'}
      </Button>
    </div>
  );
}
```

---

## Checklist

- [ ] Compte Stripe créé et activé
- [ ] Produits et prix créés
- [ ] Variables d'environnement configurées
- [ ] Routes API implémentées
- [ ] Webhooks configurés
- [ ] Test en mode Test
- [ ] Migration vers mode Live

---

## Tester

### Mode Test

1. Utilise les clés `pk_test_` et `sk_test_`
2. Carte de test : `4242 4242 4242 4242`
3. Date : N'importe quelle date future
4. CVC : N'importe quel nombre

### Vérifier

1. Faire un paiement test
2. Vérifier dans Dashboard Stripe
3. Vérifier dans ta BDD (plan mis à jour)
4. Tester l'annulation

---

## Passer en production

1. Activer ton compte Stripe (vérification)
2. Remplacer les clés test par les clés live
3. Mettre à jour le webhook endpoint
4. Tester avec une vraie carte (petit montant)
