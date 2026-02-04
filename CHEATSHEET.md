# 🥃 BOURBON CLAUDE CHEATSHEET

> Quick reference pour le vibe coding. Garde ça ouvert pendant que tu codes.

---

## 🚀 DÉMARRAGE RAPIDE

```bash
# Nouveau projet
mkdir mon-projet && cd mon-projet
claude
/start

# Projet existant
cd mon-projet
claude
```

---

## 📋 WORKFLOW STANDARD

```
PLAN → BUILD → SHIP → COMPOUND

/prd feature-name     # 1. Créer le plan
/ralph feature-name   # 2. Implémenter auto
/test                 # 3. Tester
/review               # 4. Review
/commit               # 5. Commit + PR
/compound             # 6. Extraire learnings
```

### Fast-Track (< 5 lignes, 1 fichier)
```
"Fix le typo" → Claude fait → /commit
```

---

## 💬 PHRASES MAGIQUES

### Après une erreur/fix
```
"Mets à jour CLAUDE.md pour ne plus faire cette erreur"
```

### Pour challenger Claude
```
"Prouve-moi que ça marche"
"Grill me on these changes — pas de PR tant que je passe pas ton test"
```

### Après un fix moyen
```
"Maintenant que tu sais tout, jette ça et implémente la solution élégante"
```

### Pour debugger
```
"Fix" (coller juste l'erreur)
"Go fix the failing CI tests"
```

### Pour plus de puissance
```
"Use subagents"
"Fais ça en parallèle avec des subagents"
```

### Pour apprendre
```
"Explique-moi ce code ligne par ligne"
"Fais-moi un diagramme ASCII de cette architecture"
```

---

## ⚡ COMMANDES CLAUDE CODE

| Commande | Action |
|----------|--------|
| `/start` | Initialiser un projet |
| `/prd` | Créer un PRD structuré |
| `/ralph` | Loop d'implémentation auto |
| `/compound` | Extraire les learnings |
| `/compact` | Libérer du contexte |
| `/clear` | Reset la conversation |
| `/cost` | Voir la conso tokens |
| `/permissions` | Pré-autoriser des actions |
| `/config` | Configurer Claude |
| `/statusline` | Customiser la barre de status |

---

## 🔧 SKILLS BOURBON

| Skill | Quand l'utiliser |
|-------|------------------|
| `/design` | Direction design floue |
| `/review` | Code review avant merge |
| `/test` | Générer des tests |
| `/deploy` | Mettre en prod |
| `/techdebt` | Trouver code dupliqué |

---

## 🌳 GIT WORKTREES (Paralléliser)

```bash
# Créer des worktrees pour bosser en parallèle
git worktree add ../projet-auth feature/auth
git worktree add ../projet-ui feature/ui

# Aliases rapides (ajouter à ~/.zshrc)
alias wa="cd ../projet-auth && claude"
alias wb="cd ../projet-ui && claude"

# Lister les worktrees
git worktree list

# Supprimer un worktree
git worktree remove ../projet-auth
```

---

## 🎙️ VOICE DICTATION

**Activer :** `fn` + `fn` (double tap)

Tu parles **3x plus vite** que tu tapes. Utilise-le pour :
- Les prompts longs
- Les explications de contexte
- Les specs détaillées

---

## 🔄 PLAN MODE

### Quand l'utiliser
- Tâche complexe (> 1 fichier)
- Nouvelle feature
- Refactoring important

### Comment
```
"Passe en plan mode. Planifie d'abord, n'implémente pas encore."

[Claude fait le plan]

"OK, implémente le plan"
```

### Si ça déraille
```
"Stop. Retour en plan mode. Re-planifie avec ce qu'on sait maintenant."
```

---

## 🌙 OVERNIGHT LOOP

### Setup
```bash
# Les jobs tournent automatiquement :
# 22h30 → Compound Review (learnings)
# 23h00 → Auto-build (priorité #1)
```

### Vérifier
```bash
launchctl list | grep bourbon
```

### Logs
```bash
tail -f ~/projects/*/logs/compound-review.log
```

---

## 🐛 DEBUG

### Erreur TypeScript
```
"L'erreur est [coller erreur]. Fix."
```

### Erreur vague
```
"Analyse cette erreur et trouve la root cause : [erreur]"
```

### CI qui fail
```
"Go fix the failing CI tests"
```

### Code qui marche pas comme prévu
```
"Prouve-moi que ça marche. Diff le comportement entre main et ma branche."
```

---

## 📊 TOKENS & COÛTS

### Vérifier
```
/cost
/usage
```

### Économiser
```
/compact              # Compresse le contexte
"Utilise Haiku pour cette tâche simple"
```

### Modèles
| Modèle | Usage | Coût |
|--------|-------|------|
| Haiku | Tâches répétitives, formatting | € |
| Sonnet | Dev features, debug | €€ |
| Opus | Architecture, décisions | €€€ |

---

## 🔐 SÉCURITÉ

### Jamais faire
- Push des secrets
- Commit des .env
- Exposer des credentials dans les logs

### Toujours faire
```bash
# Avant de commit
git diff --staged | grep -i "key\|secret\|password\|token"
```

---

## 📁 STRUCTURE PROJET

```
mon-projet/
├── src/
│   ├── app/           # Pages (routes)
│   ├── components/    # Composants React
│   │   └── ui/        # shadcn components
│   └── lib/           # Utils, clients
├── tasks/             # PRDs pour Ralph
├── memory/            # Notes et learnings
│   └── learnings/     # Patterns découverts
├── scripts/           # Automatisations
├── CLAUDE.md          # Instructions Claude
└── .env.local         # Secrets (JAMAIS commit)
```

---

## 🔗 RACCOURCIS CLAVIER

| Touche | Action |
|--------|--------|
| `Ctrl+C` | Interrompre Claude |
| `Ctrl+S` | Stash le prompt |
| `↑` | Historique commandes |
| `Tab` | Autocomplétion |
| `fn fn` | Voice dictation |
| `Escape` | Annuler |

---

## 📞 EN CAS DE PROBLÈME

### Claude tourne en rond
```
"Stop. Résume ce que tu as fait et ce qui bloque."
```

### Claude fait n'importe quoi
```
"Annule les dernières modifications. Relis le brief initial."
```

### Trop de tokens
```
/compact
/clear (si vraiment bloqué)
```

### Je comprends pas ce qu'il fait
```
"Explique ce que tu fais avant de continuer."
```

---

## 🎯 CHECKLIST AVANT DE CODER

- [ ] Je suis dans le bon dossier ?
- [ ] Le projet est initialisé ?
- [ ] J'ai un plan clair (PRD si complexe) ?
- [ ] CLAUDE.md est à jour ?

## 🎯 CHECKLIST APRÈS UNE FEATURE

- [ ] Tests passent ?
- [ ] Code review OK ?
- [ ] Learnings extraits ? (`/compound`)
- [ ] CLAUDE.md mis à jour si nouveau pattern ?
- [ ] Commit + Push ?

---

*Bourbon Claude Method — La Réunion 🇷🇪*
