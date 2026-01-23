# Hooks Claude Code

Les hooks permettent d'exécuter des actions automatiques à des moments clés.

## Hook Lifecycle

```
Session Start
     │
     ▼
UserPromptSubmit
     │
     ▼
┌─────────────────┐
│  AGENTIC LOOP   │
│                 │
│  PreToolUse     │
│       ↓         │
│  PermissionReq  │
│       ↓         │
│  PostToolUse    │
│       ↑         │
└────────┘        │
         ↓
   Notification
         ↓
    Stop/SubagentStop
```

## Configuration

Dans `settings.json` ou frontmatter d'un skill :

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "command": "echo 'About to write file'"
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Bash",
        "command": "npm run lint"
      }
    ]
  }
}
```

## Événements disponibles

| Événement | Quand | Usage |
|-----------|-------|-------|
| `Setup` | `--init`, `--maintenance` | Setup initial |
| `SessionStart` | Début session | Charger contexte |
| `UserPromptSubmit` | Avant traitement prompt | Validation |
| `PreToolUse` | Avant outil | Interception |
| `PermissionRequest` | Demande permission | Auto-approve |
| `PostToolUse` | Après outil | Lint, tests |
| `Notification` | Message important | Alertes |
| `Stop` | Fin session | Cleanup |
| `SubagentStop` | Fin subagent | Cleanup agent |

## Exemples pratiques

### Auto-lint après édition

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "npm run lint --fix"
      }
    ]
  }
}
```

### Notification Slack après deploy

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Bash",
        "pattern": "vercel deploy",
        "command": "curl -X POST $SLACK_WEBHOOK -d '{\"text\":\"Deployed!\"}'"
      }
    ]
  }
}
```

### Validation pre-commit

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "pattern": "git commit",
        "command": "npm run typecheck && npm run test"
      }
    ]
  }
}
```

## Dans les Skills

Frontmatter :

```yaml
---
name: my-skill
hooks:
  PostToolUse:
    - matcher: Write
      command: npm run format
---
```
