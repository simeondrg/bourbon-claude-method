---
name: security
description: "Scan de securite automatique (secrets, vulnerabilites)"
---

# Security - Scan Automatique

Lance des scans de sécurité pour détecter secrets hardcodés, vulnérabilités et problèmes de config.

## Usage

```
/security              # Scan complet
/security secrets      # Scan secrets uniquement (gitleaks)
/security deps         # Scan dépendances (npm audit)
/security code         # Scan code (patterns dangereux)
/security quick        # Scan rapide (secrets + deps)
```

## Workflow

```
/security
        ↓
┌─────────────────────────────────────────────────────┐
│  1. SCAN SECRETS (Gitleaks-like)                    │
│     - Clés API hardcodées                           │
│     - Passwords en clair                            │
│     - Tokens dans le code                           │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. SCAN DÉPENDANCES                                │
│     - npm audit                                     │
│     - Vulnérabilités connues (CVE)                  │
│     - Packages obsolètes                            │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. SCAN CODE                                       │
│     - Injections SQL/XSS                            │
│     - Eval() dangereux                              │
│     - Patterns OWASP                                │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. RAPPORT                                         │
│                                                     │
│     🔒 SECURITY REPORT                              │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     📊 Scans: 3 completed                           │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│                                                     │
│     🚫 CRITICAL (0)                                 │
│     ⚠️ HIGH (2)                                    │
│       - Hardcoded API key in config.ts             │
│       - SQL injection risk in search.ts            │
│     📝 MEDIUM (1)                                   │
│       - npm audit: lodash CVE                      │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     🎯 Verdict: NEEDS ATTENTION                     │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
└─────────────────────────────────────────────────────┘
```

## Scans Détaillés

### 1. Secrets Scan

**Patterns détectés :**

| Type | Regex Pattern | Exemple |
|------|---------------|---------|
| AWS Key | `AKIA[0-9A-Z]{16}` | AKIAIOSFODNN7EXAMPLE |
| API Key generic | `api[_-]?key.*=.*['"][a-zA-Z0-9]{20,}` | api_key="abc123..." |
| Password | `password.*=.*['"][^'"]+['"]` | password="secret123" |
| Private Key | `-----BEGIN.*PRIVATE KEY-----` | RSA/EC keys |
| JWT | `eyJ[a-zA-Z0-9_-]+\.eyJ[a-zA-Z0-9_-]+` | JWT tokens |
| Stripe | `sk_live_[a-zA-Z0-9]{24,}` | sk_live_... |
| Supabase | `sbp_[a-zA-Z0-9]{40,}` | sbp_... |

**Fichiers ignorés :**
- `.env.example`
- `*.md` (documentation)
- `node_modules/`
- `.git/`
- `*.test.ts`

### 2. Dependencies Scan

```bash
# NPM
npm audit --json

# Analyse des résultats
- Critical: Exploit connu, patch requis immédiatement
- High: Vulnérabilité exploitable, patch recommandé
- Moderate: Conditions spécifiques pour exploit
- Low: Risque minime
```

**Actions automatiques :**
```bash
npm audit fix           # Fix auto pour non-breaking
npm audit fix --force   # Fix avec breaking changes (demande confirmation)
```

### 3. Code Scan

**Patterns OWASP détectés :**

| Catégorie | Pattern | Risque |
|-----------|---------|--------|
| **SQL Injection** | String concat dans queries | CRITICAL |
| **XSS** | `dangerouslySetInnerHTML`, `innerHTML` | HIGH |
| **Command Injection** | `exec()`, `eval()` avec user input | CRITICAL |
| **Path Traversal** | `../` dans file paths | HIGH |
| **Insecure Crypto** | `md5()`, `sha1()` pour passwords | MEDIUM |
| **Debug Code** | `console.log` avec data sensible | LOW |

**Exemple détection SQL Injection :**
```typescript
// ❌ DÉTECTÉ: SQL Injection risk
const query = `SELECT * FROM users WHERE id = ${userId}`

// ✅ OK: Parameterized query
const { data } = await supabase.from('users').select().eq('id', userId)
```

## Intégration Workflow

### Avant Commit (recommandé)

```
/security quick
        ↓
    Problèmes ?
        ↓ OUI
    Fix avant /commit
```

### Avant PR

```
/security
        ↓
    CRITICAL ou HIGH ?
        ↓ OUI
    Fix obligatoire
```

### Dans /review

Le skill `/review` inclut automatiquement un check sécurité basique.

## Configuration

### .securityignore

Créer un fichier `.securityignore` pour exclure des faux positifs :

```
# Fichiers de test avec fake secrets
tests/fixtures/fake-credentials.ts
tests/mocks/api-keys.ts

# Exemples de documentation
docs/examples/

# Patterns spécifiques
**/EXAMPLE_*
```

### Seuils de Blocage

| Sévérité | Action par défaut |
|----------|-------------------|
| CRITICAL | Block commit |
| HIGH | Warning + confirmation |
| MEDIUM | Warning only |
| LOW | Info only |

## Outils Externes (Optionnel)

Pour des scans plus approfondis, installer :

### Gitleaks (secrets)
```bash
brew install gitleaks
gitleaks detect -v
```

### Trivy (deps + containers)
```bash
brew install trivy
trivy fs .
```

### Semgrep (SAST)
```bash
brew install semgrep
semgrep --config=auto .
```

## Exemple Sortie

```
🔒 SECURITY REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 Date: 2026-01-19
📁 Files scanned: 142
⏱️ Duration: 8s
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 SECRETS SCAN
  ✅ No hardcoded secrets found

📦 DEPENDENCIES SCAN
  ⚠️ 2 vulnerabilities found
    HIGH: lodash < 4.17.21 (CVE-2021-23337)
          Fix: npm audit fix
    MEDIUM: axios < 1.6.0 (CVE-2023-45857)
          Fix: npm update axios

💻 CODE SCAN
  ⚠️ 1 issue found
    MEDIUM: src/lib/search.ts:45
            Potential XSS: dangerouslySetInnerHTML
            Suggestion: Sanitize input or use textContent

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Summary:
  CRITICAL: 0
  HIGH: 1
  MEDIUM: 2
  LOW: 0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 Verdict: NEEDS ATTENTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Recommandations:
   1. Run: npm audit fix
   2. Review dangerouslySetInnerHTML usage in search.ts
```

## Quick Reference

| Commande | Durée | Usage |
|----------|-------|-------|
| `/security quick` | ~5s | Avant chaque commit |
| `/security secrets` | ~3s | Check rapide secrets |
| `/security` | ~15s | Avant PR/merge |
