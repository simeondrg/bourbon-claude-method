---
name: compound
description: "Documente les apprentissages apres une feature (Compound Engineering)"
---

# Compound - Documentation des Learnings

Documente les apprentissages d'une feature pour que les prochaines itérations soient plus rapides.

> "Chaque unité de travail doit rendre les suivantes plus faciles."

## Usage

```
/compound [feature-name]
```

**Exemples:**
- `/compound unified-buttons` → Documente les learnings du PRD unified-buttons
- `/compound` → Documente les learnings de la dernière feature

## Workflow

```
/compound [feature]
        ↓
┌─────────────────────────────────────────────────────┐
│  1. ANALYSER FEATURE                                │
│     - Lire PRD (tasks/prd-{feature}.json)           │
│     - Identifier fichiers modifiés                  │
│     - Analyser commits associés                     │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. IDENTIFIER LEARNINGS                            │
│     Questions à se poser:                           │
│     - Nouveau pattern réutilisable ?                │
│     - Gotcha/bug non évident rencontré ?            │
│     - Convention établie importante ?               │
│     - Outil/technique découvert ?                   │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. METTRE À JOUR AGENTS.md                         │
│     Si learnings pertinents trouvés:                │
│     - Ajouter dans section appropriée               │
│     - Inclure code pattern si applicable            │
│     - Dater l'entrée                                │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. RAPPORT                                         │
│     📚 COMPOUND ENGINEERING REPORT                  │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│     Feature: {feature-name}                         │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
│                                                     │
│     ✅ Learnings documentés: 2                      │
│     - Pattern: btn-sparkle pour CTA                 │
│     - Gotcha: CSS hot reload nécessite restart      │
│                                                     │
│     📝 AGENTS.md mis à jour                         │
│     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      │
└─────────────────────────────────────────────────────┘
```

## Critères pour Documenter

### ✅ À DOCUMENTER

1. **Patterns Réutilisables**
   - Code pattern applicable à d'autres features
   - Structure de fichier/composant à répliquer
   - Configuration spécifique qui a fonctionné

2. **Gotchas Non Évidents**
   - Bug difficile à diagnostiquer
   - Comportement inattendu d'une lib
   - Incompatibilité découverte

3. **Conventions Établies**
   - Choix d'architecture pris
   - Naming convention décidée
   - Best practice adoptée

### ❌ À NE PAS DOCUMENTER

- Détails spécifiques à une seule feature
- Informations déjà présentes dans AGENTS.md
- Patterns évidents/triviaux (ex: "utiliser useState")
- Code trop spécifique sans valeur générique

## Format d'Entrée AGENTS.md

```markdown
### Pattern X: [Titre Descriptif]
**Date**: YYYY-MM-DD
**Context**: [Situation qui a mené à ce learning]

**Learning**:
- Point clé 1
- Point clé 2

**Code Pattern** (si applicable):
\`\`\`typescript
// Exemple de code réutilisable
\`\`\`
```

## Sections AGENTS.md

| Section | Type de Learning |
|---------|-----------------|
| 🏗️ Architecture Patterns | Structure, schéma BDD |
| 🔐 Sécurité Patterns | Auth, RLS, validation |
| 🧪 Testing Patterns | Tests, debug |
| 🎨 UI/UX Patterns | Composants, styles |
| 🚀 Déploiement Patterns | CI/CD, env vars |
| 📊 Monitoring & Logging | Logs, analytics |
| 🔄 Ralph Loop Learnings | Workflow, automation |

## Intégration Workflow

Après chaque feature complétée par Ralph :

```
/ralph feature-name
        ↓
[Feature implémentée et PR créée]
        ↓
/compound feature-name
        ↓
[Learnings documentés dans AGENTS.md]
```

## Exemple Complet

```
Utilisateur: /compound unified-buttons

Claude:
📚 COMPOUND ENGINEERING REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Feature: unified-buttons
Files: 4 modified
Commits: 3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Analyse des changements...

✅ Learnings identifiés: 2

1️⃣ **Pattern: btn-sparkle pour CTA**
   Classe CSS unifiée pour tous les boutons call-to-action
   avec effet glow et animation hover.
   → Ajouté dans section UI/UX Patterns

2️⃣ **Gotcha: CSS Hot Reload**
   Next.js Turbopack ne recharge pas toujours le CSS modifié.
   Solution: redémarrer npm run dev.
   → Ajouté dans section UI/UX Patterns

📝 AGENTS.md mis à jour avec 2 nouvelles entrées

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 Prochaine feature bénéficiera de ces learnings
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Métriques Compound

Au fil du temps, suivre :
- Nombre de patterns documentés
- Temps gagné grâce aux patterns existants
- Réduction des erreurs récurrentes
