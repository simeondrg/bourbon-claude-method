---
name: ralph
description: "Execute le PRD - Implémente, vérifie visuellement, commit, push, PR"
---

# Ralph - Exécution Autonome avec Vérification Visuelle

Ralph exécute un PRD de manière autonome jusqu'à la PR, **incluant la vérification visuelle automatique**.

## RÈGLE D'OR : AUTOMATISATION MAXIMALE

Ralph ne demande JAMAIS confirmation. Il exécute, vérifie, et continue.

- PRD existe? → Exécuter
- PRD n'existe pas? → Le créer silencieusement puis exécuter
- Erreur? → Fix automatique (max 3x)
- Story UI? → Vérification visuelle automatique

## Workflow d'Exécution

```
/ralph [nom-feature]
        ↓
┌─────────────────────────────────────────────────────┐
│  0. CHARGER CONTEXTE (silencieux)                   │
│     - Lire Codebase Patterns dans CLAUDE.md         │
│     - 📱 Notification: "🚀 Ralph started: {feature}"│
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  1. PRD AUTO-DETECT                                 │
│     - PRD existe? → Charger                         │
│     - PRD n'existe pas? → Créer automatiquement     │
│     - Pas de question, pas d'attente                │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. CRÉER BRANCHE (auto)                            │
│     - git checkout -b feature/{feature}             │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. POUR CHAQUE USER STORY                          │
│     a. Afficher progress bar: ████░░░░ 50%          │
│     b. Implémenter le code                          │
│     c. Quality Gate: typecheck + lint               │
│     d. Si story UI → VÉRIFICATION VISUELLE (new!)   │
│     e. Si échec → fix auto (max 3x)                 │
│     f. git commit (auto)                            │
│     g. 📱 Notification: "✅ [X/N] done"             │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3bis. VÉRIFICATION VISUELLE (stories UI)           │
│     - Ouvrir browser sur localhost:3000             │
│     - Screenshot automatique                        │
│     - Analyser si le rendu est correct              │
│     - Si problème visuel → fix auto                 │
│     - Utilise: Browser Use CLI ou Chrome MCP        │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. METTRE À JOUR CODEBASE PATTERNS (auto)          │
│     - SI nouveau pattern découvert → ajouter        │
│     - SI gotcha rencontré → documenter              │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  5. PUSH & PR (auto, pas de question)               │
│     - git push -u origin {branche}                  │
│     - gh pr create --fill                           │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  6. RAPPORT FINAL (pas de question "autre chose?")  │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━       │
│     ✅ FAIT                                         │
│     📝 Commits: X | 📁 Fichiers: Y                  │
│     🔗 PR: [URL]                                    │
│     👁️ Vérifié visuellement: ✅                     │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━       │
│     Prochaine suggestion: [action logique]          │
└─────────────────────────────────────────────────────┘
```

## Vérification Visuelle Automatique (NOUVEAU)

Pour chaque story qui modifie l'UI, Ralph vérifie visuellement le résultat.

### Comment ça marche

```bash
# Option 1: Browser Use CLI (recommandé)
npx browser-use screenshot http://localhost:3000 --output screenshots/

# Option 2: Chrome MCP (si disponible)
# Utilise mcp__Claude_in_Chrome__computer action=screenshot
```

### Quand vérifier visuellement

| Type de fichier modifié | Vérification visuelle |
|------------------------|----------------------|
| `*.tsx` dans `app/` | ✅ Oui |
| `*.tsx` dans `components/` | ✅ Oui |
| `*.css`, `*.scss` | ✅ Oui |
| `tailwind.config.*` | ✅ Oui |
| `*.ts` dans `lib/` | ❌ Non |
| `route.ts` (API) | ❌ Non |

### Critères de validation visuelle

1. **Page charge sans erreur** (pas de blank screen)
2. **Pas d'erreur dans la console**
3. **Éléments attendus visibles** (selon story)
4. **Responsive OK** (screenshot mobile + desktop)

