---
name: prd
description: "Genere un PRD structure pour une feature"
---

# PRD Generator - Plan Structuré

Génère un PRD (Product Requirements Document) structuré pour une feature, prêt à être exécuté par Ralph.

## Usage

```
/prd [nom-feature] [description]
```

**Exemples:**
- `/prd dark-mode Ajouter un toggle dark mode`
- `/prd user-avatar Permettre aux utilisateurs de changer leur avatar`
- `/prd pricing-update Modifier les prix des plans`

## Workflow

```
/prd [nom-feature] [description]
        ↓
┌─────────────────────────────────────────────────────┐
│  1. DISCOVERY (BMAD Method)                         │
│     - Poser 1 question à la fois                    │
│     - Clarifier scope et edge cases                 │
│     - Challenger les réponses vagues                │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. ANALYSE CODEBASE                                │
│     - Identifier fichiers concernés                 │
│     - Vérifier patterns existants (AGENTS.md)       │
│     - Détecter dépendances                          │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. EDGE CASES (7 catégories)                       │
│     - Input, State, User Behavior                   │
│     - Error, Data, Security, Performance            │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. DÉCOMPOSITION EN STORIES                        │
│     - 1 story = 1-2 lignes max                      │
│     - Max 5-8 stories par PRD                       │
│     - Dépendances ordonnées                         │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  5. GÉNÉRER PRD JSON                                │
│     - Créer tasks/prd-{feature}.json                │
│     - Format standardisé Ralph-compatible           │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  6. PRÉSENTER POUR VALIDATION                       │
│                                                     │
│     📋 PLAN : {titre}                               │
│     📝 Description : {description}                  │
│     📌 User Stories : (ordonnées par dépendance)    │
│     - US-001: {titre} → {fichiers}                  │
│     🔍 Edge Cases identifiés : {nombre}             │
│     🎯 Critères d'acceptation :                     │
│     - {critère 1}                                   │
│                                                     │
│     Valide ce plan ? (oui/non/modifier)             │
└─────────────────────────────────────────────────────┘
```

## BMAD Discovery Questions

Poser UNE question à la fois. Si réponse vague, challenger.

1. **Problem & Value** : Quel problème cette feature résout-elle ?
2. **Users** : Qui exactement l'utilise ? Dans quel contexte ?
3. **Core Behavior** : Si seulement 3 choses fonctionnent, lesquelles ?
4. **Success** : Comment sait-on que ça marche ? (critères mesurables)
5. **Non-Scope** : Qu'est-ce qui n'est PAS inclus ? (boundaries)

## 7 Catégories d'Edge Cases

**OBLIGATOIRE** : Pour chaque PRD, identifier les edge cases pertinents.

### 1. INPUT
- [ ] Champs vides / null / undefined
- [ ] Valeurs aux limites (min/max, 0, négatifs)
- [ ] Caractères spéciaux (émojis, HTML, SQL)
- [ ] Données très longues (texte 10K+, fichiers gros)
- [ ] Types invalides (string au lieu de number)

### 2. STATE
- [ ] Race conditions (double-submit, concurrent edits)
- [ ] Données stales (cache invalidation)
- [ ] État partiel (opération interrompue)
- [ ] État incohérent (BDD vs UI)

### 3. USER BEHAVIOR
- [ ] Double-click rapide
- [ ] Back button pendant action
- [ ] Refresh pendant submit
- [ ] Abandon de flow (fermer tab/naviguer)
- [ ] Multi-tab/multi-device

### 4. ERROR HANDLING
- [ ] Réseau coupé / timeout
- [ ] API rate limits
- [ ] Validation errors (Zod)
- [ ] Permission denied
- [ ] Resource not found

### 5. DATA
- [ ] Premier usage (empty state)
- [ ] Données legacy / migration
- [ ] Cascade deletes
- [ ] Données corrompues / malformées

### 6. SECURITY
- [ ] Session expirée mid-action
- [ ] Permissions changées pendant usage
- [ ] Injection attempts (XSS, SQL)
- [ ] Data leakage (logs, URLs)
- [ ] CSRF / token expiry

### 7. PERFORMANCE
- [ ] Cold start / first load
- [ ] Large payloads (1000+ items)
- [ ] Memory leaks (long sessions)
- [ ] N+1 queries
- [ ] Bundle size impact

