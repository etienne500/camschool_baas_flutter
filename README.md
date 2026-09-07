# 🚀 CamSchool BaaS — SDK Flutter Officiel

[![GitHub](https://img.shields.io/badge/GitHub-etienne500%2Fcamschool__baas__flutter-blue?logo=github)](https://github.com/etienne500/camschool_baas_flutter)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Client Flutter / Dart officiel pour CamSchool BaaS (Backend-as-a-Service).**  
> Une alternative autonome, ultra-rapide et sécurisée à Firebase et Supabase, conçue pour les applications mobiles et web.

---

## 🌟 Fonctionnalités

* 🔥 **Base NoSQL Firestore-like** : Collections, documents JSON, requêtes filtrées (`where`), tri, pagination et écritures par lots (*Batch writes*).
* 📱 **Authentification Multi-Méthodes** :
  * Inscription / Connexion par Email & Mot de passe.
  * Connexion par **Numéro de Téléphone + OTP SMS** (compatible MTN / Orange / Nexttel).
  * Mode Invité / Connexion Anonyme.
  * Persistance et restauration automatique de session JWT via `SharedPreferences`.
  * Flux réactif en direct (`onAuthStateChanged`).
* 💾 **Cloud Storage** : Téléversement multi-fichiers, métadonnées, URLs publiques et URLs signées temporaires.
* 🔔 **Notifications Push** : Enregistrement de device tokens (FCM / APNs) et diffusion par Topics.
* 🔒 **Security Rules** : Protection granulaire par utilisateur.

---

## 📦 Installation Directe depuis GitHub

Ajoutez simplement cette dépendance dans votre fichier `pubspec.yaml` :

```yaml
dependencies:
  flutter:
    sdk: flutter
  camschool_baas_flutter:
    git:
      url: https://github.com/etienne500/camschool_baas_flutter.git
      ref: main
```

Puis exécutez dans votre terminal :
```bash
flutter pub get
```

---

## ⚙️ Initialisation Rapide (`main.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du client BaaS CamSchool
  await BaaS.initialize(
    baseUrl: 'https://votre-api-camschool.cm',
    projectId: 'votre_project_id',
    apiKey: 'baas_pub_xxxxxxxxxxxxxxxxxxxx',
    autoRestoreSession: true, // Restauration automatique du JWT
  );

  runApp(const MyApp());
}
```

---

## 📖 Exemples de Code

### 1. 🔐 Authentification par Téléphone & OTP SMS
```dart
// Demande d'OTP
final res = await BaaS.instance.auth.sendPhoneOtp(phoneNumber: '+237695512390');

// Vérification du code 6 chiffres
final user = await BaaS.instance.auth.verifyPhoneOtp(
  phoneNumber: '+237695512390',
  code: '482910',
  token: res['otp_token'],
);

print('Utilisateur connecté : ${user.phoneNumber}');
```

### 2. 🗄️ Base de Données NoSQL (CRUD & Requêtes)
```dart
// Ajouter un document
final docRef = await BaaS.instance.collection('courses').add({
  'title': 'Mathématiques Terminale C',
  'teacher': 'M. Kamdem',
  'coefficient': 5,
  'published': true,
});

// Requête filtrée avec tri et pagination
final courses = await BaaS.instance
    .collection('courses')
    .whereEqualTo('level', 'Terminale')
    .whereGreaterThanOrEqualTo('coefficient', 4)
    .orderBy('coefficient', descending: true)
    .limit(20)
    .get();

for (final doc in courses) {
  print('- ${doc.get('title')} (ID: ${doc.id})');
}
```

### 3. 📁 Cloud Storage (Upload)
```dart
final fileInfo = await BaaS.instance.storage.uploadBytes(
  path: 'avatars/user_123.jpg',
  bytes: imageBytes,
  filename: 'avatar.jpg',
  isPublic: true,
);

print('URL du fichier : ${fileInfo.url}');
```

---

## 📚 Documentation Complète

Pour consulter le guide exhaustif étape par étape avec architecture, gestion des erreurs, écritures par lots et exemples d'interfaces Flutter complètes, veuillez lire le fichier **[doc.md](./doc.md)**.

---

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](./LICENSE) pour plus de détails.
