---
name: qa
description: "QA automatique post-deploy (test-and-break)"
---

# QA - Test and Break

QA automatique qui tente de casser l'application déployée. Génère des bug reports convertibles en stories.

## Usage

```
/qa [url] [scope]
```

**Exemples:**
- `/qa http://localhost:3000` - Test complet local
- `/qa https://app.example.com` - Test production
- `/qa http://localhost:3000 auth` - Test scope auth uniquement

**Scopes disponibles:**
- `full` (défaut) - Tous les tests
- `happy` - Happy paths uniquement
- `edge` - Edge cases uniquement
- `security` - Tests sécurité
- `performance` - Tests performance
- `auth` - Authentification
- `forms` - Formulaires

## Workflow

```
/qa [url]
        ↓
┌─────────────────────────────────────────────────────┐
│  1. HAPPY PATH TESTING                              │
│     - Navigation principale                         │
│     - Flows utilisateur normaux                     │
│     - Actions CRUD basiques                         │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. EDGE CASE TESTING                               │
│     - Inputs invalides                              │
│     - États limites                                 │
│     - Comportements utilisateur anormaux            │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. ERROR SCENARIO TESTING                          │
│     - Erreurs réseau simulées                       │
│     - Timeouts                                      │
│     - Permissions manquantes                        │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. SECURITY TESTING                                │
│     - XSS attempts                                  │
│     - Injection tests                               │
│     - Auth bypass attempts                          │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  5. PERFORMANCE TESTING                             │
│     - Load time                                     │
│     - Large data sets                               │
│     - Memory usage                                  │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  6. ACCESSIBILITY TESTING                           │
│     - Keyboard navigation                           │
│     - Screen reader compatibility                   │
│     - Color contrast                                │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  7. BUG REPORT                                      │
│     🐛 QA REPORT - [date]                           │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     🔗 URL: [url]                                   │
│     📊 Tests: X passed, Y failed                    │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│                                                     │
│     🚫 BUGS FOUND (Y)                               │
│     1. [BUG-001] Sévérité: HIGH                     │
│        Page: /path                                  │
│        Steps to reproduce: ...                      │
│        Expected: ...                                │
│        Actual: ...                                  │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     💡 Convertir en stories ? (oui/non)             │
└─────────────────────────────────────────────────────┘
```

## Tests par Catégorie

### 1. Happy Path Testing

| Test | Vérification |
|------|--------------|
| Homepage | Page charge, éléments visibles |
| Navigation | Tous les liens fonctionnent |
| Auth flow | Login/Register/Logout OK |
| CRUD | Create/Read/Update/Delete OK |
| Forms | Submit fonctionne |

### 2. Edge Case Testing

| Catégorie | Tests |
|-----------|-------|
| **Input** | Champs vides, caractères spéciaux, données très longues |
| **State** | Double-click, back button, refresh mid-action |
| **Timing** | Actions rapides consécutives, timeouts |
| **Data** | Empty states, 0 results, pagination limites |

### 3. Error Scenario Testing

| Scénario | Test |
|----------|------|
| Network | Couper réseau pendant action |
| API | Simuler 500, 404, timeout |
| Validation | Soumettre données invalides |
| Auth | Token expiré, permissions insuffisantes |

### 4. Security Testing

| Test | Méthode |
|------|---------|
| **XSS** | `<script>alert('xss')</script>` dans champs |
| **SQL Injection** | `'; DROP TABLE users; --` dans search |
| **Auth Bypass** | Accès URL protégée sans auth |
| **CSRF** | Actions sans token valide |
| **Data Exposure** | Vérifier console, network, source |

### 5. Performance Testing

| Métrique | Seuil |
|----------|-------|
| **LCP** | < 2.5s |
| **FID** | < 100ms |
| **CLS** | < 0.1 |
| **Bundle** | < 500KB first load |
| **API** | < 200ms response |

### 6. Accessibility Testing

| Test | Critère |
|------|---------|
| Keyboard | Tab navigation complète |
| Focus | Focus visible sur éléments |
| Labels | Tous inputs ont labels |
| Alt | Images ont alt text |
| Contrast | Ratio > 4.5:1 |

## Format Bug Report

```markdown
## 🐛 BUG-001: [Titre court]

**Sévérité:** CRITICAL / HIGH / MEDIUM / LOW

**Page:** /path/to/page

**Steps to Reproduce:**
1. Aller sur [page]
2. Faire [action]
3. Observer [résultat]

**Expected:** [Comportement attendu]

**Actual:** [Comportement observé]

**Screenshot/Video:** [Si applicable]

**Browser:** Chrome 120 / Firefox / Safari

**Console Errors:**
```
[Erreurs si applicable]
```

**Suggested Fix:** [Si évident]
```

## Conversion Bugs → Stories

Après le rapport, option de convertir en PRD :

```
/qa-to-prd [qa-report-date]
```

Génère automatiquement :
- PRD avec stories pour chaque bug
- Priorité basée sur sévérité
- Fichiers à modifier identifiés

## Intégration Workflow

### Après Deploy

```
/ralph feature-name
        ↓
/test
        ↓
/review
        ↓
/commit
        ↓
Deploy (manuel ou CI)
        ↓
/qa https://deployed-url.com  ← NOUVEAU
        ↓
    Bugs found?
        ↓ OUI
/qa-to-prd → /ralph fix-bugs
```

### Pipeline Complet

```
Development:  /prd → /ralph → /test → /review → /commit
                                                    ↓
Deployment:                                     Deploy
                                                    ↓
QA:                                            /qa [url]
                                                    ↓
Fix:                               /qa-to-prd → /ralph
```

## Exemple Sortie

```
🐛 QA REPORT - 2026-01-19
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔗 URL: http://localhost:3000
⏱️ Duration: 5 min
📊 Tests: 24 passed, 3 failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ PASSED (24)
  ✓ Homepage loads
  ✓ Navigation works
  ✓ Auth flow complete
  ✓ Forms submit correctly
  ... (20 more)

🚫 BUGS FOUND (3)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🐛 BUG-001: Double-submit creates duplicates
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Sévérité: HIGH
Page: /dashboard/scripts/new
Steps: Double-click "Generate" rapidly
Expected: One script created
Actual: Two identical scripts created
Fix: Disable button during submit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🐛 BUG-002: XSS in search field
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Sévérité: CRITICAL
Page: /dashboard/scripts
Steps: Enter <script>alert(1)</script> in search
Expected: Text displayed escaped
Actual: Alert executes
Fix: Sanitize input / use textContent

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🐛 BUG-003: Missing loading state
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Sévérité: MEDIUM
Page: /dashboard
Steps: Refresh page
Expected: Loading indicator while data loads
Actual: Blank page for 2s
Fix: Add Suspense/loading state

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Summary:
  CRITICAL: 1
  HIGH: 1
  MEDIUM: 1
  LOW: 0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Convertir ces 3 bugs en PRD ? (oui/non)
```

## Outils Utilisés

| Outil | Usage |
|-------|-------|
| **Browser MCP** | Navigation, clicks, screenshots |
| **Playwright** | Tests automatisés si configuré |
| **Console** | Vérifier erreurs JS |
| **Network** | Vérifier appels API |
| **Lighthouse** | Metrics performance |