## Format PRD Généré

```json
{
  "id": "feature-name",
  "title": "Titre Human-Readable",
  "description": "Description courte et claire",
  "branch": "feature/feature-name",
  "stories": [
    {
      "id": "US-001",
      "title": "Titre de la story (1-2 lignes max)",
      "description": "Ce qui doit être fait précisément",
      "files": ["src/path/to/file.tsx"],
      "acceptance": [
        "Typecheck passe",
        "Critère vérifiable spécifique"
      ],
      "dependencies": [],
      "status": "pending"
    }
  ],
  "edge_cases": [
    {
      "category": "INPUT",
      "case": "Champs vides",
      "severity": "HIGH",
      "handling": "Validation Zod avec message d'erreur"
    }
  ],
  "completion_criteria": [
    "npm run typecheck passe",
    "npm run lint passe",
    "Feature visible et fonctionnelle",
    "Edge cases HIGH/CRITICAL gérés"
  ],
  "created": "2026-01-19",
  "validated": false
}
```

## Story Quality Checklist

**AVANT de finaliser le PRD, vérifier :**

- [ ] Chaque story fait 1-2 lignes max (sinon splitter)
- [ ] Stories ordonnées par dépendance (schema → API → UI)
- [ ] Critères d'acceptation spécifiques (pas vagues)
- [ ] "Typecheck passe" inclus dans chaque story
- [ ] "Vérifier dans browser" pour stories UI
- [ ] Edge cases HIGH/CRITICAL ont une story dédiée

## Règles de Décomposition

1. **1 Story = 1 Commit potentiel**
   - Si la story touche > 3 fichiers, la splitter

2. **Critères Vérifiables**
   - ❌ "Le bouton est joli"
   - ✅ "Le bouton utilise la classe btn-sparkle"

3. **Fichiers Explicites**
   - Toujours lister les fichiers à modifier
   - Utiliser AGENTS.md mapping zones → fichiers

4. **Ordre par Dépendance**
   - DB schema / migrations en premier
   - Types/interfaces ensuite
   - API routes avant UI
   - Components avant pages
   - Tests en dernier

## Sévérité Edge Cases

| Sévérité | Action |
|----------|--------|
| CRITICAL | Story dédiée obligatoire |
| HIGH | Story dédiée ou intégré dans story existante |
| MEDIUM | Mentionné dans acceptance criteria |
| LOW | Documenté pour future iteration |

## Templates par Type

### Feature UI
```json
{
  "stories": [
    {"id": "US-001", "title": "Créer types/interfaces", "dependencies": []},
    {"id": "US-002", "title": "Créer styles CSS", "dependencies": ["US-001"]},
    {"id": "US-003", "title": "Créer composant", "dependencies": ["US-002"]},
    {"id": "US-004", "title": "Intégrer dans page", "dependencies": ["US-003"]},
    {"id": "US-005", "title": "Gérer edge cases input", "dependencies": ["US-004"]}
  ]
}
```

### Feature API
```json
{
  "stories": [
    {"id": "US-001", "title": "Créer/modifier schema BDD", "dependencies": []},
    {"id": "US-002", "title": "Créer validation Zod", "dependencies": ["US-001"]},
    {"id": "US-003", "title": "Créer route API", "dependencies": ["US-002"]},
    {"id": "US-004", "title": "Gérer erreurs et edge cases", "dependencies": ["US-003"]},
    {"id": "US-005", "title": "Connecter frontend", "dependencies": ["US-004"]}
  ]
}
```

### Bug Fix
```json
{
  "branch": "fix/bug-name",
  "stories": [
    {"id": "FIX-001", "title": "Reproduire et identifier cause"},
    {"id": "FIX-002", "title": "Appliquer correction"},
    {"id": "FIX-003", "title": "Ajouter test régression"}
  ]
}
```

## Intégration Workflow

```
Utilisateur: "Ajoute X"
        ↓
Claude: Pose questions BMAD (1 à la fois)
        ↓
Utilisateur: Répond
        ↓
Claude: /prd x-feature → Analyse + Edge Cases + Stories
        ↓
Claude: Présente le plan complet
        ↓
Utilisateur: "oui" / "modifie Y"
        ↓
Claude: /check-stories x-feature (validation)
        ↓
Claude: /ralph x-feature
```
