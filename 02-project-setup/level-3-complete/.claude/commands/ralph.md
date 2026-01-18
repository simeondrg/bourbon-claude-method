---
name: ralph
description: "Execute le PRD validé - Implémente, valide, commit, push, PR"
---

# Ralph - Exécution Autonome

Ralph exécute un PRD validé de manière autonome jusqu'à la PR.

## Prérequis

**IMPORTANT** : Ralph ne s'exécute QUE sur un PRD validé par l'utilisateur.

Le PRD doit exister dans `tasks/prd-{feature}.json` avec le format standardisé.

## Workflow d'Exécution

```
/ralph [nom-feature]
        ↓
┌─────────────────────────────────────────────────────┐
│  0. CHARGER CONTEXTE                                │
│     - Lire AGENTS.md (patterns & learnings)         │
│     - Appliquer les conventions découvertes         │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  1. CHARGER PRD                                     │
│     - Lire tasks/prd-{feature}.json                 │
│     - Vérifier que toutes les stories sont définies │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. CRÉER BRANCHE                                   │
│     - git checkout -b feature/{feature}             │
│     - Ou fix/{feature} si c'est un bugfix           │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. POUR CHAQUE USER STORY                          │
│     a. Afficher "⏳ [X/N] Implémentation US-XXX..." │
│     b. Implémenter le code                          │
│     c. Valider: npm run typecheck && npm run lint   │
│     d. Si échec validation → fix et retry (max 3x)  │
│     e. git commit -m "feat(scope): US-XXX title"    │
│     f. Marquer story comme completed dans PRD       │
│     g. Afficher "✅ [X/N] US-XXX complété"          │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. METTRE À JOUR AGENTS.md (si pertinent)          │
│     - Ajouter nouveaux patterns découverts          │
│     - Documenter gotchas rencontrés                 │
│     - Mettre à jour date de dernière modification   │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  5. PUSH & PR                                       │
│     - git push -u origin {branche}                  │
│     - gh pr create avec summary auto-généré         │
│     - Retourner URL de la PR                        │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  6. RAPPORT FINAL                                   │
│     ✅ RALPH COMPLETE                               │
│     📝 Commits: X                                   │
│     📁 Fichiers modifiés: Y                         │
│     🔗 PR: https://github.com/.../pull/N            │
│     📚 AGENTS.md: [mis à jour / inchangé]           │
└─────────────────────────────────────────────────────┘
```

## Format PRD Attendu

Le fichier `tasks/prd-{feature}.json` doit avoir ce format :

```json
{
  "id": "feature-name",
  "title": "Titre de la feature",
  "description": "Description courte",
  "branch": "feature/feature-name",
  "stories": [
    {
      "id": "US-001",
      "title": "Titre de la story",
      "description": "Ce qui doit être fait",
      "files": ["src/path/to/file.tsx"],
      "acceptance": ["Critère 1", "Critère 2"],
      "status": "pending"
    }
  ],
  "created": "2026-01-18",
  "validated": true
}
```

## Quality Gates

Chaque story DOIT passer avant commit :

1. **TypeScript** : `npm run typecheck` (zéro erreur)
2. **ESLint** : `npm run lint` (zéro erreur)

Si échec après 3 tentatives → stopper et demander intervention.

## Commits

Format conventionnel obligatoire :

```
feat(scope): US-XXX titre de la story

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

## Pull Request

Format automatique :

```markdown
## Summary
- [Liste des User Stories complétées]

## Changes
- [Fichiers modifiés groupés par scope]

## Test plan
- [ ] Vérifier [critère 1]
- [ ] Vérifier [critère 2]

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

## Plugin Officiel Ralph (Alternative)

Pour une implémentation clé-en-main avec stop hook automatique, tu peux utiliser le plugin officiel :

```bash
# Installer le plugin
/plugin install ralph-loop@claude-plugins-official

# Usage avec completion promise
/ralph-loop:ralph-loop "Implement [FEATURE].

Requirements:
- [Requirement 1]
- [Requirement 2]

Output <promise>COMPLETE</promise>" --max-iterations 30
```

Le plugin gère automatiquement :
- Stop hook qui empêche les exits prématurés
- Détection du completion promise
- Max iterations comme safety net

---

## Limites & Escape Hatches

