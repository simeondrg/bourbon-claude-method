# CLAUDE.md - [Nom du Projet]

## Projet

**[Nom]** - [Description en 1 phrase]

---

## Stack

- **Frontend** : [HTML/CSS/JS ou framework]
- **Hébergement** : [Vercel/Netlify/GitHub Pages]

---

## Conventions

- Mobile-first
- Français dans l'UI
- Code propre et commenté

---

## Structure

```
/
├── index.html
├── css/
│   └── style.css
├── js/
│   └── main.js
└── assets/
    └── images/
```

---

## Commandes

```bash
# Lancer en local (avec Live Server ou autre)
npx serve .

# Déployer
vercel --prod
```

---

## Workflow Git

### Setup initial (une fois)
```bash
git init
gh repo create [nom-projet] --private --source=. --push
```

### Après chaque tâche
```bash
git add .
git commit -m "type: description"
git push
```

### Types de commit
- `feat` : nouvelle fonctionnalité
- `fix` : correction
- `style` : CSS/design
- `docs` : documentation

---

## Ce que Claude doit faire

- Garder le code simple et lisible
- Utiliser du CSS vanilla (pas de framework lourd)
- Optimiser les images
- Assurer la compatibilité mobile

---

## Ce que Claude NE doit PAS faire

- Ajouter des dépendances inutiles
- Over-engineering
- Créer des fichiers de config complexes
