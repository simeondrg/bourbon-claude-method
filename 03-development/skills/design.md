# /design - Phase Inspiration & Direction

Skill pour guider les demandes design vagues vers une direction claire, puis executer via `/prd` et `/ralph`.

## Usage

```
/design [element ou description vague]
```

**Exemples:**
- `/design ameliore les KPI cards`
- `/design refais la sidebar`
- `/design je veux un hero plus moderne`
- `/design la page pricing est moche`

---

## Detection: Demande Claire vs Vague

### Demande CLAIRE (passer direct a /prd)
- "Change le bouton en vert lime"
- "Ajoute un badge 'Populaire' sur la card Pro"
- "Augmente le padding du header a 24px"

→ Ne pas utiliser `/design`, aller directement a `/prd`.

### Demande VAGUE (activer /design)
- "Ameliore les KPI cards"
- "La sidebar fait cheap"
- "Je veux quelque chose de plus moderne"
- "Refais cette section"

→ Activer le workflow `/design` complet.

---

## Workflow Complet

```
/design [demande vague]
        │
        ▼
┌─────────────────────────────────────────────────────────────┐
│  PHASE 1: CLARIFICATION                                     │
│  Poser 4 questions cles pour comprendre le besoin           │
└─────────────────────────────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────────────────────────────┐
│  PHASE 2: INSPIRATION (Browser MCP)                         │
│  Naviguer sur sites de reference selon type d'element       │
│  Montrer 3-5 inspirations avec screenshots                  │
└─────────────────────────────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────────────────────────────┐
│  PHASE 3: PROPOSITIONS                                      │
│  Presenter 2-3 directions avec description visuelle         │
│  Demander validation du choix                               │
└─────────────────────────────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────────────────────────────┐
│  PHASE 4: HANDOFF                                           │
│  Creer PRD avec direction validee                           │
│  Lancer /ralph pour implementation                          │
└─────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Questions de Clarification

Format de presentation:
```
🎯 CLARIFICATION

Avant de chercher des inspirations, quelques questions:

1. 📍 **Zone**: C'est pour quelle partie ? (dashboard, landing, sidebar...)
2. 🔧 **Action**: Modifier l'existant ou remplacer completement ?
3. 🎨 **Feeling**: Quel style tu vises ? (minimaliste, bold, premium, chaleureux...)
4. ⚠️ **Contraintes**: Des contraintes specifiques ? (mobile, accessibilite, dark mode...)

Reponds rapidement et je te montre des inspirations adaptees.
```

### Options par question

**Q1 - Zone:**
- Dashboard
- Landing page
- Page specifique (pricing, settings...)
- Composant (sidebar, header, cards...)

**Q2 - Action:**
- Modifier un element existant
- Remplacer completement
- Ajouter un nouvel element

**Q3 - Feeling:**
- Minimaliste (Stripe, Linear)
- Bold/Moderne (Vercel, Raycast)
- Premium/Luxe (Apple, Notion)
- Chaleureux/Local (commerce local)
- Editorial (Medium, Substack)

**Q4 - Contraintes:**
- Mobile-first obligatoire
- Accessibilite renforcee
- Performance critique
- Dark mode requis
- Aucune

---

## Phase 2: Sites d'Inspiration par Type

### Mapping Element → Sites

| Type d'Element | Sites de Reference | Quoi Chercher |
|----------------|-------------------|---------------|
| Dashboard/Admin | TailAdmin, Tremor, shadcn blocks | KPI cards, data viz, layouts |
| Sidebar | Linear, Raycast, Notion | Navigation, collapse states |
| Header | Vercel, Stripe, Supabase | Search, user menu, breadcrumbs |
| Landing Hero | Awwwards, Landingfolio, Lapa.ninja | Headlines, CTAs, illustrations |
| Pricing | Stripe, Paddle, shadcn | Cards, toggles, features |
| Forms | Typeform, Linear, Cal.com | Inputs, validation, steps |
| Cards | Dribbble, Mobbin | Layouts, shadows, hover states |
| Tables | Airtable, Notion, Linear | Sorting, filtering, actions |
| Onboarding | Loom, Notion, Figma | Steps, progress, illustrations |

### URLs de Reference

```
Dashboard:
- https://demo.tailadmin.com/
- https://tremor.so/components
- https://ui.shadcn.com/blocks#dashboard

Landing:
- https://www.awwwards.com/websites/landing-page/
- https://www.landingfolio.com/
- https://www.lapa.ninja/

Creative:
- https://dribbble.com/search/[element]
- https://mobbin.com/browse/web/apps

SaaS Reference:
- https://stripe.com
- https://linear.app
- https://vercel.com
- https://notion.so
```

### Workflow Browser MCP

```
1. Obtenir contexte tabs: tabs_context_mcp
2. Creer nouveau tab: tabs_create_mcp
3. Naviguer vers site: navigate(url)
4. Attendre chargement: computer(action: "screenshot")
5. Analyser elements: read_page ou find(query)
6. Capturer inspiration: computer(action: "screenshot")
7. Repeter pour 3-5 sites
8. Synthetiser les patterns identifies
```

**Format d'exploration:**
```
🔍 RECHERCHE D'INSPIRATIONS