Inspiré de la technique [Ralph Wiggum](https://awesomeclaude.ai/ralph-wiggum) :

### Limites
- **Max stories** : 20 par PRD
- **Max retries** : 3 par story
- **Max iterations** : 30 (safety net global)
- **Timeout** : Si bloqué > 5 min sur une story, demander aide

### Escape Hatches (Sorties de Secours)

1. **Stuck Detection** : Si 3 retries échouent sur même erreur → STOP
2. **Infinite Loop Prevention** : Compteur global d'itérations
3. **Manual Override** : `Ctrl+C` interrompt proprement
4. **Partial Success** : Si bloqué, commit ce qui fonctionne puis rapport

### Completion Promise Pattern

Pour intégration avec ralph-loop officiel, Ralph émet `<promise>COMPLETE</promise>` en fin de rapport réussi.

```
✅ RALPH COMPLETE
[...]
<promise>COMPLETE</promise>
```

Cela permet aux hooks de détecter la fin automatiquement.

## Exemple d'Utilisation

```
Utilisateur: /ralph unified-buttons
Claude:
🚀 Ralph - Exécution du PRD "unified-buttons"

📋 PRD chargé: 3 stories
🌿 Branche: feature/unified-buttons

⏳ [1/3] US-001: Créer classe CSS btn-sparkle...
✅ [1/3] US-001 complété

⏳ [2/3] US-002: Appliquer aux boutons hero...
✅ [2/3] US-002 complété

⏳ [3/3] US-003: Appliquer aux boutons pricing...
✅ [3/3] US-003 complété

🚀 Push vers GitHub...
✅ PR créée: https://github.com/simeondrg/vuvenu-v2/pull/4

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ RALPH COMPLETE
📝 Commits: 3
📁 Fichiers: 4
⏱️ Durée: 8 min
🔗 PR: https://github.com/simeondrg/vuvenu-v2/pull/4
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## AGENTS.md - Mémoire Persistante

Ralph lit et écrit dans `AGENTS.md` pour capitaliser sur les apprentissages :

### Lecture (étape 0)
Avant d'implémenter, Ralph consulte AGENTS.md pour :
- Connaître les patterns établis (ex: utiliser `btn-sparkle` pour les boutons)
- Éviter les gotchas déjà documentés
- Respecter les conventions de code

### Écriture (étape 4)
Après l'implémentation, Ralph met à jour AGENTS.md **SI** :
- Un nouveau pattern réutilisable a été découvert
- Un gotcha/bug non évident a été rencontré
- Une convention importante a été établie

**Ne pas ajouter** :
- Des détails spécifiques à une seule feature
- Des informations déjà présentes
- Des patterns évidents/triviaux

### Format d'ajout
```markdown
### Pattern X: [Titre descriptif]
**Date**: YYYY-MM-DD
**Context**: [Situation qui a mené à ce learning]

**Learning**:
- Point clé 1
- Point clé 2

**Code Pattern** (si applicable):
\`\`\`typescript
// Exemple de code
\`\`\`
```

## Ce que Ralph NE fait PAS

- Créer le PRD (c'est fait AVANT par Claude lors de la phase Plan)
- Demander validation (le PRD est déjà validé)
- Merger la PR (l'utilisateur le fait manuellement)
- Lancer les tests E2E (optionnel, à la demande)

## Quand Utiliser Ralph (vs Manuel)

### ✅ BON pour Ralph
- Tasks bien définies avec critères clairs
- Features nécessitant itération (tests qui passent)
- Greenfield code (nouveau fichier/composant)
- Tasks avec vérification automatique (typecheck, lint)
- Implémentations overnight/background

### ❌ PAS BON pour Ralph
- Tasks nécessitant jugement design/UX subjectif
- Debug production (utiliser debug ciblé)
- Opérations one-shot simples
- Tasks avec critères de succès flous
- Modifications nécessitant approbation externe

## Principes Ralph Wiggum

> "Iteration > Perfection" - Ne pas viser parfait du premier coup, laisser la loop affiner.

> "Failures Are Data" - Les échecs sont prévisibles et informatifs, pas des blocages.

> "Operator Skill Matters" - Le succès dépend de bons PRDs, pas juste du bon modèle.

> "Persistence Wins" - Continuer jusqu'au succès, la loop gère les retries automatiquement.
