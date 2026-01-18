# /prd - Générer un PRD

## Usage

```
/prd [feature-name] [description]
```

Exemple :
```
/prd auth-system Système d'authentification avec email et Google
```

---

## Ce que ça fait

1. Analyse la demande
2. Génère un PRD structuré en JSON
3. Découpe en User Stories
4. Identifie les fichiers à créer/modifier
5. Définit les critères d'acceptance

---

## Format de sortie

```json
{
  "id": "feature-name",
  "title": "Titre de la feature",
  "description": "Description complète",
  "branch": "feature/feature-name",
  "stories": [
    {
      "id": "US-001",
      "title": "Titre de la story",
      "description": "Ce qui doit être fait",
      "files": ["src/path/to/file.tsx"],
      "acceptance": [
        "Critère vérifiable 1",
        "Critère vérifiable 2"
      ],
      "status": "pending"
    }
  ]
}
```

---

## Bonnes pratiques

### Stories atomiques

```
❌ "Implémenter le système d'auth complet"

✅ "US-001: Page de connexion"
✅ "US-002: Page d'inscription"
✅ "US-003: Validation email"
✅ "US-004: Middleware protection routes"
```

### Critères d'acceptance testables

```
❌ "L'auth doit bien marcher"

✅ "L'utilisateur peut se connecter avec email/password"
✅ "Un message d'erreur s'affiche si credentials invalides"
✅ "L'utilisateur est redirigé vers /dashboard après connexion"
```

### Fichiers explicites

```
❌ "Modifier les composants d'auth"

✅ "src/app/(auth)/login/page.tsx"
✅ "src/app/(auth)/register/page.tsx"
✅ "src/lib/auth/actions.ts"
```

---

## Exemple complet

```
/prd stripe-payments Intégration Stripe pour abonnements
```

Génère :

```json
{
  "id": "stripe-payments",
  "title": "Intégration Paiements Stripe",
  "description": "Permettre aux utilisateurs de s'abonner via Stripe",
  "branch": "feature/stripe-payments",
  "stories": [
    {
      "id": "US-001",
      "title": "Page pricing",
      "description": "Afficher les plans disponibles avec prix",
      "files": [
        "src/app/(marketing)/pricing/page.tsx",
        "src/components/pricing/pricing-card.tsx"
      ],
      "acceptance": [
        "3 plans affichés : Starter, Pro, Business",
        "Prix mensuel et annuel visibles",
        "Bouton 'Choisir ce plan' fonctionnel"
      ],
      "status": "pending"
    },
    {
      "id": "US-002",
      "title": "Checkout Stripe",
      "description": "Redirection vers Stripe Checkout",
      "files": [
        "src/app/api/stripe/checkout/route.ts"
      ],
      "acceptance": [
        "Clic sur plan → redirection Stripe",
        "User ID passé en metadata",
        "URLs success/cancel configurées"
      ],
      "status": "pending"
    },
    {
      "id": "US-003",
      "title": "Webhook paiement",
      "description": "Recevoir confirmation de paiement",
      "files": [
        "src/app/api/stripe/webhook/route.ts"
      ],
      "acceptance": [
        "Webhook vérifié avec signature",
        "Abonnement créé en BDD",
        "User status mis à jour"
      ],
      "status": "pending"
    },
    {
      "id": "US-004",
      "title": "Page succès",
      "description": "Confirmer l'abonnement au user",
      "files": [
        "src/app/(marketing)/success/page.tsx"
      ],
      "acceptance": [
        "Message de bienvenue",
        "Récap de l'abonnement",
        "CTA vers dashboard"
      ],
      "status": "pending"
    }
  ]
}
```

---

## Implémentation

```markdown
# .claude/commands/prd.md

Génère un PRD structuré pour une feature.

## Arguments
- feature-name : Identifiant de la feature (kebab-case)
- description : Description de ce qu'on veut faire

## Étapes

1. Analyser la demande
2. Identifier toutes les parties de la feature
3. Découper en User Stories atomiques
4. Pour chaque story :
   - ID unique (US-XXX)
   - Titre clair
   - Description de l'implémentation
   - Fichiers à créer/modifier
   - Critères d'acceptance testables
5. Sauvegarder dans tasks/[feature-name].json

## Règles

- Maximum 8 stories par PRD
- Chaque story = 1-4h de travail
- Critères d'acceptance vérifiables
- Fichiers avec chemins complets
```

---

## Workflow avec Ralph

```
1. /prd auth-system Description de l'auth
   → Génère tasks/auth-system.json

2. Review le PRD, ajuste si nécessaire

3. /ralph auth-system
   → Implémente toutes les stories
```
