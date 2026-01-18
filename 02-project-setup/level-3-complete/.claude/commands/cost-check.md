---
name: cost-check
description: "Verifie la consommation tokens de la session"
---

# Cost Check - Suivi Consommation Tokens

Affiche un résumé de la consommation tokens de la session actuelle et des recommandations pour optimiser les coûts.

## Usage

```
/cost-check
```

## Workflow

```
/cost-check
        ↓
┌─────────────────────────────────────────────────────┐
│  💰 COST CHECK REPORT                               │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━         │
│                                                     │
│  📊 Session Actuelle                                │
│  ├─ Input tokens: XXX,XXX                          │
│  ├─ Output tokens: XX,XXX                          │
│  ├─ Cache read: X,XXX,XXX                          │
│  └─ Cache creation: XXX,XXX                        │
│                                                     │
│  💵 Coût Estimé: $X.XX                             │
│                                                     │
│  📈 Breakdown par Modèle                           │
│  ├─ Opus 4.5: $X.XX (XX%)                          │
│  ├─ Sonnet 4.5: $X.XX (XX%)                        │
│  └─ Haiku 4.5: $X.XX (XX%)                         │
│                                                     │
│  ⚠️ Alertes                                        │
│  └─ [Si > $5: "Session coûteuse, considérer pause"]│
│                                                     │
│  💡 Recommandations                                 │
│  ├─ Utiliser Haiku pour commits/lint               │
│  └─ Pause si > $10 par session                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━         │
└─────────────────────────────────────────────────────┘
```

## Seuils Budget VuVenu

| Seuil | Action |
|-------|--------|
| < $5 | ✅ Normal, continuer |
| $5-10 | ⚠️ Attention, évaluer nécessité |
| > $10 | 🚫 Pause recommandée |
| > $20 | 🛑 Arrêt obligatoire, nouvelle session |

## Stratégie Modèles

### Opus ($15/M input, $75/M output)
Utiliser pour :
- Architecture complexe
- Planning stratégique
- Code review approfondi
- Décisions techniques critiques

### Sonnet ($3/M input, $15/M output)
Utiliser pour :
- Développement features
- Debugging standard
- Refactoring mineur

### Haiku ($0.25/M input, $1.25/M output)
Utiliser pour :
- Commits conventionnels
- Linting/formatting
- Tâches répétitives
- Recherche simple

## Optimisations

1. **Cache Prompt** - Les tokens en cache coûtent 90% moins cher
   - Garder CLAUDE.md et AGENTS.md stables
   - Sessions longues = meilleur cache ratio

2. **Batch Operations** - Grouper les tâches similaires
   - Plusieurs commits → un seul `/commit`
   - Plusieurs fichiers → une seule session

3. **Modèle Approprié** - Utiliser Haiku quand possible
   - `/commit` avec Haiku
   - Recherche code avec Haiku

## Rappel Tarifs (Janvier 2026)

| Modèle | Input | Output | Cache Read |
|--------|-------|--------|------------|
| Opus 4.5 | $15/M | $75/M | $1.50/M |
| Sonnet 4.5 | $3/M | $15/M | $0.30/M |
| Haiku 4.5 | $0.25/M | $1.25/M | $0.025/M |

## Intégration Workflow

### En début de session
```
/cost-check
```
→ Vérifier budget restant

### Après tâche complexe
```
/cost-check
```
→ Évaluer si continuer ou pause

### En fin de session
```
/cost-check
```
→ Documenter coût total
