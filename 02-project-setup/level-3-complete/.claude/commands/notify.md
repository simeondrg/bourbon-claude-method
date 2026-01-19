---
name: notify
description: "Configure et envoie des notifications mobile (ntfy.sh)"
---

# Notify - Notifications Mobile

Configure et envoie des notifications sur téléphone via ntfy.sh (gratuit, open-source).

## Usage

```
/notify setup              # Configuration initiale
/notify test               # Envoie une notification de test
/notify "Message"          # Envoie un message custom
/notify status             # Vérifie la configuration
```

## Setup (une fois)

### 1. Installer l'app ntfy

- **iOS**: [App Store](https://apps.apple.com/app/ntfy/id1625396347)
- **Android**: [Play Store](https://play.google.com/store/apps/details?id=io.heckel.ntfy)

### 2. Configurer le topic

```
/notify setup
```

Ceci va :
1. Générer un topic unique : `bourbon-builds-{random}`
2. Créer `.notify-config` dans le projet
3. T'afficher le topic pour t'abonner dans l'app

### 3. S'abonner dans l'app

1. Ouvrir l'app ntfy
2. Cliquer "+" ou "Subscribe"
3. Entrer le topic affiché
4. Activer les notifications

### 4. Tester

```
/notify test
```

Tu devrais recevoir "Test notification from Bourbon Claude Method".

## Configuration File (.notify-config)

```bash
# Topic ntfy.sh (obligatoire)
NTFY_TOPIC="bourbon-builds-abc123"

# Pushover (optionnel, backup)
PUSHOVER_USER=""
PUSHOVER_TOKEN=""
```

## Intégration Workflow

### Notifications Automatiques

Le skill `/ralph` envoie automatiquement :

| Événement | Message |
|-----------|---------|
| Build démarré | "🚀 Ralph started: {feature-name}" |
| Story complétée | "✅ Story {id} done ({n}/{total})" |
| Build terminé | "🎉 Build complete: {feature-name}" |
| Erreur | "❌ Build error: {message}" |
| Max iterations | "⚠️ Max iterations reached" |

### Notifications Manuelles

```
/notify "Déploiement terminé sur prod"
/notify "Review nécessaire sur PR #123"
```

## API ntfy.sh

### Envoyer une notification

```bash
curl -d "Message ici" ntfy.sh/ton-topic
```

### Avec titre

```bash
curl -H "Title: Titre" -d "Message" ntfy.sh/ton-topic
```

### Avec priorité

```bash
# Priorities: min, low, default, high, urgent
curl -H "Priority: high" -d "Message urgent" ntfy.sh/ton-topic
```

### Avec emoji

```bash
curl -H "Tags: white_check_mark" -d "Build OK" ntfy.sh/ton-topic
```

## Script d'envoi (utilisé par /ralph)

```bash
send_notification() {
  local title="$1"
  local message="$2"
  local priority="${3:-default}"

  if [ -f ".notify-config" ]; then
    source .notify-config
    if [ -n "$NTFY_TOPIC" ]; then
      curl -s \
        -H "Title: $title" \
        -H "Priority: $priority" \
        -d "$message" \
        "ntfy.sh/$NTFY_TOPIC" > /dev/null 2>&1 || true
    fi
  fi
}

# Usage
send_notification "Build Complete" "Feature auth-system done" "default"
send_notification "Error" "Build failed: typecheck error" "high"
```

## Pushover (Alternative Payante)

Si tu préfères Pushover ($5 one-time) :

1. Créer compte sur [pushover.net](https://pushover.net)
2. Noter User Key et API Token
3. Ajouter dans `.notify-config` :

```bash
PUSHOVER_USER="your-user-key"
PUSHOVER_TOKEN="your-api-token"
```

## Troubleshooting

### Pas de notification reçue

1. Vérifier que l'app est installée et ouverte une fois
2. Vérifier le topic (doit être identique)
3. Tester avec : `curl -d "test" ntfy.sh/ton-topic`
4. Vérifier permissions notifications sur téléphone

### Topic déjà utilisé

Les topics sont publics. Utiliser un topic avec random :
`bourbon-builds-{8-chars-random}`

### Notifications désactivées la nuit

Dans l'app ntfy, configurer les heures silencieuses par topic.

## Sécurité

- Les topics sont publics mais non-listés
- Utiliser un topic aléatoire (généré par setup)
- Ne pas mettre de données sensibles dans les messages
- Pour usage privé : self-host ntfy server

## Exemple Workflow Complet

```
Toi: "Implémente le système d'auth"
        ↓
Claude: /prd auth-system
        ↓
Toi: "oui"
        ↓
Claude: /ralph auth-system
        ↓
📱 Notification: "🚀 Ralph started: auth-system"
        ↓
[Tu vas faire autre chose]
        ↓
📱 Notification: "✅ Story US-001 done (1/4)"
📱 Notification: "✅ Story US-002 done (2/4)"
📱 Notification: "✅ Story US-003 done (3/4)"
📱 Notification: "✅ Story US-004 done (4/4)"
        ↓
📱 Notification: "🎉 Build complete: auth-system"
        ↓
Toi: [Reviens quand tu veux]
```
