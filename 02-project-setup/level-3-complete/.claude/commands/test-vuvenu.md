---
name: test-vuvenu
description: "Tests complets environnement VuVenu"
---

# Test VuVenu - Suite de Tests Complète

Lance une suite de tests complète pour vérifier que l'environnement VuVenu fonctionne correctement.

## Usage

```
/test-vuvenu [scope]
```

**Scopes disponibles:**
- `/test-vuvenu` → Tests complets (défaut)
- `/test-vuvenu quick` → Tests rapides (typecheck + lint uniquement)
- `/test-vuvenu build` → Test build production
- `/test-vuvenu e2e` → Tests E2E (pages publiques)

## Workflow Complet

```
/test-vuvenu
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
│  4. TESTS E2E (si serveur dispo)                    │
│     Via Chrome MCP ou Playwright:                   │
│     ✓ Page d'accueil charge                         │
│     ✓ Navigation fonctionne                         │
│     ✓ Pas d'erreurs console JS                      │
│     ✓ Images se chargent                            │
│     ✓ Responsive mobile                             │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  5. RAPPORT FINAL                                   │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📋 TEST VUVENU REPORT                           │
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

Vérifie que ces vars sont définies :
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `ANTHROPIC_API_KEY` ou `GOOGLE_AI_API_KEY`

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

### 5. E2E Checks (via Chrome MCP)

| Page | Check |
|------|-------|
| `/` | Hero visible, boutons cliquables |
| `/pricing` | Cards pricing visibles |
| `/login` | Formulaire présent |
| `/register` | Formulaire présent |

## Intégration Workflow

### Avant PR
```
/test-vuvenu quick
```

### Avant Merge
```
/test-vuvenu
```

### Avant Deploy Prod
```
/test-vuvenu build
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
📋 TEST VUVENU REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Préliminaires
  ✅ Node.js: v20.10.0 ✓
  ✅ Dependencies: installed ✓
  ✅ Env vars: 8/8 present ✓
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
  ✅ Pricing: cards visible
  ✅ Console: no errors
  ✅ Images: all loaded
  ✅ Mobile: responsive OK

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 RESULT: ALL TESTS PASSED
🚀 Status: READY FOR DEPLOY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
