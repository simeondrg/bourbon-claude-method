---
name: skills-install
description: "Installe les skills skills.sh selon le type de projet"
argument-hint: "[project-type: saas|landing|mobile|marketing|all]"
allowed-tools: Bash, Read, Write
model: haiku
---

# /skills-install - Installation automatique des skills

## Objectif
Installer les bundles de skills appropriés selon le type de projet détecté ou spécifié.

## Workflow

### 1. Détection du type de projet

Si aucun argument fourni, analyser :
- `package.json` → Next.js ? Expo ? React Native ?
- `supabase/` folder → Supabase project ?
- `stripe` in dependencies → Payments ?

### 2. Installation selon le type

#### CORE (Toujours)

```bash
npx skills add vercel-labs/agent-skills
npx skills add anthropics/skills
npx skills add obra/superpowers
```

#### SaaS (Next.js + Supabase + Stripe)

```bash
npx skills add supabase/agent-skills
npx skills add stripe/ai
npx skills add better-auth/skills
npx skills add coreyhaines31/marketingskills
```

#### Landing Page

```bash
npx skills add coreyhaines31/marketingskills
```

#### Mobile (Expo/React Native)

```bash
npx skills add expo/skills
npx skills add callstackincubator/agent-skills
npx skills add supabase/agent-skills
```

#### Marketing Campaign

```bash
npx skills add coreyhaines31/marketingskills
npx skills add remotion-dev/skills
```

#### All (Full suite)

```bash
npx skills add vercel-labs/agent-skills
npx skills add anthropics/skills
npx skills add obra/superpowers
npx skills add supabase/agent-skills
npx skills add stripe/ai
npx skills add better-auth/skills
npx skills add coreyhaines31/marketingskills
npx skills add expo/skills
npx skills add callstackincubator/agent-skills
npx skills add remotion-dev/skills
npx skills add trailofbits/skills
npx skills add jezweb/claude-skills
npx skills add wshobson/agents
```

### 3. Vérification

Après installation, lister les skills installés :

```bash
ls ~/.claude/skills/ 2>/dev/null || echo "Aucun skill installé"
```

### 4. Output

Afficher résumé :

```
✅ Skills installés pour projet [TYPE]:

CORE:
- vercel-react-best-practices
- web-design-guidelines
- frontend-design
- brainstorming
- test-driven-development
- systematic-debugging

[TYPE-SPECIFIC]:
- [liste des skills spécifiques]

💡 Utilise /skill-name pour appeler un skill
📚 Voir 06-skills-library/ pour le catalogue complet
```

## Exemples d'utilisation

```
/skills-install           # Auto-détecte le type
/skills-install saas      # Bundle SaaS complet
/skills-install mobile    # Bundle mobile Expo
/skills-install marketing # Bundle marketing
/skills-install all       # Tous les skills
```

## Référence

Voir [06-skills-library/README.md](../../06-skills-library/README.md) pour le catalogue complet.
