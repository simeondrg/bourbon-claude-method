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
│  1. ANALYSE CODEBASE                                │
│     - Identifier fichiers concernés                 │
│     - Vérifier patterns existants (AGENTS.md)       │
│     - Détecter dépendances                          │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. DÉCOMPOSITION EN STORIES                        │
│     - 1 story = 1 changement atomique               │
│     - Max 5-7 stories par PRD                       │
│     - Critères d'acceptation clairs                 │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. GÉNÉRER PRD JSON                                │
│     - Créer tasks/prd-{feature}.json                │
│     - Format standardisé Ralph-compatible           │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. PRÉSENTER POUR VALIDATION                       │
│                                                     │
│     📋 PLAN : {titre}                               │
│     📝 Description : {description}                  │
│     📌 User Stories :                               │
│     - US-001: {titre} → {fichiers}                  │
│     - US-002: {titre} → {fichiers}                  │
│     🎯 Critères d'acceptation :                     │
│     - {critère 1}                                   │
│     - {critère 2}                                   │
│                                                     │
│     Valide ce plan ? (oui/non/modifier)             │
└─────────────────────────────────────────────────────┘
```

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
      "title": "Titre de la story",
      "description": "Ce qui doit être fait précisément",
      "files": ["src/path/to/file.tsx"],
      "acceptance": [
        "Critère vérifiable 1",
        "Critère vérifiable 2"
      ],
      "status": "pending"
    }
  ],
  "completion_criteria": [
    "npm run typecheck passe",
    "npm run lint passe",
    "Feature visible et fonctionnelle"
  ],
  "created": "2026-01-18",
  "validated": false
}
```

## Bonnes Pratiques PRD (Ralph Wiggum)

### ✅ BON PRD

```markdown
**Titre**: Ajouter toggle dark mode

**Stories**:
1. Créer CSS variables pour thèmes → globals.css
2. Créer composant ThemeToggle → components/ui/
3. Persister préférence localStorage → hooks/useTheme.ts
4. Intégrer dans Header → components/dashboard/header.tsx

**Critères**:
- Toggle visible dans header
- Thème persiste après refresh
- Transition smooth entre thèmes
```

### ❌ MAUVAIS PRD

```markdown
"Ajouter dark mode et le rendre beau"
```

Problèmes :
- Pas de stories atomiques
- "Beau" n'est pas vérifiable
- Pas de fichiers identifiés

## Règles de Décomposition

1. **1 Story = 1 Commit potentiel**
   - Si la story touche > 3 fichiers, la splitter

2. **Critères Vérifiables**
   - ❌ "Le bouton est joli"
   - ✅ "Le bouton utilise la classe btn-sparkle"

3. **Fichiers Explicites**
   - Toujours lister les fichiers à modifier
   - Utiliser CLAUDE.md mapping zones → fichiers

4. **Ordre Logique**
   - CSS/styles avant composants
   - Hooks/utils avant composants qui les utilisent
   - Tests en dernier (si applicable)

## Intégration Workflow

```
Utilisateur: "Ajoute X"
        ↓
Claude: /prd x-feature "Ajoute X"
        ↓
Claude: Présente le plan
        ↓
Utilisateur: "oui"
        ↓
Claude: /ralph x-feature
```

## Templates par Type

### Feature UI
```json
{
  "stories": [
    {"id": "US-001", "title": "Créer styles CSS", "files": ["globals.css"]},
    {"id": "US-002", "title": "Créer composant", "files": ["components/..."]},
    {"id": "US-003", "title": "Intégrer dans page", "files": ["app/...page.tsx"]}
  ]
}
```

### Feature API
```json
{
  "stories": [
    {"id": "US-001", "title": "Créer route API", "files": ["app/api/.../route.ts"]},
    {"id": "US-002", "title": "Ajouter validation Zod", "files": ["lib/validations/..."]},
    {"id": "US-003", "title": "Connecter frontend", "files": ["components/..."]}
  ]
}
```

### Bug Fix
```json
{
  "branch": "fix/bug-name",
  "stories": [
    {"id": "FIX-001", "title": "Identifier cause", "files": ["..."]},
    {"id": "FIX-002", "title": "Appliquer correction", "files": ["..."]},
    {"id": "FIX-003", "title": "Ajouter test régression", "files": ["..."]}
  ]
}
```
