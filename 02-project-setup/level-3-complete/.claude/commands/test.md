---
name: test
description: "Tests complets (typecheck, lint, build, E2E)"
---

# Test - Suite de Tests Complète

Lance une suite de tests complète pour vérifier que le projet fonctionne correctement.

## Usage

```
/test [scope]
```

**Scopes disponibles:**
- `/test` → Tests complets (défaut)
- `/test quick` → Tests rapides (typecheck + lint uniquement)
- `/test build` → Test build production
- `/test e2e` → Tests E2E (Playwright)

## Workflow Complet

```
/test
    ↓
┌─────────────────────────────────────────────────────┐
│  1. VÉRIFICATIONS PRÉLIMINAIRES                     │
│     ✓ Node.js version compatible                    │
│     ✓ Dépendances installées (node_modules)         │
│     ✓ Variables d'environnement présentes           │
│     ✓ Serveur de dev accessible                     │
└─────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────┐
│  2. QUALITÉ CODE                                    │
│     ✓ npm run typecheck (TypeScript strict)         │
│     ✓ npm run lint (ESLint)                         │
│     ✓ Prettier format check                         │
└─────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────┐
│  3. BUILD TEST                                      │
│     ✓ npm run build (production build)              │
│     ✓ Vérifier taille bundle raisonnable            │
│     ✓ Pas d'erreurs de compilation                  │
└─────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────┐
│  4. TESTS E2E (si configuré)                        │
│     Via Playwright ou Chrome MCP:                   │
│     ✓ Pages principales chargent                    │
│     ✓ Navigation fonctionne                         │
│     ✓ Pas d'erreurs console JS                      │
│     ✓ Images se chargent                            │
│     ✓ Responsive mobile                             │
└─────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────┐
│  5. RAPPORT FINAL                                   │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📋 TEST REPORT                                  │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     ✅ Préliminaires: PASS                          │
│     ✅ TypeCheck: PASS (0 errors)                   │
│     ✅ ESLint: PASS (0 warnings)                    │
│     ✅ Build: PASS (45s)                            │
│     ✅ E2E: PASS (5/5 checks)                       │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     🎯 Status: READY FOR DEPLOY                     │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
└─────────────────────────────────────────────────────┘
```

## Checks Détaillés

### 1. Variables d'Environnement

Vérifie que les vars essentielles sont définies (selon projet).

### 2. TypeScript Strict

```bash
npm run typecheck
```

**Critères:** 0 erreurs TypeScript

### 3. ESLint

```bash
npm run lint
```

**Critères:** 0 erreurs, warnings acceptables

### 4. Build Production

```bash
npm run build
```

**Critères:**
- Build réussit sans erreurs
- Pas de warnings critiques
- Bundle size < 500KB (first load JS)

### 5. E2E Checks

| Page | Check |
|------|-------|
| `/` | Hero visible, boutons cliquables |
| Principales pages | Contenu visible |
| Console | Pas d'erreurs JS |
| Images | Toutes chargées |

## Types de Tests

| Type | Outil | Usage |
|------|-------|-------|
| **E2E** | Playwright | Features UI, parcours utilisateur |
| **Unitaires** | Vitest | Logique métier, fonctions |
| **Intégration** | Vitest + MSW | API endpoints |

## Intégration Workflow

### Avant PR
```
/test quick
```

### Avant Merge
```
/test
```

### Avant Deploy Prod
```
/test build
```

## En Cas d'Échec

Si un test échoue :

1. **TypeCheck fail** → Corriger erreurs TS
2. **Lint fail** → `npm run lint -- --fix` ou corriger manuellement
3. **Build fail** → Analyser erreur, souvent import manquant
4. **E2E fail** → Vérifier que serveur tourne, corriger erreur console

## Sortie Exemple

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 TEST REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Préliminaires
  ✅ Node.js: v20.10.0 ✓
  ✅ Dependencies: installed ✓
  ✅ Env vars: present ✓
  ✅ Dev server: running on :3000 ✓

📝 Code Quality
  ✅ TypeCheck: 0 errors
  ✅ ESLint: 0 errors, 2 warnings
  ⏱️ Duration: 12s

🏗️ Build
  ✅ Status: SUCCESS
  📦 Bundle: 312KB (first load JS)
  ⏱️ Duration: 45s

🌐 E2E Checks
  ✅ Homepage: loads correctly
  ✅ Console: no errors
  ✅ Images: all loaded
  ✅ Mobile: responsive OK

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 RESULT: ALL TESTS PASSED
🚀 Status: READY FOR DEPLOY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
