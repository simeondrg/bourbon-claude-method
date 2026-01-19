---
name: check-stories
description: "Valide les stories d'un PRD avant execution par Ralph"
---

# Check Stories - Validation Pre-Build

Valide la qualité des stories d'un PRD AVANT de lancer Ralph. Prévient les échecs de build.

## Usage

```
/check-stories [prd-name]
```

**Exemples:**
- `/check-stories auth-system`
- `/check-stories dark-mode`

## Workflow

```
/check-stories [prd-name]
        ↓
┌─────────────────────────────────────────────────────┐
│  1. CHARGER PRD                                     │
│     - Lire tasks/prd-{name}.json                    │
│     - Parser les stories                            │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. VÉRIFIER CHAQUE STORY                           │
│     □ Taille (1-2 lignes max)                       │
│     □ Fichiers listés existent                      │
│     □ Critères d'acceptation spécifiques            │
│     □ "Typecheck passe" inclus                      │
│     □ Dépendances cohérentes                        │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. VÉRIFIER ORDRE                                  │
│     □ DB/Schema avant API                           │
│     □ API avant UI                                  │
│     □ Utils/Hooks avant Components                  │
│     □ Pas de dépendance circulaire                  │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. VÉRIFIER EDGE CASES                             │
│     □ Edge cases CRITICAL ont story dédiée          │
│     □ Edge cases HIGH mentionnés                    │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  5. RAPPORT                                         │
│                                                     │
│     ✅ STORY QUALITY CHECK                          │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📋 PRD: {name}                                  │
│     📊 Stories: {count}                             │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│                                                     │
│     ✅ PASSED                                       │
│     - Story sizing: OK                              │
│     - Dependencies: OK                              │
│     - Acceptance criteria: OK                       │
│                                                     │
│     ⚠️ WARNINGS (fixable)                          │
│     - US-003: Story trop longue, splitter           │
│                                                     │
│     🚫 BLOCKERS (must fix)                          │
│     - US-005: Fichier inexistant                    │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     🎯 Verdict: READY / NEEDS FIXES                 │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
└─────────────────────────────────────────────────────┘
```

## Checklist de Validation

### Story Sizing

| Check | Règle | Sévérité |
|-------|-------|----------|
| Longueur titre | ≤ 80 caractères | WARNING |
| Lignes description | 1-2 lignes max | WARNING |
| Fichiers par story | ≤ 3 fichiers | WARNING |
| Stories par PRD | ≤ 8 stories | WARNING |

**Si story trop grosse** → Proposer découpage

### Acceptance Criteria

| Check | Règle | Sévérité |
|-------|-------|----------|
| Critères présents | ≥ 1 critère par story | BLOCKER |
| Critères vérifiables | Pas de "joli", "bien", "correct" | WARNING |
| Typecheck inclus | "Typecheck passe" présent | WARNING |
| Browser check (UI) | "Vérifier dans browser" si UI | WARNING |

**Mots interdits dans critères** : "joli", "bien", "correct", "propre", "beau", "approprié"

### Dependencies

| Check | Règle | Sévérité |
|-------|-------|----------|
| Ordre logique | Schema → Types → API → UI | WARNING |
| Pas de circulaire | A→B→A interdit | BLOCKER |
| Dépendances existent | Réf à story existante | BLOCKER |

### Files

| Check | Règle | Sévérité |
|-------|-------|----------|
| Fichiers listés | ≥ 1 fichier par story | WARNING |
| Fichiers existent | Ou seront créés | WARNING |
| Chemins valides | Pas de typos dans paths | BLOCKER |

### Edge Cases

| Check | Règle | Sévérité |
|-------|-------|----------|
| CRITICAL couverts | Story dédiée existe | BLOCKER |
| HIGH mentionnés | Dans acceptance ou story | WARNING |

## Exemple Sortie

```
✅ STORY QUALITY CHECK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 PRD: auth-system
📊 Stories: 5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ PASSED (3)
  ✓ US-001: Story sizing OK
  ✓ US-002: Dependencies OK
  ✓ US-004: Acceptance criteria OK

⚠️ WARNINGS (2)
  1. US-003: "Créer système d'authentification complet"
     → Story trop large, suggère:
       - US-003a: Créer page login
       - US-003b: Créer page register
       - US-003c: Implémenter middleware

  2. US-005: Critère "Le formulaire est bien fait"
     → Trop vague. Suggère: "Validation Zod sur tous les champs"

🚫 BLOCKERS (0)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Score: 85/100
🎯 Verdict: READY WITH WARNINGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Recommandations:
   1. Splitter US-003 en 3 sous-stories
   2. Préciser critère US-005
```

## Actions Automatiques

### Si WARNINGS

```
Claude: "PRD a des warnings. Voulez-vous que je corrige automatiquement ?"
- [A] Oui, corriger et re-vérifier
- [B] Non, continuer avec warnings
- [C] Voir détails des warnings
```

### Si BLOCKERS

```
Claude: "PRD a des blockers. Correction obligatoire avant Ralph."
→ Propose corrections
→ Attend validation
→ Re-run /check-stories
```

## Intégration Workflow

```
/prd feature-name
        ↓
/check-stories feature-name  ← NOUVEAU
        ↓
    READY?
        ↓ OUI
/ralph feature-name
```

## Auto-Fix Capabilities

Le skill peut corriger automatiquement :

1. **Story trop longue** → Propose découpage
2. **Critères vagues** → Suggère versions spécifiques
3. **Ordre incorrect** → Réordonne les stories
4. **Typecheck manquant** → Ajoute aux critères

Le skill NE peut PAS corriger :
- Fichiers inexistants (besoin de création)
- Dépendances circulaires (besoin de redesign)
- Edge cases manquants (besoin d'analyse)