Si problème détecté → fix automatique → re-vérifier (max 3x)

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

## Notifications Mobile (ntfy.sh) - OBLIGATOIRE

**IMPORTANT** : Ralph DOIT exécuter ces commandes de notification aux moments indiqués.

### Commande de notification

```bash
# Lire le topic depuis .notify-config et envoyer
if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -d "MESSAGE" "ntfy.sh/$NTFY_TOPIC"; fi
```

### Moments d'envoi (OBLIGATOIRE)

| Moment | Commande exacte |
|--------|-----------------|
| **Démarrage** | `if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -d "🚀 Started: {feature}" "ntfy.sh/$NTFY_TOPIC"; fi` |
| **Story OK** | `if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -d "✅ {US-XXX} done ({X}/{N})" "ntfy.sh/$NTFY_TOPIC"; fi` |
| **Build OK** | `if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -H "Priority: high" -d "🎉 COMPLETE: {feature} - PR ready" "ntfy.sh/$NTFY_TOPIC"; fi` |
| **Erreur** | `if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -H "Priority: urgent" -d "❌ Error: {message}" "ntfy.sh/$NTFY_TOPIC"; fi` |

### Exemple concret

```bash
# Au démarrage de /ralph auth-system
if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -d "🚀 Started: auth-system" "ntfy.sh/$NTFY_TOPIC"; fi

# Après US-001 (1/4 stories)
if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -d "✅ US-001 done (1/4)" "ntfy.sh/$NTFY_TOPIC"; fi

# À la fin
if [ -f ".notify-config" ]; then source .notify-config && curl -s -H "Title: Ralph" -H "Priority: high" -d "🎉 COMPLETE: auth-system - PR ready" "ntfy.sh/$NTFY_TOPIC"; fi
```

Cela permet de lancer Ralph et de partir faire autre chose.

## Progress File (tasks/progress-{feature}.txt)

Ralph maintient un fichier de progression pour chaque feature :

```
# Progress: unified-buttons
# Started: 2026-01-19 14:30
# PRD: tasks/prd-unified-buttons.json

## Codebase Patterns (from AGENTS.md)
- Use `btn-sparkle` class for animated buttons
- Mobile-first breakpoints: sm/md/lg/xl
- Supabase RLS for all queries

## Stories Progress
[x] US-001: Create btn-sparkle CSS class (14:32)
[x] US-002: Apply to hero buttons (14:45)
[ ] US-003: Apply to pricing buttons
[ ] US-004: Add hover animations

## Current: US-003
Implementing pricing button updates...

## Issues Encountered
- Fixed import path for utils (14:40)
```

Ce fichier permet de :
- Reprendre là où on en était si session interrompue
- Voir le contexte codebase au moment du build
- Tracker les issues rencontrées

## Archive System (tasks/archive/)

Une fois le build terminé et la PR créée :
- `prd-{feature}.json` → `tasks/archive/prd-{feature}.json`
- `progress-{feature}.txt` → `tasks/archive/progress-{feature}.txt`

Cela garde le dossier `tasks/` propre tout en conservant l'historique.

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
- Merger la PR automatiquement (voir règle fin de session ci-dessous)
- Lancer les tests E2E (optionnel, à la demande)

## Règle Fin de Session - Merge des PRs

**IMPORTANT** : Quand l'utilisateur indique qu'il termine sa session ("on s'arrête là", "c'est bon pour aujourd'hui", "je reprends demain", etc.), Claude DOIT :

1. Vérifier s'il y a des PRs ouvertes avec `gh pr list`
2. Si oui, demander : "Tu veux merger les PRs ouvertes avant de partir ?"
3. Si l'utilisateur confirme → `gh pr merge <numero> --squash --delete-branch`
4. Si non → laisser ouvert pour review ultérieure

Cela garantit que le travail validé est intégré à main, tout en laissant la possibilité de comparer/réfléchir si besoin.

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
