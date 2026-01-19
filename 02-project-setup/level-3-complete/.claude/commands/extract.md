---
name: extract
description: "Extrait un learning en skill reutilisable (Claudeception)"
---

# Extract - Skill Extraction (Claudeception)

Extrait un learning non-évident découvert pendant le debug en skill réutilisable.

> **Principe** : Chaque découverte non-triviale doit bénéficier aux sessions futures.

## Usage

```
/extract [description-courte]
```

**Exemples:**
- `/extract supabase-rls-realtime`
- `/extract nextjs-middleware-loop`
- `/extract stripe-webhook-timeout`

## Workflow

```
/extract [nom]
        ↓
┌─────────────────────────────────────────────────────┐
│  1. ÉVALUATION                                      │
│     Est-ce que ça mérite un skill ?                 │
│     □ Non-évident (>10 min debug)                   │
│     □ Réutilisable (pas single-use)                 │
│     □ Vérifié (solution testée)                     │
│     □ Pas de données sensibles                      │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  2. STRUCTURATION                                   │
│     - Identifier le problème exact                  │
│     - Documenter la cause racine                    │
│     - Écrire la solution                            │
│     - Ajouter références si applicable              │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  3. DESCRIPTION SÉMANTIQUE                          │
│     - Inclure erreur/symptôme exact                 │
│     - Lister triggers ("Use when...")               │
│     - Mentionner stack technique                    │
└─────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────┐
│  4. SAUVEGARDE                                      │
│     - Créer .claude/skills/{nom}/SKILL.md           │
│     - Confirmer création                            │
└─────────────────────────────────────────────────────┘
```

## Critères d'Extraction

### ✅ EXTRAIRE si :

| Critère | Exemple |
|---------|---------|
| **Debug >10 min** | Erreur cryptique nécessitant investigation |
| **Erreur trompeuse** | Message d'erreur ne reflète pas la vraie cause |
| **Workaround** | Solution trouvée par expérimentation |
| **Config spécifique** | Setup propre au projet/stack |
| **Trial-and-error** | Plusieurs tentatives avant succès |
| **Pas dans la doc** | Solution non documentée officiellement |

### ❌ NE PAS EXTRAIRE si :

| Critère | Raison |
|---------|--------|
| **Dans la documentation** | Pas de valeur ajoutée |
| **Single-use** | Ne s'applique qu'à ce cas précis |
| **Données sensibles** | Credentials, URLs internes |
| **Skill existant** | Duplication inutile |
| **Solution évidente** | Pas besoin de mémoriser |

## Format Description Sémantique

**CRITIQUE** : La description détermine quand le skill est chargé.

```yaml
description: |
  [Problème]: Description exacte de l'erreur ou comportement
  Use when: (1) trigger 1, (2) trigger 2, (3) trigger 3
  Stack: Technologies concernées
```

### Exemples de Bonnes Descriptions

```yaml
# ✅ BON - Spécifique et actionable
description: |
  Supabase realtime subscriptions return empty despite rows in database.
  Use when: (1) realtime listener receives no data, (2) RLS policies
  block subscription channels, (3) SELECT policy missing for realtime.
  Stack: Supabase, Next.js, PostgreSQL RLS

# ❌ MAUVAIS - Trop vague
description: |
  Helps with database problems.
```

## Template SKILL.md

```markdown
---
name: [nom-kebab-case]
description: |
  [Problème]: Description exacte
  Use when: (1) trigger 1, (2) trigger 2
  Stack: [technologies]
---

# [Titre Descriptif]

## Problème
[Description du problème]

**Symptômes:**
- [Symptôme 1]
- [Symptôme 2]

**Message d'erreur:**
\`\`\`
[Message exact]
\`\`\`

## Cause Racine
[Explication de pourquoi]

## Solution
[Description + code]

## Vérification
1. [Comment vérifier que ça marche]

## Références
- [Liens documentation]

## Métadonnées
- **Date**: YYYY-MM-DD
- **Projet**: [origine]
- **Temps debug**: [estimation]
```

## Intégration Workflow

### Après Debug Session

```
[Session de debug terminée]
        ↓
Claude: "J'ai découvert quelque chose de non-évident. Extraire en skill ?"
        ↓
Utilisateur: "oui" ou /extract nom-du-skill
        ↓
Claude: Crée le skill dans .claude/skills/
```

### Évaluation Automatique

À la fin de chaque session significative, se demander :

1. **Ai-je appris quelque chose de non-évident ?**
2. **Est-ce que ça prendrait >5 min à redécouvrir ?**
3. **Est-ce applicable à d'autres situations ?**

Si OUI aux 3 → proposer `/extract`

## Exemple Complet

**Situation** : Debug de 20 min sur pourquoi les subscriptions Supabase retournent vide.

**Commande** : `/extract supabase-rls-realtime`

**Skill créé** : `.claude/skills/supabase-rls-realtime/SKILL.md`

```markdown
---
name: supabase-rls-realtime
description: |
  Supabase realtime subscriptions return empty despite data in tables.
  Use when: (1) realtime listener receives no data, (2) RLS enabled on
  table, (3) data visible in Supabase dashboard but not in subscription.
  Stack: Supabase, PostgreSQL, Next.js
---

# Supabase RLS Blocks Realtime Subscriptions

## Problème
Les subscriptions Supabase Realtime retournent un array vide même quand
il y a des données dans la table.

**Symptômes:**
- `onInsert`, `onUpdate` callbacks ne sont jamais appelés
- Données visibles dans le dashboard Supabase
- Pas d'erreur dans la console

## Cause Racine
RLS policies bloquent aussi les channels realtime. Une policy SELECT
est nécessaire même pour les subscriptions.

## Solution
Ajouter une policy SELECT pour l'utilisateur authentifié :

\`\`\`sql
CREATE POLICY "Users can subscribe to own data"
ON my_table
FOR SELECT
USING (user_id = auth.uid());
\`\`\`

## Vérification
1. Ajouter la policy
2. Refresh la page
3. Les subscriptions reçoivent maintenant les données

## Références
- https://supabase.com/docs/guides/realtime/postgres-changes#database-setup

## Métadonnées
- **Date**: 2026-01-19
- **Projet**: VuVenu
- **Temps debug**: 20 min
```

## Où Sauvegarder

| Scope | Chemin | Usage |
|-------|--------|-------|
| **Projet** | `.claude/skills/` | Skills spécifiques au projet |
| **Global** | `~/.claude/skills/` | Skills réutilisables partout |

Par défaut : sauvegarde dans le projet (`.claude/skills/`).
