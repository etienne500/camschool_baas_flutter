# 🚀 CamSchool BaaS — SDK Flutter Officiel

[![GitHub](https://img.shields.io/badge/GitHub-etienne500%2Fcamschool__baas__flutter-blue?logo=github)](https://github.com/etienne500/camschool_baas_flutter)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Client Flutter / Dart officiel pour CamSchool BaaS (Backend-as-a-Service).**  
> Alternative souveraine, ultra-rapide et tout-en-un à Firebase / Supabase spécialement optimisée pour les applications mobiles et web : base de données NoSQL Firestore-like, Authentification multi-canal (Email, Téléphone OTP SMS, Anonyme), Cloud Storage, Notifications Push et **Paiements & Retraits Mobile Money intégrés (MTN MoMo, Orange Money, Cartes Bancaires)**.

---

## 📑 Sommaire

1. [🌟 Fonctionnalités Clés](#-fonctionnalités-clés)
2. [📦 Installation](#-installation)
3. [⚡ Initialisation Rapide](#-initialisation-rapide)
4. [🔐 Authentification (BaasAuth)](#-authentification-baasauth)
5. [🗄️ Base de Données NoSQL (BaasDatabase)](#️-base-de-données-nosql-baasdatabase)
6. [☁️ Cloud Storage (BaasStorage)](#️-cloud-storage-baasstorage)
7. [🔔 Notifications Push (BaasNotifications)](#-notifications-push-baasnotifications)
8. [💳 Paiements & Retraits Mobile Money (BaasPay)](#-paiements--retraits-mobile-money-baaspay)
9. [🛡️ Sécurité & Bonnes Pratiques](#️-sécurité--bonnes-pratiques)
10. [📄 Licence & Support](#-licence--support)

---

## 🌟 Fonctionnalités Clés

* 🗄️ **Base de Données NoSQL Firestore-like** :
  * Documents JSON et collections dynamiques.
  * Moteur de requêtes avancé (`where`, `orderBy`, `limit`, `offset`, `search`).
  * Opérateurs NoSQL puissants : `==`, `!=`, `>`, `>=`, `<`, `<=`, `in`, `not_in`, `array-contains`, `starts_with`.
  * Incrémentations atomiques `$inc` et fusions de documents.
* 🔐 **Authentification Complète** :
  * Inscription / Connexion Email & Mot de passe.
  * Connexion par Numéro de Téléphone avec envoi automatique de code SMS OTP.
  * Authentification Anonyme / Invité instantanée.
  * Gestion et persistance automatique de la session (`SharedPreferences`).
  * Flux réactif d'état utilisateur (`Stream<BaasUser?>`).
* ☁️ **Cloud Storage Haute Performance** :
  * Téléversement de fichiers, photos et vidéos depuis l'appareil (`File` ou octets `Uint8List`).
  * Gestion des dossiers, métadonnées et URLs d'accès direct sécurisées.
* 🔔 **Push Notifications** :
  * Enregistrement en un clic des tokens FCM / APNs liés à l'utilisateur connecté.
* 💳 **Paiements & Retraits Mobile Money (MTN, Orange, Cartes)** :
  * Encaissement (*PayIn*) et Retrait direct (*PayOut*) via MTN MoMo (*126#) et Orange Money (*150#).
  * Widgets modaux Flutter prêts à l'emploi (`showBaasPaymentModal`, `showBaasPayoutModal`).
  * Vérification automatique de statut en polling ou webhook en direct.

---

## 📦 Installation

Ajoutez `camschool_baas_flutter` dans votre fichier `pubspec.yaml` :

```yaml
dependencies:
  flutter:
    sdk: flutter
  camschool_baas_flutter:
    path: ./packages/camschool_baas_flutter # ou version pub.dev
```

Puis exécutez dans votre terminal :

```bash
flutter pub get
```

---

## ⚡ Initialisation Rapide

Initialisez le client dans la fonction `main()` de votre application Flutter avant `runApp()` :

```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du SDK BaaS
  await BaaS.init(
    projectId: 'proj_zf3qirtdv4xc', // Votre ID de projet BaaS
    publicKey: 'pk_live_smULRpyZL00lxUVG97sZ9o0ruB9MxUw7UXg8GfTw', // Clé Publique
    baseUrl: 'https://camschool.kmrshop.com/api/baas/v1', // URL racine de l'API
  );

  runApp(const MyApp());
}
```

Accédez ensuite à l'instance partout dans votre application via **`BaaS.instance`**.

---

## 🔐 Authentification (BaasAuth)

### 1. Inscription avec Email & Mot de passe

```dart
try {
  BaasUser user = await BaaS.instance.auth.signUpWithEmail(
    email: 'etudiant@camschool.com',
    password: 'SuperPassword123!',
    displayName: 'Paul Biya',
    extraData: {
      'ville': 'Yaoundé',
      'filiere': 'Génie Informatique',
    },
  );
  print('Utilisateur inscrit avec succès : ${user.id}');
} on BaasException catch (e) {
  print('Erreur d\'inscription : ${e.message}');
}
```

### 2. Connexion avec Email & Mot de passe

```dart
try {
  BaasUser user = await BaaS.instance.auth.signInWithEmail(
    email: 'etudiant@camschool.com',
    password: 'SuperPassword123!',
  );
  print('Connecté en tant que : ${user.displayName}');
} on BaasException catch (e) {
  print('Erreur de connexion : ${e.message}');
}
```

### 3. Authentification par Téléphone (SMS OTP)

```dart
// Étape 1 : Demander l'envoi du code SMS
await BaaS.instance.auth.sendPhoneOtp(
  phoneNumber: '+237655797860',
);

// Étape 2 : Vérifier le code reçu par l'utilisateur
BaasUser user = await BaaS.instance.auth.verifyPhoneOtp(
  phoneNumber: '+237655797860',
  code: '123456',
);
```

### 4. Connexion Anonyme (Guest)

```dart
BaasUser anonymousUser = await BaaS.instance.auth.signInAnonymously();
print('Utilisateur anonyme ID : ${anonymousUser.id}');
```

### 5. État Utilisateur & Déconnexion

```dart
// Récupérer l'utilisateur courant
BaasUser? currentUser = BaaS.instance.auth.currentUser;

// Écouter les changements d'état d'authentification
BaaS.instance.auth.authStateChanges.listen((BaasUser? user) {
  if (user != null) {
    print('Utilisateur connecté : ${user.email}');
  } else {
    print('Utilisateur déconnecté');
  }
});

// Déconnexion
await BaaS.instance.auth.signOut();
```

---

## 🗄️ Base de Données NoSQL (BaasDatabase)

### 1. Ajouter ou Créer un Document

```dart
// Création avec ID auto-généré
var docRef = await BaaS.instance.database.collection('livres').add({
  'titre': 'L\'art du Code Flutter',
  'auteur': 'Etienne NDEMAZE',
  'prix': 3500,
  'categorie': 'Informatique',
  'tags': ['flutter', 'dart', 'mobile'],
  'vues': 0,
  'is_published': true,
  'created_at': DateTime.now().toIso8601String(),
});

print('Document créé avec ID : ${docRef.id}');

// Création ou écrasement avec ID explicite
await BaaS.instance.database.collection('livres').doc('livre_001').set({
  'titre': 'NGÙL LEKAN',
  'prix': 5000,
  'statut': 'disponible',
});
```

### 2. Lire un Document Unique

```dart
var doc = await BaaS.instance.database.collection('livres').doc('livre_001').get();

if (doc.exists) {
  print('Titre : ${doc.data['titre']}');
  print('Prix : ${doc.data['prix']} FCFA');
} else {
  print('Document non trouvé.');
}
```

### 3. Mettre à Jour & Incrémentation Atomique

```dart
// Mise à jour partielle sans écraser les autres champs
await BaaS.instance.database.collection('livres').doc('livre_001').update({
  'prix': 4500,
  'vues': BaasFieldIncrement(1), // Incrémentation atomique sécurisée ($inc: 1)
});
```

### 4. Supprimer un Document

```dart
await BaaS.instance.database.collection('livres').doc('livre_001').delete();
```

---

### 5. Requêtes Avancées & Filtres Puissants (Query Builder)

Le SDK prend en charge tous les opérateurs de requêtes NoSQL haute performance :

```dart
// Requête filtrée avec tri, limite et pagination
var snapshot = await BaaS.instance.database
    .collection('livres')
    .where('categorie', '==', 'Informatique')
    .where('prix', '<=', 10000)
    .where('tags', 'array-contains', 'flutter')
    .orderBy('created_at', descending: true)
    .limit(10)
    .get();

for (var doc in snapshot.docs) {
  print('ID: ${doc.id} | Titre: ${doc.data['titre']} | Prix: ${doc.data['prix']}');
}
```

#### Tableau des Opérateurs Supportés :

| Opérateur | Syntaxe Dart | Exemple |
| :--- | :--- | :--- |
| **Égalité** | `'=='` ou `'='` | `.where('status', '==', 'active')` |
| **Différence** | `'!='` ou `'<>'` | `.where('role', '!=', 'banned')` |
| **Supérieur** | `'>'` ou `'>='` | `.where('prix', '>=', 1000)` |
| **Inférieur** | `'<'` ou `'<='` | `.where('stock', '<', 5)` |
| **Appartenance liste** | `'in'` | `.where('ville', 'in', ['Douala', 'Yaoundé'])` |
| **Exclusion liste** | `'not_in'` | `.where('categorie', 'not_in', ['archives'])` |
| **Contient dans tableau** | `'array-contains'` | `.where('passions', 'array-contains', 'Lecture')` |
| **Commence par** | `'starts_with'` | `.where('nom', 'starts_with', 'Kengne')` |
| **Recherche globale** | `.search('texte')` | `.collection('livres').search('Algorithme').get()` |

---

## ☁️ Cloud Storage (BaasStorage)

Téléversez facilement vos images, fichiers PDF ou vidéos :

```dart
import 'dart:io';

File imageFile = File('/path/to/profile.jpg');

// Téléversement d'un fichier réel
BaasStorageFile uploadResult = await BaaS.instance.storage.upload(
  file: imageFile,
  folder: 'avatars',
  customName: 'user_${BaaS.instance.auth.currentUser?.id}.jpg',
);

print('Fichier téléversé avec succès :');
print('URL Publique : ${uploadResult.url}');
print('Taille : ${uploadResult.size} octets');
print('Format : ${uploadResult.mimeType}');
```

---

## 🔔 Notifications Push (BaasNotifications)

Liez le token de notification de l'appareil (Firebase Cloud Messaging ou Apple Push) au profil de l'utilisateur :

```dart
// Enregistrer le token FCM de l'appareil
await BaaS.instance.notifications.registerDevice(
  fcmToken: 'ebF7MLYdSaatEbLOAJnUxc:APA91bGOIbkPEg...',
  platform: 'android', // 'android' | 'ios' | 'web'
  deviceInfo: {
    'model': 'Samsung Galaxy S23',
    'app_version': '1.0.0',
  },
);
```

---

## 💳 Paiements & Retraits Mobile Money (BaasPay)

Le SDK intègre nativement les encaissements et retraits **MTN Mobile Money (*126#)** et **Orange Money (*150#)**.

### 1. Modal de Paiement Intégré (Recommandé)

Affichez en une ligne de code une interface modale complète prête à l'emploi :

```dart
await showBaasPaymentModal(
  context: context,
  amount: 2500, // Montant en FCFA
  description: 'Achat du livre NGÙL LEKAN',
  customerPhone: '655797860',
  customerName: 'Adonis BOPDA',
  onSuccess: (transaction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paiement réussi : ${transaction.reference}')),
    );
  },
  onFailure: (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Échec du paiement : $error')),
    );
  },
);
```

### 2. Modal de Retrait (PayOut)

```dart
await showBaasPayoutModal(
  context: context,
  amount: 15000,
  beneficiaryPhone: '697336094',
  beneficiaryName: 'Auteur Ulrich',
  onSuccess: (transaction) {
    print('Retrait effectué : ${transaction.reference}');
  },
);
```

### 3. API Programmatique de Paiement

```dart
// 1. Déclencher le paiement
var transaction = await BaaS.instance.payments.initiatePayIn(
  amount: 5000,
  phoneNumber: '655797860',
  operator: BaasPaymentOperator.mtn, // .mtn | .orange
  description: 'Abonnement Premium 1 Mois',
);

print('Transaction initiée : ${transaction.id}');

// 2. Vérifier le statut de la transaction
var status = await BaaS.instance.payments.checkStatus(transaction.id);
print('Statut actuel : ${status.name}'); // pending, success, failed
```

---

## 🛡️ Sécurité & Bonnes Pratiques

* 🔑 **Clé Publique (`pk_live_...`)** : À utiliser dans vos applications mobiles Flutter et applications web clientes. Les accès sont soumis aux règles de sécurité définies sur la console d'administration BaaS.
* 🔒 **Clé Secrète (`sk_live_...`)** : **JAMAIS** dans une application cliente Flutter ! À réserver exclusivement à vos scripts serveurs ou backends sécurisés.
* 📦 **Persistance** : Le SDK gère automatiquement la sauvegarde locale du jeton d'authentification utilisateur via `SharedPreferences`.

---

## 📄 Licence & Support

* **Licence** : [MIT License](LICENSE)
* **Auteur / Support** : CamSchool Engineering Team (`support@camschool.cm`)
* **Dépôt GitHub** : [https://github.com/etienne500/camschool_baas_flutter](https://github.com/etienne500/camschool_baas_flutter)
* **Console Web BaaS** : [https://camschool.kmrshop.com/baas](https://camschool.kmrshop.com/baas)