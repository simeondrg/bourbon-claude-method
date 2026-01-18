# 📱 Workflow Application Mobile

## Vue d'ensemble

Le workflow pour créer une application mobile iOS et Android.

**Niveau** : 🔴 Complete
**Durée estimée** : 2-8 semaines
**Stack recommandée** : Flutter ou React Native + Supabase

---

## Choix du framework

### Flutter

```
Avantages :
+ Performance native
+ Un seul codebase
+ Hot reload rapide
+ UI consistante iOS/Android
+ Grande communauté

Inconvénients :
- Dart à apprendre
- Packages moins nombreux que React Native
```

**Idéal pour** : Apps avec UI custom, animations complexes

### React Native

```
Avantages :
+ JavaScript/TypeScript
+ Énorme écosystème npm
+ Expo simplifie beaucoup
+ Réutilisation code web

Inconvénients :
- Performance légèrement inférieure
- Bridge JS ↔ Native
```

**Idéal pour** : Équipes JS, apps connectées au web

### Expo (React Native simplifié)

```
Avantages :
+ Pas besoin de Xcode/Android Studio au début
+ Build dans le cloud
+ Updates over-the-air
+ Configuration minimale

Inconvénients :
- Moins de contrôle
- Certains modules natifs exclus
```

**Idéal pour** : MVPs, prototypes, devs web

---

## Les 6 phases

```
1. Setup (1-2 jours)
     │
     ▼
2. Navigation (1-2 jours)
     │
     ▼
3. Auth (2-3 jours)
     │
     ▼
4. Core Features (1-4 semaines)
     │
     ▼
5. Polish (3-5 jours)
     │
     ▼
6. Publish (3-7 jours)
```

---

## Phase 1 : Setup

### Option A : Flutter

```bash
# Installer Flutter
# https://docs.flutter.dev/get-started/install

# Créer le projet
flutter create mon_app

cd mon_app

# Vérifier l'installation
flutter doctor
```

### Option B : Expo (React Native)

```bash
# Créer le projet
npx create-expo-app mon-app --template tabs

cd mon-app

# Lancer
npx expo start
```

### Configuration CLAUDE.md

```markdown
# CLAUDE.md - [Nom App Mobile]

## Stack
- Framework : Flutter / Expo
- Backend : Supabase
- State : [Riverpod / Zustand]

## Conventions
- Architecture : Feature-first
- Naming : snake_case (Flutter) / camelCase (RN)
- Tests : Widget tests pour UI critique
```

### Validation

- [ ] App se lance sur simulateur
- [ ] Hot reload fonctionne
- [ ] CLAUDE.md créé

---

## Phase 2 : Navigation

### Flutter (go_router)

```dart
// lib/router/app_router.dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => HomeScreen()),
    GoRoute(path: '/login', builder: (_, __) => LoginScreen()),
    GoRoute(path: '/dashboard', builder: (_, __) => DashboardScreen()),
  ],
);
```

### Expo (expo-router)

```
app/
├── (tabs)/
│   ├── index.tsx        # Home
│   ├── explore.tsx      # Explore
│   └── _layout.tsx      # Tab layout
├── login.tsx
└── _layout.tsx          # Root layout
```

### Avec Claude

```
"Configure la navigation avec :
- Tab bar : Home, [Feature], Profile
- Stack navigation pour les détails
- Écran login (modal)
- Protection des routes auth"
```

### Validation

- [ ] Navigation entre écrans
- [ ] Tab bar fonctionne
- [ ] Deep links (optionnel)

---

## Phase 3 : Auth

### Supabase Auth

```
"Implémente l'auth avec Supabase :
- Écran login (email/password)
- Écran register
- Écran forgot password
- Auto-login si session existe
- Logout"
```

### Flutter avec Supabase

```dart
// lib/services/auth_service.dart
class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(String email, String password) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
```

### Expo avec Supabase

```typescript
// lib/supabase.ts
import { createClient } from '@supabase/supabase-js';
import AsyncStorage from '@react-native-async-storage/async-storage';

export const supabase = createClient(
  process.env.EXPO_PUBLIC_SUPABASE_URL!,
  process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!,
  {
    auth: {
      storage: AsyncStorage,
      autoRefreshToken: true,
      persistSession: true,
    },
  }
);
```

### Validation

- [ ] Inscription fonctionne
- [ ] Connexion fonctionne
- [ ] Session persistée
- [ ] Logout fonctionne

---

## Phase 4 : Core Features

### Approche

Pour chaque feature mobile :

```
1. Définir les écrans nécessaires
2. Créer le schéma BDD
3. Implémenter l'UI (statique d'abord)
4. Connecter au backend
5. Gérer les états (loading, error, empty)
6. Tester sur iOS ET Android
```

