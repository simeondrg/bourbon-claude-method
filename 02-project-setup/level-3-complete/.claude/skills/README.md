# Auto-Extracted Skills

Ce dossier contient les skills extraits automatiquement via `/extract` (pattern Claudeception).

## Structure

```
.claude/skills/
├── README.md                          # Ce fichier
├── skill-template.md                  # Template pour nouveaux skills
└── [skill-name]/
    └── SKILL.md                       # Skill auto-extrait
```

## Quand un skill est extrait

Un skill est extrait quand :

1. **Debug non-évident** : >10 min d'investigation, pas dans la doc
2. **Erreur trompeuse** : Message d'erreur ne reflète pas la vraie cause
3. **Workaround découvert** : Solution trouvée par expérimentation
4. **Configuration spécifique** : Setup propre au projet
5. **Trial-and-error** : Plusieurs tentatives avant succès

## Format SKILL.md

```yaml
---
name: nom-du-skill
description: |
  [Problème]: Description exacte du symptôme/erreur
  Use when: (1) trigger 1, (2) trigger 2
  Stack: Technologies concernées
---

# Titre du Skill

## Problème
Description du problème rencontré.

## Solution
La solution trouvée avec code si applicable.

## Références
- Liens vers documentation
- Issues GitHub liées
```

## Utilisation

Les skills sont chargés automatiquement par Claude Code quand leur description matche le contexte.

Pour forcer un skill : mentionner son nom dans la conversation.

## Ne PAS extraire

- Solutions évidentes (dans la documentation)
- Patterns à usage unique
- Données sensibles (credentials, URLs internes)
- Duplications de skills existants
