---
name: review-vuvenu
description: "Code review VuVenu avec agent specialise"
---

# Review VuVenu - Code Review Spécialisé

Lance une code review complète des changements en cours, adaptée aux standards VuVenu.

## Usage

```
/review-vuvenu [scope]
```

**Scopes:**
- `/review-vuvenu` → Review des changements staged (défaut)
- `/review-vuvenu pr` → Review de la PR courante
- `/review-vuvenu file src/path` → Review d'un fichier spécifique
- `/review-vuvenu full` → Review complète du codebase

## Workflow

```
/review-vuvenu
        ↓
┌─────────────────────────────────────────────────────┐
│  1. COLLECTER CHANGEMENTS                           │
│     - git diff --staged (ou scope spécifié)         │
│     - Identifier fichiers modifiés                  │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. ANALYSE PAR CATÉGORIE                           │
│     - TypeScript/Types                              │
│     - Sécurité (RLS, validation)                    │
│     - Performance (LCP, bundle)                     │
│     - Patterns VuVenu (AGENTS.md)                   │
│     - Accessibilité                                 │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. RAPPORT REVIEW                                  │
│     🔍 VUVENU CODE REVIEW                           │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📁 Files: 5 modified                            │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│                                                     │
│     ✅ PASSED                                       │
│     - TypeScript strict: OK                         │
│     - ESLint: 0 errors                              │
│                                                     │
│     ⚠️ WARNINGS (3)                                │
│     - [fichier:ligne] Description                   │
│                                                     │
│     🚫 BLOCKERS (0)                                 │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📊 Score: 92/100                                │
│     🎯 Verdict: APPROVED                            │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
└─────────────────────────────────────────────────────┘
```

## Checklist VuVenu

### TypeScript
- [ ] Pas de `any` non justifié
- [ ] Types explicites sur fonctions exportées
- [ ] Interfaces pour objets complexes

### Sécurité
- [ ] Validation Zod sur inputs API
- [ ] RLS policies sur nouvelles tables
- [ ] Pas de secrets en dur
- [ ] Sanitization des inputs utilisateur

### Performance
- [ ] Images via `next/image`
- [ ] Lazy loading composants lourds
- [ ] Pas de re-renders inutiles
- [ ] Bundle size raisonnable

### Patterns VuVenu (AGENTS.md)
- [ ] Boutons CTA utilisent `btn-sparkle`
- [ ] Erreurs Supabase gérées (`{ data, error }`)
- [ ] Loading states explicites
- [ ] Structure imports respectée

### Accessibilité
- [ ] Labels sur inputs
- [ ] Alt sur images
- [ ] Contraste suffisant
- [ ] Navigation clavier possible

## Niveaux de Sévérité

| Niveau | Symbole | Action |
|--------|---------|--------|
| Blocker | 🚫 | Doit être corrigé avant merge |
| Warning | ⚠️ | Devrait être corrigé |
| Info | ℹ️ | Suggestion d'amélioration |
| Passed | ✅ | Conforme aux standards |

## Scoring

```
Score = 100 - (blockers * 20) - (warnings * 5) - (infos * 1)

90-100: APPROVED
70-89:  APPROVED WITH WARNINGS
50-69:  NEEDS CHANGES
<50:    REJECTED
```

## Intégration Workflow

### Avant Commit
```bash
# Stage tes changements
git add .

# Lance la review
/review-vuvenu
```

### Avant PR
```bash
/review-vuvenu full
```

### Sur PR Existante
```bash
/review-vuvenu pr
```

## Exemple Sortie

```
🔍 VUVENU CODE REVIEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Files reviewed: 5
📝 Lines changed: +124 / -32
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ PASSED
  ✓ TypeScript: 0 errors
  ✓ ESLint: 0 errors
  ✓ Patterns VuVenu: btn-sparkle utilisé
  ✓ Sécurité: validation Zod présente

⚠️ WARNINGS (2)
  1. src/app/api/generate/route.ts:45
     → Erreur Supabase non loggée côté serveur
     Suggestion: Ajouter console.error() avant throw

  2. src/components/campaign-form.tsx:78
     → Missing loading state pendant génération
     Suggestion: Ajouter état isGenerating

ℹ️ INFO (1)
  1. src/lib/ai/gemini.ts:12
     → Timeout hardcodé (30000ms)
     Suggestion: Extraire en constante configurable

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Score: 88/100
🎯 Verdict: APPROVED WITH WARNINGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Corrections recommandées avant merge:
   1. Ajouter logging erreur dans route.ts
   2. Ajouter loading state dans campaign-form.tsx
```