### Exemple : Liste de produits

```
"Feature : Catalogue produits

Écrans :
- Liste produits (grille)
- Détail produit
- Recherche

Fonctionnalités :
- Charger depuis Supabase
- Pull-to-refresh
- Pagination infinie
- Filtre par catégorie
- Recherche par nom"
```

### Pattern Flutter

```dart
// lib/features/products/
├── data/
│   └── product_repository.dart
├── domain/
│   └── product.dart
├── presentation/
│   ├── products_screen.dart
│   ├── product_detail_screen.dart
│   └── widgets/
│       ├── product_card.dart
│       └── product_grid.dart
└── providers/
    └── products_provider.dart
```

### Pattern Expo

```
features/products/
├── api.ts              # Appels Supabase
├── types.ts            # Types
├── hooks.ts            # Custom hooks
├── ProductList.tsx
├── ProductDetail.tsx
└── components/
    ├── ProductCard.tsx
    └── ProductGrid.tsx
```

### Validation par feature

- [ ] Fonctionne sur iOS
- [ ] Fonctionne sur Android
- [ ] Loading states
- [ ] Error handling
- [ ] Empty states

---

## Phase 5 : Polish

### UX Mobile spécifique

```
- [ ] Splash screen custom
- [ ] App icon
- [ ] Haptic feedback
- [ ] Pull-to-refresh
- [ ] Skeleton loaders
- [ ] Animations de transition
- [ ] Gestion clavier (KeyboardAvoidingView)
- [ ] Safe areas (notch, home bar)
```

### Performance

```
- [ ] Lazy loading des images
- [ ] Liste virtualisée (FlatList/ListView)
- [ ] Cache des données
- [ ] Optimiser les re-renders
```

### Avec Claude

```
"Améliore l'UX mobile :
- Ajoute un splash screen avec le logo
- Ajoute des animations de transition
- Optimise la liste produits (lazy loading images)
- Ajoute haptic feedback sur les boutons"
```

---

## Phase 6 : Publish

### Préparation

```
Informations nécessaires :
- Nom de l'app
- Description courte (80 caractères)
- Description longue
- Screenshots (6.5" iPhone, 12.9" iPad, phone Android)
- Icône (1024x1024)
- Catégorie
- Mots-clés
- Politique de confidentialité URL
```

### iOS (App Store)

1. **Compte Apple Developer** ($99/an)
2. **Créer l'app dans App Store Connect**
3. **Configurer les certificats**
4. **Build et upload**

```bash
# Flutter
flutter build ios --release
# Ouvrir Xcode, archive, upload

# Expo
eas build --platform ios
eas submit --platform ios
```

### Android (Play Store)

1. **Compte Google Play** ($25 one-time)
2. **Créer l'app dans Play Console**
3. **Générer la clé de signature**
4. **Build et upload**

```bash
# Flutter
flutter build appbundle --release
# Upload .aab dans Play Console

# Expo
eas build --platform android
eas submit --platform android
```

### Avec Claude

```
"Prépare l'app pour publication :
- Configure les métadonnées (nom, description)
- Génère les screenshots nécessaires
- Configure le versioning
- Checklist pré-soumission"
```

### Timeline App Store

```
Soumission → Review (1-7 jours) → Publication
             │
             └─ Rejet possible (corrections → re-soumission)
```

---

## Commandes récapitulatives

| Phase | Actions |
|-------|---------|
| Setup | Créer projet, config |
| Navigation | Routes, tab bar |
| Auth | Login, register, session |
| Features | CRUD par feature |
| Polish | UX, animations, perf |
| Publish | Build, submit, review |

---

## Erreurs courantes à éviter

### 1. Ignorer une plateforme
- **Problème** : Tester uniquement sur iOS
- **Solution** : Tester sur les deux dès le début

### 2. UI non adaptative
- **Problème** : Hardcoder des tailles
- **Solution** : Utiliser des layouts flexibles

### 3. Pas de gestion offline
- **Problème** : App inutilisable sans réseau
- **Solution** : Cache local, queue de sync

### 4. Ignorer les guidelines
- **Problème** : Rejet App Store
- **Solution** : Lire les Human Interface Guidelines

---

## Ressources

### Flutter
- [Flutter Docs](https://docs.flutter.dev)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Riverpod](https://riverpod.dev)

### Expo / React Native
- [Expo Docs](https://docs.expo.dev)
- [React Native Docs](https://reactnative.dev)
- [Expo Router](https://expo.github.io/router)

### Publication
- [App Store Guidelines](https://developer.apple.com/app-store/guidelines/)
- [Play Store Guidelines](https://play.google.com/console/about/guides/)
