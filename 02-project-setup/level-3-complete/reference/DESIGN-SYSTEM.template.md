# [PROJECT_NAME] - Design System

> **Version** : 1.0
> **Date** : [DATE]
> **Statut** : Document opérationnel

---

## Principe Fondamental

Définir ici si le projet utilise un style unique ou plusieurs styles selon le contexte.

### Option A : Style Unique
Tout le projet utilise le même style visuel.

### Option B : Styles Différenciés (Recommandé pour SaaS)
Deux styles distincts selon le contexte :

| Contexte | Style | Objectif |
|----------|-------|----------|
| **Marketing** (landing, pricing, about) | [Style A] | Attirer, convertir |
| **App** (dashboard, features) | [Style B] | Travailler efficacement |

---

## 1. Style Marketing (si Option B)

### Caractéristiques
- **Formes** : [Carrés / Arrondis / Mixte]
- **Ombres** : [Nettes / Diffuses]
- **Énergie** : [Haute / Calme]

### Composants
```css
/* Card Marketing */
.card-marketing {
  /* Définir styles */
}

/* Bouton Marketing */
.btn-marketing {
  /* Définir styles */
}
```

---

## 2. Style App (si Option B)

### Caractéristiques
- **Formes** : [Carrés / Arrondis / Mixte]
- **Ombres** : [Nettes / Diffuses]
- **Énergie** : [Haute / Calme]

### Composants
```css
/* Card App */
.card-app {
  /* Définir styles */
}

/* Bouton App */
.btn-app {
  /* Définir styles */
}
```

---

## 3. Palette de Couleurs

| Nom | Hex | Usage |
|-----|-----|-------|
| Primary | `#XXXXXX` | CTA principal |
| Secondary | `#XXXXXX` | Éléments secondaires |
| Background | `#XXXXXX` | Fond principal |
| Text | `#XXXXXX` | Texte principal |
| Accent | `#XXXXXX` | Highlights |

### États Sémantiques

| État | Couleur | Hex |
|------|---------|-----|
| Success | Vert | `#22C55E` |
| Error | Rouge | `#EF4444` |
| Warning | Orange | `#F97316` |
| Info | Bleu | `#3B82F6` |

---

## 4. Typographie

| Usage | Police | Weight |
|-------|--------|--------|
| Titres | [Font] | 600-700 |
| Corps | [Font] | 400-500 |
| Code | [Monospace Font] | 400 |

### Échelle

| Niveau | Taille | Usage |
|--------|--------|-------|
| H1 | 48px | Titres principaux |
| H2 | 36px | Sections |
| H3 | 24px | Sous-sections |
| Body | 16px | Texte courant |
| Small | 14px | Labels |

---

## 5. Spacing

| Token | Valeur | Usage |
|-------|--------|-------|
| xs | 4px | Gaps internes |
| sm | 8px | Padding boutons |
| md | 16px | Padding cards |
| lg | 24px | Entre éléments |
| xl | 32px | Entre sections |

---

## 6. Border Radius

| Token | Valeur | Usage |
|-------|--------|-------|
| sm | 4px | Boutons, inputs |
| md | 8px | Cards petites |
| lg | 16px | Cards grandes |
| xl | 24px | Modals |
| full | 9999px | Pills, avatars |

---

## 7. Ombres

| Token | Valeur | Usage |
|-------|--------|-------|
| sm | `0 1px 2px rgba(0,0,0,0.05)` | Subtile |
| md | `0 4px 6px rgba(0,0,0,0.1)` | Cards |
| lg | `0 10px 25px rgba(0,0,0,0.1)` | Modals |
| brutal | `4px 4px 0 0 #000` | Style brutal |

---

## 8. Responsive

| Breakpoint | Largeur | Comportement |
|------------|---------|--------------|
| Mobile | < 640px | 1 colonne |
| Tablet | 640-1024px | 2 colonnes |
| Desktop | > 1024px | Layout complet |

---

## 9. Checklist Implémentation

Avant de livrer une page UI :

- [ ] Couleurs conformes à la palette
- [ ] Typographie cohérente
- [ ] Spacing uniforme
- [ ] Border-radius selon contexte
- [ ] Ombres selon contexte
- [ ] Responsive testé (mobile, tablet, desktop)
- [ ] États hover/focus définis
- [ ] Accessibilité (contraste WCAG AA)

---

*Template créé dans le cadre de Bourbon Claude Method*
*Adapter ce document aux besoins spécifiques du projet*
