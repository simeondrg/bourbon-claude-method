# /techdebt - Détection de Dette Technique

## Usage

```
/techdebt              # Scan complet
/techdebt --quick      # Scan rapide (fichiers modifiés récemment)
/techdebt --fix        # Scan + fix automatique
```

---

## Ce que ça fait

Scanne le codebase pour détecter :
1. **Code dupliqué** — fonctions/patterns qui se répètent
2. **Imports inutilisés** — dead code
3. **Fonctions trop longues** — > 50 lignes
4. **Fichiers trop gros** — > 300 lignes
5. **TODO/FIXME oubliés** — commentaires de dette
6. **Types `any`** — TypeScript lazy
7. **Console.log** — debug oublié
8. **Dépendances outdated** — sécurité

---

## Output

```
🔍 Tech Debt Scan — mon-projet
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📦 CODE DUPLIQUÉ (3 trouvés)
  ├─ src/components/Button.tsx:15-30
  │  └─ Dupliqué dans src/components/Card.tsx:22-37
  │     → Extraire dans src/lib/utils.ts
  │
  ├─ src/app/api/users/route.ts:45-60
  │  └─ Dupliqué dans src/app/api/products/route.ts:50-65
  │     → Créer un helper validateRequest()

⚠️ FICHIERS TROP GROS (2 trouvés)
  ├─ src/components/Dashboard.tsx (450 lignes)
  │     → Splitter en sous-composants
  │
  └─ src/lib/api.ts (380 lignes)
        → Séparer par domaine (users.ts, products.ts)

🐛 TODO/FIXME (5 trouvés)
  ├─ src/app/page.tsx:23 — TODO: add error handling
  ├─ src/lib/auth.ts:89 — FIXME: rate limiting
  └─ ...

🔴 TYPES `any` (8 trouvés)
  ├─ src/types/api.ts:12
  └─ ...

📝 CONSOLE.LOG (3 trouvés)
  └─ ...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Score: 72/100 (Acceptable)
Priorité: Extraire le code dupliqué
```

---

## Implémentation

```markdown
---
description: Scanne et identifie la dette technique
allowed-tools: Read, Write, Bash(grep *, find *, wc *)
model: sonnet
---

# /techdebt

Analyse le codebase pour détecter la dette technique.

## Arguments
- --quick : Scan seulement les fichiers modifiés (git diff)
- --fix : Fix automatiquement ce qui peut l'être
- --report : Génère un rapport dans reports/techdebt-YYYY-MM-DD.md

## Étapes

1. **Scanner le code dupliqué**
   ```bash
   # Trouver les blocs similaires
   find src -name "*.tsx" -o -name "*.ts" | xargs -I {} sh -c '
     for file in "$@"; do
       # Comparer avec autres fichiers
     done
   ' _ {}
   ```

2. **Trouver les fichiers trop gros**
   ```bash
   find src -name "*.tsx" -o -name "*.ts" | xargs wc -l | sort -rn | head -20
   ```

3. **Lister les TODO/FIXME**
   ```bash
   grep -rn "TODO\|FIXME\|HACK\|XXX" src/
   ```

4. **Trouver les `any`**
   ```bash
   grep -rn ": any" src/ --include="*.ts" --include="*.tsx"
   ```

5. **Trouver les console.log**
   ```bash
   grep -rn "console.log" src/ --include="*.ts" --include="*.tsx"
   ```

6. **Générer le rapport**
   - Score basé sur le nombre d'issues
   - Priorité basée sur l'impact

## Avec --fix

Pour chaque issue fixable :
1. Proposer le fix
2. Appliquer si safe (imports, console.log, any évidents)
3. Demander confirmation pour les refactors majeurs

## Output
- Affichage console structuré
- Si --report : fichier markdown dans reports/
```

---

## Tips

### Lancer à la fin de chaque session
```
/techdebt --quick
```

### Intégrer dans le workflow
Après `/ralph` et avant `/commit` :
```
/ralph feature-name
/techdebt --quick
/commit
```

### Tracker l'évolution
```
/techdebt --report
```
→ Compare avec les rapports précédents pour voir si la dette augmente ou diminue.

---

## Règle d'or

> "La dette technique est comme la dette financière — elle accumule des intérêts."

Mieux vaut 5 min de cleanup maintenant que 2h de refactoring dans 3 mois.
