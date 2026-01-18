---
name: browser
description: "Automatisation navigateur pour tests et verifications UI"
---

# Browser - Automatisation UI

Utilise Chrome MCP (Claude in Chrome) pour automatiser des tests et vérifications UI sur VuVenu.

## Usage

```
/browser [action] [cible]
```

**Actions disponibles:**
- `/browser check` → Vérification rapide que le site fonctionne
- `/browser screenshot /page` → Capture d'écran d'une page
- `/browser flow [nom]` → Exécute un flow utilisateur prédéfini
- `/browser compare` → Compare visuellement avec attentes

## Prérequis

- Chrome ouvert avec extension "Claude in Chrome"
- Serveur de dev lancé (`npm run dev`)

## Flows Prédéfinis

### check (Vérification Rapide)

```
/browser check
```

Vérifie :
1. Homepage se charge sans erreurs console
2. Navigation fonctionne (liens cliquables)
3. Images se chargent
4. Pas d'erreurs JavaScript

### screenshot

```
/browser screenshot /pricing
```

Capture la page et l'affiche pour review visuel.

### flow signup

```
/browser flow signup
```

Simule le parcours d'inscription :
1. Homepage → Clic CTA
2. Page Register → Remplir formulaire (données test)
3. Vérifier redirection dashboard
4. Rapport résultat

### flow pricing

```
/browser flow pricing
```

Vérifie la page pricing :
1. 3 cards affichées (Starter, Pro, Business)
2. Prix corrects
3. Boutons CTA fonctionnels
4. Toggle mensuel/annuel

## Workflow

```
/browser [action]
        ↓
┌─────────────────────────────────────────────────────┐
│  1. CONNEXION CHROME                                │
│     - Vérifier tabs MCP disponibles                 │
│     - Créer nouveau tab si nécessaire               │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. NAVIGATION                                      │
│     - Aller vers URL cible                          │
│     - Attendre chargement complet                   │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. EXÉCUTION ACTION                                │
│     - Check: analyser console + DOM                 │
│     - Screenshot: capturer + afficher               │
│     - Flow: exécuter étapes séquentiellement        │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. RAPPORT                                         │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     🌐 BROWSER REPORT                               │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📍 URL: http://localhost:3000/pricing           │
│     ✅ Status: Page chargée correctement            │
│     ⚠️ Console: 0 errors, 2 warnings               │
│     📸 Screenshot: [image]                          │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
└─────────────────────────────────────────────────────┘
```

## Intégration avec Ralph

Après un `/ralph feature-name`, lancer :

```
/browser check
```

Pour vérifier visuellement que les changements sont corrects.

## Données de Test

Pour les flows nécessitant des données :

```javascript
const testUser = {
  email: 'test@example.com',
  password: 'TestPassword123!',
  businessName: 'Test Commerce',
  industry: 'restaurant'
}
```

**Note**: Ne jamais utiliser de vraies données dans les tests automatisés.

## Limitations

- Nécessite Chrome avec extension MCP active
- Ne peut pas tester flows nécessitant vraie auth (Supabase)
- Screenshots en local uniquement (pas de stockage cloud)
- Timeout: 30s max par action

## Exemple Complet

```
Utilisateur: /browser flow pricing

Claude:
🌐 Browser - Flow "pricing"

📍 Navigating to http://localhost:3000/pricing...
✅ Page loaded (1.2s)

🔍 Checking pricing cards...
  ✅ Starter card: visible, price "29€/mois"
  ✅ Pro card: visible, price "79€/mois", badge "Populaire"
  ✅ Business card: visible, price "199€/mois"

🔘 Testing toggle mensuel/annuel...
  ✅ Toggle fonctionne
  ✅ Prix annuels: -20% appliqué

📸 Screenshot captured

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌐 BROWSER FLOW COMPLETE
✅ All 4 checks passed
⏱️ Duration: 8s
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
