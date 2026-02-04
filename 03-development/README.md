# 💻 Development - Workflows par Type de Projet

## Vue d'ensemble

Ce module contient les workflows de développement adaptés à chaque type de projet.

---

## Workflows disponibles

| Type de projet | Fichier | Niveau recommandé |
|---------------|---------|-------------------|
| Landing Page | [landing-page.md](./workflows/landing-page.md) | 🟢 Minimal |
| Site Vitrine | [site-vitrine.md](./workflows/site-vitrine.md) | 🟢 Minimal |
| App Web | [web-app.md](./workflows/web-app.md) | 🟡 Standard |
| MVP / Prototype | [mvp.md](./workflows/mvp.md) | 🟡 Standard |
| SaaS | [saas.md](./workflows/saas.md) | 🔴 Complete |
| App Mobile | [mobile-app.md](./workflows/mobile-app.md) | 🔴 Complete |
| API / Backend | [api-backend.md](./workflows/api-backend.md) | 🟡 Standard |

---

## Skills Claude Code

Les skills sont des commandes personnalisées pour automatiser les tâches récurrentes.

| Skill | Description | Fichier |
|-------|-------------|---------|
| `/prd` | Génération PRD structuré | [prd.md](./skills/prd.md) |
| `/design` | Inspiration + direction design | [design.md](./skills/design.md) |
| `/ralph` | Exécution PRD autonome | [ralph.md](./skills/ralph.md) |
| `/commit` | Commits conventionnels | [commit.md](./skills/commit.md) |
| `/compound` | Documentation learnings | [compound.md](./skills/compound.md) |
| `/review` | Code review | [review.md](./skills/review.md) |
| `/test` | Suite de tests | [test.md](./skills/test.md) |
| `/deploy` | Déploiement | [deploy.md](./skills/deploy.md) |

---

## Workflow général

```
┌─────────────────────────────────────────────────────────────┐
│                    WORKFLOW BOURBON                         │
└─────────────────────────────────────────────────────────────┘

   PLAN                    BUILD                   SHIP
     │                       │                       │
     ▼                       ▼                       ▼
┌─────────┐           ┌─────────────┐         ┌──────────┐
│  /prd   │ ────────▶ │   /ralph    │ ──────▶ │ /deploy  │
│         │           │             │         │          │
│ Planifier│           │ Implémenter │         │ Déployer │
└─────────┘           └─────────────┘         └──────────┘
     │                       │                       │
     ▼                       ▼                       ▼
┌─────────┐           ┌─────────────┐         ┌──────────┐
│ Valider │           │  /review    │         │ /compound│
│ le plan │           │  /test      │         │ Documenter│
└─────────┘           └─────────────┘         └──────────┘

💡 Pour les demandes design vagues, utiliser /design AVANT /prd :

   Demande vague ──▶ /design ──▶ /prd ──▶ /ralph ──▶ /deploy
                    (clarifier)  (planifier) (coder)   (livrer)
```

---

## 🌙 Compound Loop Overnight (Automatisé)

```
┌─────────────────────────────────────────────────────────────┐
│                OVERNIGHT COMPOUND LOOP                      │
│            (L'agent travaille pendant que tu dors)          │
└─────────────────────────────────────────────────────────────┘

     22h30                    23h00                  Matin
       │                        │                      │
       ▼                        ▼                      ▼
┌─────────────┐          ┌─────────────┐        ┌──────────┐
│  COMPOUND   │ ───────▶ │ AUTO-BUILD  │ ─────▶ │   PR     │
│   REVIEW    │          │             │        │  PRÊTE   │
│             │          │ Priorité #1 │        │          │
│ Learnings   │          │ du backlog  │        │ À review │
└─────────────┘          └─────────────┘        └──────────┘
       │                        │                      │
       ▼                        ▼                      ▼
   CLAUDE.md               Feature                Tu valides
   mis à jour              implémentée            et merges
```

**Setup :** Voir [skills/compound.md](./skills/compound.md) pour la configuration complète.

---

## Principes de développement

### 1. Clarté avant code

Toujours comprendre AVANT de coder :
- Quel problème on résout ?
- Pour qui ?
- Comment on valide que c'est réussi ?

### 2. Petits incréments

- 1 PR = 1 feature
- 1 commit = 1 changement logique
- Tester après chaque changement

### 3. Capitalisation

Chaque feature terminée :
1. Fonctionne ✅
2. Est documentée (si nouveau pattern) ✅
3. Rend les suivantes plus faciles ✅

---

## Prochaines étapes

Choisis le workflow adapté à ton projet :

→ [workflows/](./workflows/) - Workflows par type de projet
→ [skills/](./skills/) - Skills Claude Code