Je vais explorer des references pour [type d'element]...

📍 Site 1: [Nom] ([URL])
   [Screenshot]
   → Pattern identifie: [description]

📍 Site 2: [Nom] ([URL])
   [Screenshot]
   → Pattern identifie: [description]

Je synthetise les meilleures idees...
```

---

## Phase 3: Propositions de Directions

Presenter 2-3 directions distinctes:

```
🎨 DIRECTIONS PROPOSEES

D'apres les inspirations et ton brief, voici 3 directions:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📌 DIRECTION A: "[Nom court]"

**Look & Feel:**
- [Description visuelle 1]
- [Description visuelle 2]
- [Description visuelle 3]

**Inspire de:** [Sites references]

**Changements concrets:**
- [Changement 1]
- [Changement 2]
- [Changement 3]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📌 DIRECTION B: "[Nom court]"
[...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📌 DIRECTION C: "[Nom court]"
[...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 Quelle direction te parle ? (A/B/C ou mix)
```

---

## Phase 4: Handoff vers PRD/Ralph

Une fois direction validee:

### 4.1 Generer PRD automatiquement

```json
{
  "id": "[feature-name]",
  "title": "[Titre] - Direction [X] ([Nom])",
  "description": "[Description de la refonte]",
  "branch": "feature/[feature-name]",
  "design_direction": "[nom-direction]",
  "inspiration_sources": ["Site1", "Site2"],
  "stories": [
    {
      "id": "DS-001",
      "title": "[Story 1]",
      "files": ["file1.tsx"],
      "acceptance": ["Critere 1", "Critere 2"]
    }
  ]
}
```

### 4.2 Presenter et lancer

```
✅ DIRECTION VALIDEE: [Nom]

📋 PRD genere: tasks/prd-[feature].json

📝 Resume:
- [N] stories
- Fichiers: [liste]

Lancer l'implementation ? (oui/non)
```

Si oui → `/ralph [feature-name]`

---

## Regles Anti-AI Slop

Toujours verifier que la direction choisie respecte:

### NE JAMAIS FAIRE
- ❌ Inter, Roboto, Arial (fonts generiques)
- ❌ Gradient violet sur blanc (cliche)
- ❌ Border-radius identiques partout
- ❌ Layouts en grille parfaite symetrique
- ❌ Cards sans personnalite (rectangle blanc + ombre)
- ❌ Icones generiques sans stylisation

### TOUJOURS FAIRE
- ✅ Fonts distinctives
- ✅ Couleurs du design system projet
- ✅ Asymetrie intentionnelle
- ✅ Hover states surprenants
- ✅ Espaces negatifs genereux
- ✅ Au moins 1 element memorable par section

---

## Integration Workflow Bourbon

```
Demande design vague
        │
        ▼
    /design         ← Phase exploration/inspiration
        │
        ▼
    /prd            ← Generation auto par /design
        │
        ▼
    /ralph          ← Implementation automatique
        │
        ▼
    /commit         ← Commit + push
        │
        ▼
    /compound       ← Documente learnings
```

---

## Exemple Complet

```
Utilisateur: /design ameliore les KPI cards

Claude:
🎯 CLARIFICATION

1. 📍 Zone: KPI cards du dashboard principal ?
2. 🔧 Action: Les modifier ou les remplacer completement ?
3. 🎨 Feeling: Plutot minimaliste (Stripe) ou bold (gradients colores) ?
4. ⚠️ Contraintes: Doit supporter dark mode ?

Utilisateur: Dashboard oui, modifier, je veux du bold moderne, pas de dark mode

Claude:
🔍 RECHERCHE D'INSPIRATIONS pour KPI cards bold...

[Navigue sur TailAdmin, Tremor, Dribbble]
[Capture screenshots]

🎨 DIRECTIONS PROPOSEES

📌 A: Minimaliste epure (Stripe style)
📌 B: Bold Gradient (4 couleurs vibrantes)
📌 C: Glassmorphism premium

Quelle direction ? (A/B/C)

Utilisateur: B

Claude:
✅ Direction B validee

📋 PRD genere: tasks/prd-kpi-cards-bold-gradient.json

Lancer /ralph kpi-cards-bold-gradient ?

Utilisateur: oui

Claude: /ralph kpi-cards-bold-gradient
[Implementation automatique]
✅ PR: https://github.com/.../pull/N
```

---

## Raccourcis

```
/design --skip-clarify "[demande]"
```
→ Passe direct a Phase 2 (inspiration)

```
/design --direct "[demande claire]"
```
→ Passe direct a /prd (demande deja claire)

---

## Tips

1. **Toujours montrer des visuels** - Ne jamais decrire sans screenshot
2. **Max 3 directions** - Plus = paralysie d'analyse
3. **Etre opinionne** - Recommander une direction plutot que rester neutre
4. **Respecter le budget** - Si simple, proposer 1 seule direction
5. **Documenter le choix** - Ajouter `design_direction` dans le PRD

---

## Implementation

```markdown
# .claude/commands/design.md
---
description: Guide demandes design vagues vers direction claire + implementation
allowed-tools: Read, Glob, WebSearch, AskUserQuestion, mcp__Claude_in_Chrome__*
model: opus
---

[Contenu du skill ci-dessus]
```
