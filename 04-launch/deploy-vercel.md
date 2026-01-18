# 🔺 Déployer sur Vercel

## Pourquoi Vercel ?

- Gratuit pour projets perso
- Déploiement automatique depuis GitHub
- Preview deployments sur chaque PR
- Optimisé pour Next.js
- CDN global

---

## Méthode 1 : Via GitHub (recommandé)

### 1. Push sur GitHub

```bash
git add .
git commit -m "feat: ready for production"
git push origin main
```

### 2. Connecter à Vercel

1. Va sur [vercel.com](https://vercel.com)
2. "Add New Project"
3. Import depuis GitHub
4. Sélectionne ton repo
5. Configure les variables d'env
6. Deploy

### 3. Auto-deploy

Désormais, chaque push sur `main` → deploy automatique.

---

## Méthode 2 : Via CLI

### Installation

```bash
npm install -g vercel
```

### Login

```bash
vercel login
```

### Lier le projet

```bash
cd mon-projet
vercel link
```

### Variables d'environnement

```bash
# Depuis le terminal
vercel env add NEXT_PUBLIC_SUPABASE_URL
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY
# etc.

# Ou pull depuis .env.local existant
vercel env pull
```

### Déployer

```bash
# Preview (branche actuelle)
vercel

# Production
vercel --prod
```

---

## Configuration

### vercel.json (optionnel)

```json
{
  "buildCommand": "npm run build",
  "devCommand": "npm run dev",
  "installCommand": "npm install",
  "framework": "nextjs",
  "regions": ["cdg1"],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        }
      ]
    }
  ]
}
```

### Régions disponibles

| Code | Localisation |
|------|--------------|
| `cdg1` | Paris |
| `iad1` | Washington |
| `sfo1` | San Francisco |
| `hnd1` | Tokyo |

Pour un public français → `cdg1`

---

## Domaine personnalisé

### 1. Ajouter le domaine

```bash
vercel domains add mondomaine.com
```

Ou dans le dashboard Vercel → Settings → Domains

### 2. Configurer DNS

Ajouter chez ton registrar :

```
Type: A
Name: @
Value: 76.76.21.21

Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

### 3. Vérifier

```bash
vercel domains verify mondomaine.com
```

### 4. HTTPS

Automatique et gratuit via Let's Encrypt.

---

## Variables d'environnement

### Types

| Type | Visible côté client | Usage |
|------|---------------------|-------|
| `NEXT_PUBLIC_*` | Oui | Config publique |
| Autres | Non | Secrets, API keys |

### Par environnement

- **Development** : `.env.local`
- **Preview** : Variables Vercel (preview)
- **Production** : Variables Vercel (production)

### Ajouter via CLI

```bash
# Production uniquement
vercel env add MA_VARIABLE production

# Tous les environnements
vercel env add MA_VARIABLE
```

---

## Logs et debugging

### Voir les logs

```bash
# Derniers logs
vercel logs

# Logs d'un déploiement spécifique
vercel logs [url-déploiement]

# Suivre en temps réel
vercel logs --follow
```

### Dans le dashboard

Project → Deployments → Clic sur un déploiement → Logs

---

## Rollback

### Via CLI

```bash
# Lister les déploiements
vercel ls

# Promouvoir un ancien déploiement en production
vercel promote [url-déploiement]

# Ou rollback
vercel rollback
```

### Via Dashboard

Deployments → ... (menu) → Promote to Production

---

## Optimisations

### Edge Functions

Pour des API routes ultra-rapides :

```typescript
// src/app/api/fast/route.ts
export const runtime = 'edge';

export async function GET() {
  return Response.json({ fast: true });
}
```

### Image Optimization

Activé par défaut avec `next/image`.

### Analytics

```bash
npm install @vercel/analytics
```

```typescript
// src/app/layout.tsx
import { Analytics } from '@vercel/analytics/react';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
      </body>
    </html>
  );
}
```

---

## Limites du plan gratuit

| Ressource | Limite |
|-----------|--------|
| Bandwidth | 100 GB/mois |
| Serverless Functions | 100 GB-hrs/mois |
| Build time | 6000 min/mois |
| Deployments | Illimité |
| Domains | Illimité |

Largement suffisant pour commencer !

---

## Checklist déploiement

- [ ] Build local passe (`npm run build`)
- [ ] Variables d'env configurées sur Vercel
- [ ] Domaine configuré (si applicable)
- [ ] HTTPS actif
- [ ] Test du site en production
- [ ] Analytics activé
- [ ] Monitoring configuré
