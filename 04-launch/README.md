# 🚀 Launch - Déploiement et Lancement

## Vue d'ensemble

Ce module couvre tout ce qu'il faut pour mettre ton projet en production.

---

## Guides de déploiement

| Plateforme | Type de projet | Fichier |
|------------|---------------|---------|
| Vercel | Web apps Next.js | [deploy-vercel.md](./deploy-vercel.md) |
| Netlify | Sites statiques | [deploy-netlify.md](./deploy-netlify.md) |
| App Store | iOS | [deploy-ios.md](./deploy-ios.md) |
| Play Store | Android | [deploy-android.md](./deploy-android.md) |

---

## Checklist pré-lancement

### Technique

- [ ] Build passe sans erreurs
- [ ] Variables d'environnement configurées
- [ ] HTTPS activé
- [ ] Domaine configuré
- [ ] Redirections www/non-www

### Performance

- [ ] PageSpeed > 90
- [ ] LCP < 2.5s
- [ ] Images optimisées
- [ ] Gzip/Brotli activé

### SEO

- [ ] Title + meta description sur chaque page
- [ ] OG tags (partage social)
- [ ] Favicon
- [ ] sitemap.xml
- [ ] robots.txt

### Légal

- [ ] Mentions légales
- [ ] Politique de confidentialité
- [ ] CGV (si vente)
- [ ] Bandeau cookies (si nécessaire)

### Fonctionnel

- [ ] Tous les liens fonctionnent
- [ ] Formulaires testés
- [ ] Paiements testés (si applicable)
- [ ] Emails envoyés correctement

---

## Workflow de lancement

```
┌─────────────────────────────────────────────────────────────┐
│                    LAUNCH WORKFLOW                          │
└─────────────────────────────────────────────────────────────┘

J-7: Préparation
├── Finaliser le développement
├── Tests complets
└── Préparer assets marketing

J-3: Staging
├── Déployer en preview/staging
├── Test utilisateur réel
└── Corriger bugs trouvés

J-1: Go/No-Go
├── Checklist finale
├── Backup données (si migration)
└── Préparer rollback

J-Day: Launch
├── Déployer en production
├── Vérifier monitoring
├── Annoncer le lancement

J+1: Suivi
├── Monitorer erreurs
├── Répondre aux feedbacks
└── Hotfix si nécessaire
```

---

## Déploiement Vercel (Quick Start)

### 1. Installer CLI

```bash
npm install -g vercel
```

### 2. Lier le projet

```bash
vercel link
```

### 3. Variables d'environnement

```bash
# Ajouter depuis .env.local
vercel env pull
# Ou dans le dashboard Vercel
```

### 4. Déployer

```bash
# Preview
vercel

# Production
vercel --prod
```

### 5. Domaine

```bash
# Ajouter un domaine
vercel domains add mondomaine.com
```

---

## Monitoring post-launch

### Vercel Analytics

Activé par défaut, montre :
- Visiteurs
- Pages vues
- Vitals (LCP, FID, CLS)

### Erreurs

```bash
# Voir les logs
vercel logs [deployment-url]
```

### Uptime

Services gratuits :
- [UptimeRobot](https://uptimerobot.com/)
- [Better Uptime](https://betterstack.com/better-uptime)

---

## Skill /deploy

Crée un skill personnalisé pour automatiser :

```markdown
---
name: deploy
description: "Déployer sur Vercel"
---

# Deploy

1. Vérifier que le build passe
2. Lancer les tests
3. Déployer avec `vercel --prod`
4. Vérifier le déploiement
5. Confirmer le succès
```

---

## Rollback

Si problème après déploiement :

### Vercel

```bash
# Lister les déploiements
vercel ls

# Rollback vers un déploiement précédent
vercel rollback [deployment-url]
```

### Manuel

```bash
# Revenir au commit précédent
git revert HEAD
git push
```

---

## Prochaine étape

→ [../05-monetize/README.md](../05-monetize/README.md) - Monétiser ton projet
