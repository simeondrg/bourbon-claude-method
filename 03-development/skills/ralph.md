# /ralph - Loop d'Implémentation Autonome

## Usage

```
/ralph [prd-name]
```

Exemple :
```
/ralph auth-system
```

---

## Ce que ça fait

Ralph est un agent autonome qui :

1. Lit le PRD depuis `tasks/[prd-name].json`
2. Implémente chaque User Story dans l'ordre
3. **Quality Gate** après chaque story :
   - `npm run typecheck` → doit passer
   - `npm run lint` → doit passer
   - Max 3 tentatives de fix par story
4. Passe à la suivante si OK
5. Continue jusqu'à complétion

**Note** : Ralph ne fait QUE l'implémentation. Les tests E2E et la review sont des étapes séparées (voir workflow complet ci-dessous).

---

## Workflow Complet (5 étapes)

Ralph s'intègre dans un workflow plus large :

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   /prd      │────▶│   /ralph    │────▶│   /test     │
│  (Plan)     │     │  (Implém.)  │     │  (Tests)    │
└─────────────┘     └──────┬──────┘     └──────┬──────┘
                          │                    │
                    ❌ Fix & retry        ❌ Fix & retest
                          │                    │
                          ▼                    ▼
                   ┌─────────────┐     ┌─────────────┐
                   │   /review   │────▶│   /commit   │
                   │  (Review)   │     │ (Commit+PR) │
                   └─────────────┘     └─────────────┘
```

**Pourquoi séparer ?**
- Si les tests échouent, tu peux relancer `/ralph` sans tout refaire
- Chaque étape peut échouer indépendamment
- Plus facile à debugger

---

## Le Ralph Loop (détail)

```
┌─────────────────────────────────────────────────────┐
│                    RALPH LOOP                       │
└─────────────────────────────────────────────────────┘

     ┌──────────────┐
     │  Lire PRD    │
     └──────┬───────┘
            │
            ▼
     ┌──────────────┐
     │ Story suivante│◄────────────────────┐
     └──────┬───────┘                      │
            │                              │
            ▼                              │
     ┌──────────────┐                      │
     │ Implémenter  │                      │
     └──────┬───────┘                      │
            │                              │
            ▼                              │
     ┌──────────────┐                      │
     │ QUALITY GATE │                      │
     │ typecheck    │     ❌ Fix           │
     │ lint         │──────────────────────┤
     │ (max 3 try)  │                      │
     └──────┬───────┘                      │
            │ ✅ OK                        │
            ▼                              │
     ┌──────────────┐                      │
     │ Commit story │                      │
     └──────┬───────┘                      │
            │                              │
            ▼                              │
     ┌──────────────┐     Oui              │
     │ Reste des    │──────────────────────┘
     │ stories ?    │
     └──────┬───────┘
            │ Non
            ▼
     ┌──────────────┐
     │   TERMINÉ    │
     │ (pas de push)│
     └──────────────┘
```

---

## Validation automatique

Après chaque story, Ralph exécute :

```bash
# TypeScript
npm run typecheck

# Linting
npm run lint

# Build (optionnel)
npm run build
```

Si erreur → fix → re-valide → continue

---

## Exemple de session

```
> /ralph auth-system

🔄 Ralph démarre : auth-system

📋 PRD chargé : 4 stories

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 US-001: Page de connexion
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Création : src/app/(auth)/login/page.tsx
Création : src/components/auth/login-form.tsx
...

✅ Validation : typecheck OK
✅ Validation : lint OK

✓ US-001 complétée

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 US-002: Page d'inscription
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Création : src/app/(auth)/register/page.tsx
...

❌ Erreur lint : missing dependency in useEffect

Correction...

✅ Validation : lint OK

✓ US-002 complétée

[...continue pour chaque story...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎉 PRD auth-system COMPLÉTÉ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stories : 4/4 ✅
Temps : 23 minutes
Fichiers créés : 12
Fichiers modifiés : 3
```

---

## Limites de sécurité

```
⚠️ Ralph s'arrête si :
- Plus de 30 itérations
- Erreur non récupérable
- Story bloquée 3x
```

Dans ce cas, il demande intervention humaine.

---

## Configuration

### Commandes de validation

Dans CLAUDE.md :

```markdown
## Commands

### Validation
- `npm run typecheck` - Vérification TypeScript
- `npm run lint` - Linting ESLint
- `npm run build` - Build Next.js (optionnel)
```

### Nombre d'itérations max

```markdown
## Ralph Loop

- Max iterations : 30
- Stop on : 3 failures same story
- Auto-commit : false (commit manuel après)
```

---

## Implémentation

```markdown
# .claude/commands/ralph.md

Implémente un PRD de manière autonome.

## Arguments
- prd-name : Nom du PRD (fichier dans tasks/)

## Étapes

1. Charger tasks/[prd-name].json
2. Pour chaque story avec status "pending" :
   a. Afficher le contexte de la story
   b. Implémenter selon les specs
   c. Valider (typecheck + lint)
   d. Si erreur : corriger et re-valider
   e. Marquer "completed" dans le PRD
3. Sauvegarder le PRD mis à jour
4. Résumé final

## Règles

- Une story à la fois
- Toujours valider avant de passer à la suite
- Ne pas modifier de code hors scope de la story
- Arrêter après 30 itérations maximum
- Demander de l'aide si bloqué 3x sur la même story
```

---

## Workflow complet (6 étapes)

```bash
# 1. Créer le PRD (avec tests définis)
/prd feature-name Description de la feature

# 2. Review et valider le PRD
# (modifier tasks/feature-name.json si besoin)

# 3. Lancer Ralph (implémentation)
/ralph feature-name

# 4. Lancer les tests
/test feature-name
# Si échec → fix avec /ralph → re-test

# 5. Review automatique
/review
# Si issues → fix → re-review

# 6. Commit + Push + PR
/commit

# 7. (Optionnel) Documenter les learnings
/compound feature-name
```

### Fast-Track (micro-changements)

Pour les changements triviaux (< 5 lignes, 1 fichier, pas d'impact logique) :

```
Utilisateur: "Fix le typo dans le header"
Claude: [modifie directement] → /commit
```

**Ne pas utiliser le fast-track si** :
- Plus d'un fichier modifié
- Impact sur la logique métier
- Nouveau code (pas juste une correction)

### Rollback (bug en prod)

```bash
git log --oneline -10          # Identifier le commit
git revert <commit-hash>       # Revert
git push origin main           # Push
/prd fix-{bug-name}            # Créer PRD pour le fix
```

### Pourquoi 6 étapes au lieu de 1 ?

| Approche | Avantage | Inconvénient |
|----------|----------|--------------|
| **Monolithique** | Simple | Difficile à debugger si échec |
| **Séparée** | Chaque étape peut échouer indépendamment | Plus de commandes |
| **Fast-Track** | Rapide pour les micro-changements | Risque si mal utilisé |

**Recommandation** :
- Features complexes → 6 étapes
- Modifications moyennes → 5 étapes (sans /compound)
- Micro-changements → Fast-Track

---

## Tips

### Petit PRD = Meilleur résultat

```
❌ PRD avec 15 stories complexes

✅ 3 PRDs avec 5 stories simples chacun
```

### Review entre les stories

Tu peux interrompre Ralph :
```
# Pendant l'exécution
Ctrl+C

# Review
git diff

# Reprendre
/ralph feature-name
# (reprend aux stories pending)
```

### Debug si bloqué

```
"La story US-003 échoue avec cette erreur : [erreur]
Analyse le problème et propose une solution."
```
