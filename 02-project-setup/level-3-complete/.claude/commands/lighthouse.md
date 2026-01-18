---
name: lighthouse
description: "Audit performance et accessibilité de la page"
---

# Lighthouse - Audit Performance

Lance un audit Lighthouse sur une page VuVenu pour vérifier performance, accessibilité, SEO et best practices.

## Usage

```
/lighthouse [url]
```

**Exemples:**
- `/lighthouse` → Audit page d'accueil (localhost:3000)
- `/lighthouse /pricing` → Audit page pricing
- `/lighthouse https://vuvenu.com` → Audit production

## Ce que l'audit vérifie

### Performance (LCP < 2.5s obligatoire)
- Largest Contentful Paint (LCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)
- Time to First Byte (TTFB)

### Accessibilité
- Contraste des couleurs
- Labels des formulaires
- Navigation clavier
- Structure des headings

### SEO
- Meta tags présents
- Structured data
- Mobile-friendly
- Crawlabilité

### Best Practices
- HTTPS
- Console errors
- Images optimisées
- Modern JS

## Workflow

```
/lighthouse
        ↓
┌─────────────────────────────────────────────────────┐
│  1. DÉMARRER AUDIT                                  │
│     - Ouvrir Chrome via Playwright MCP              │
│     - Naviguer vers l'URL cible                     │
│     - Lancer Lighthouse                             │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. COLLECTER MÉTRIQUES                             │
│     - Performance score                             │
│     - Accessibility score                           │
│     - SEO score                                     │
│     - Best Practices score                          │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. ANALYSER RÉSULTATS                              │
│     - Identifier points critiques (< 90)            │
│     - Lister recommandations                        │
│     - Prioriser par impact                          │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. RAPPORT                                         │
│     📊 LIGHTHOUSE AUDIT                             │
│     🎯 Performance: XX/100                          │
│     ♿ Accessibility: XX/100                         │
│     🔍 SEO: XX/100                                  │
│     ✅ Best Practices: XX/100                       │
│                                                     │
│     ⚠️ Issues critiques:                            │
│     - [Liste des problèmes]                         │
│                                                     │
│     💡 Recommandations:                             │
│     - [Actions à prendre]                           │
└─────────────────────────────────────────────────────┘
```

## Seuils VuVenu

| Métrique | Minimum | Cible |
|----------|---------|-------|
| Performance | 80 | 95+ |
| Accessibility | 90 | 100 |
| SEO | 90 | 100 |
| Best Practices | 90 | 100 |
| LCP | < 2.5s | < 1.5s |
| CLS | < 0.1 | < 0.05 |

## Sans Playwright MCP

Si Playwright MCP n'est pas disponible, utiliser la commande Lighthouse CLI :

```bash
npx lighthouse http://localhost:3000 --output=json --output-path=./lighthouse-report.json
```

Puis analyser le JSON généré.

## Intégration Ralph

Après une feature complétée par Ralph, lancer :
```
/lighthouse
```

Si scores < seuils → créer PRD pour corrections performance.
