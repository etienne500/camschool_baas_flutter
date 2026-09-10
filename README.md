# 🚀 CamSchool BaaS — SDK Flutter Officiel

[![GitHub](https://img.shields.io/badge/GitHub-etienne500%2Fcamschool__baas__flutter-blue?logo=github)](https://github.com/etienne500/camschool_baas_flutter)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Client Flutter / Dart officiel pour CamSchool BaaS (Backend-as-a-Service).**  
> Alternative souveraine, ultra-rapide et tout-en-un à Firebase / Supabase spécialement optimisée pour les applications mobiles et web : base de données NoSQL Firestore-like, Authentification multi-canal (Email, Téléphone avec mot de passe ou SMS OTP, Anonyme), Cloud Storage, Notifications Push et **Paiements Hosted Checkout multi-passerelles (`orange_money`, `mtn_momo`, `PayPal`, `card`)**. *(Les retraits de fonds s'effectuent directement depuis le tableau de bord utilisateur de la plateforme).*

---

## 📑 Sommaire

1. [🌟 Fonctionnalités Clés](#-fonctionnalités-clés)
2. [📦 Installation](#-installation)
3. [⚡ Initialisation Rapide](#-initialisation-rapide)
4. [🔐 Authentification (BaasAuth)](#-authentification-baasauth)
5. [🗄️ Base de Données NoSQL (BaasDatabase)](#️-base-de-données-nosql-baasdatabase)
6. [☁️ Cloud Storage (BaasStorage)](#️-cloud-storage-baasstorage)
7. [🔔 Notifications Push (BaasNotifications)](#-notifications-push-baasnotifications)
8. [💳 Module Paiements Hosted Checkout & Webhooks](#-module-paiements-hosted-checkout--webhooks)
9. [🛡️ Sécurité & Bonnes Pratiques](#️-sécurité--bonnes-pratiques)
10. [📄 Licence & Support](#-licence--support)

---

## 🌟 Fonctionnalités Clés

* 🗄️ **Base de Données NoSQL Firestore-like** :
  * Documents JSON et collections dynamiques.
  * Moteur de requêtes avancé (`where`, `orderBy`, `limit`, `offset`, `search`).
  * Opérateurs NoSQL puissants : `==`, `!=`, `>`, `>=`, `<`, `<=`, `in`, `not_in`, `array-contains`, `starts_with`.
  * Incrémentations atomiques `$inc` et fusions de documents.
* 🔐 **Authentification Complète Multi-Canal** :
  * Inscription / Connexion par **Numéro de Téléphone / Mot de passe** (`signUpWithPhone`, `signInWithPhone`).
  * Inscription / Connexion par **Email / Mot de passe** (`signUpWithEmail`, `signInWithEmail`).
  * Authentification par **SMS OTP** (`sendPhoneOtp`, `verifyPhoneOtp`).
  * Authentification **Anonyme / Invité** instantanée (`signInAnonymously`).
  * Gestion et persistance automatique de la session (`SharedPreferences`).
  * Flux réactif d'état utilisateur (`Stream<BaasUser?>`).
* ☁️ **Cloud Storage Haute Performance** :
  * Téléversement de fichiers, photos et vidéos depuis l'appareil (`File` ou octets `Uint8List`).
  * Gestion des dossiers, métadonnées et URLs d'accès direct sécurisées.
* 🔔 **Push Notifications** :
  * Enregistrement en un clic des tokens FCM / APNs liés à l'utilisateur connecté.
* 💳 **Paiements Hosted Checkout Multi-Passerelles (BaaS Pay)** :
  * Moyens de paiement supportés : **`'orange_money'`**, **`'mtn_momo'`**, **`'PayPal'`**, **`'card'`** (Visa/Mastercard).
  * Génération de sessions sécurisées (`checkout_url`) pour redirection web ou WebView in-app.
  * Notifications IPN Webhook avec signature HMAC SHA256 et écoute réactive (`pollTransactionStatus`).
  * *Note : Les retraits de solde sont gérés de manière sécurisée et exclusive depuis le tableau de bord utilisateur de la plateforme.*

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

### 1. Inscription & Connexion par Numéro de Téléphone

```dart
// Inscription par Téléphone avec Mot de passe
try {
  BaasUser user = await BaaS.instance.auth.signUpWithPhone(
    phoneNumber: '+237655797860',
    password: 'MonSuperMotDePasse123!',
    displayName: 'Paul Biya',
    metadata: {
      'ville': 'Yaoundé',
      'statut': 'Auteur',
    },
  );
  print('Utilisateur inscrit avec succès : ${user.id}');
} on BaasException catch (e) {
  print('Erreur : ${e.message}');
}

// Connexion par Téléphone avec Mot de passe
try {
  BaasUser user = await BaaS.instance.auth.signInWithPhone(
    phoneNumber: '+237655797860',
    password: 'MonSuperMotDePasse123!',
  );
  print('Connecté en tant que : ${user.displayName}');
} on BaasException catch (e) {
  print('Erreur de connexion : ${e.message}');
}
```

### 2. Inscription & Connexion avec Email / Mot de passe

```dart
// Inscription par Email
BaasUser user = await BaaS.instance.auth.signUpWithEmail(
  email: 'etudiant@camschool.com',
  password: 'SuperPassword123!',
  displayName: 'Alexandre',
);

// Connexion par Email
BaasUser loggedUser = await BaaS.instance.auth.signInWithEmail(
  email: 'etudiant@camschool.com',
  password: 'SuperPassword123!',
);
```

### 3. Authentification par SMS OTP

```dart
// Étape 1 : Demander l'envoi du code SMS
await BaaS.instance.auth.sendPhoneOtp(
  phoneNumber: '+237655797860',
);

// Étape 2 : Vérifier le code reçu par l'utilisateur
BaasUser user = await BaaS.instance.auth.verifyPhoneOtp(
  phoneNumber: '+237655797860',
  code: '123456',
  token: 'otp_token_xyz...',
);
```

### 4. Connexion Anonyme (Guest) & Déconnexion

```dart
// Connexion Invité
BaasUser anonymousUser = await BaaS.instance.auth.signInAnonymously();

// Écouter les changements d'état d'authentification
BaaS.instance.auth.onAuthStateChanged.listen((BaasUser? user) {
  print(user != null ? 'Connecté : ${user.phoneNumber ?? user.email}' : 'Déconnecté');
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
  'titre': 'NGÙL LEKAN Tome 1',
  'auteur': 'BDSTARS 237',
  'prix': 3000,
  'categorie': 'Bande Dessinée',
  'tags': ['bd', 'cameroun', 'culture'],
  'vues': 0,
  'is_published': true,
  'created_at': DateTime.now().toIso8601String(),
});

print('Document créé avec ID : ${docRef.id}');

// Écrire avec ID explicite
await BaaS.instance.database.collection('livres').doc('livre_001').set({
  'titre': 'NGÙL LEKAN Tome 1',
  'prix': 3000,
});
```

### 2. Mettre à Jour & Incrémentation Atomique ($inc)

```dart
// Mise à jour avec incrémentation atomique sécurisée ($inc: 1)
await BaaS.instance.database.collection('livres').doc('livre_001').update({
  'prix': 3500,
  'vues': BaasFieldIncrement(1),
});
```

### 3. Requêtes Avancées & Filtres NoSQL

```dart
// Requête filtrée avec tri, limite et pagination
var snapshot = await BaaS.instance.database
    .collection('livres')
    .where('categorie', '==', 'Bande Dessinée')
    .where('prix', '<=', 5000)
    .where('tags', 'array-contains', 'cameroun')
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
| **Recherche globale** | `.search('texte')` | `.collection('livres').search('Aventure').get()` |

---

## ☁️ Cloud Storage (BaasStorage)

```dart
import 'dart:io';

File imageFile = File('/path/to/cover.jpg');

// Téléversement d'un fichier réel
BaasStorageFile uploadResult = await BaaS.instance.storage.upload(
  file: imageFile,
  folder: 'covers',
  customName: 'cover_ngul_01.jpg',
);

print('URL Publique : ${uploadResult.url}');
```

---

## 🔔 Notifications Push (BaasNotifications)

```dart
// Enregistrer le token FCM de l'appareil
await BaaS.instance.notifications.registerDevice(
  fcmToken: 'ebF7MLYdSaatEbLOAJnUxc:APA91bGOIbkPEg...',
  platform: 'android', // 'android' | 'ios' | 'web'
);
```

---

## 💳 Module Paiements, Liens Hosted Checkout & Webhooks

Le module de paiement BaaS pour Flutter permet de **générer des liens de paiement hébergés uniques (`checkout_url`)** avec sélection multi-passerelles (Orange Money, MTN MoMo, Carte Bancaire, PayPal, Express Union), redirection vers vos URLs et notification instantanée vers `notify_url` (IPN Webhook signé).

> 💡 **Configuration Générale du Projet & Retraits :**  
> - Activez/désactivez les passerelles et configurez les URLs par défaut (`notify_url`, `success_url`, `fail_url`) depuis la console BaaS.
> - **Retraits de solde :** Les retraits de fonds s'effectuent de manière sécurisée et exclusive depuis le tableau de bord développeur de la plateforme (0% de commission).

### 1. Générer une Session Hosted Checkout (Lien Unique de Redirection)

```dart
// Génération du lien de paiement hébergé
final session = await BaaS.instance.payments.createCheckoutSession(
  amount: 5000,
  currency: 'XAF',
  customerName: 'Adonis BOPDA',
  phone: '655797860',
  description: 'Recharge compte premium',
  notifyUrl: 'https://monsite.com/api/payment/webhook',
  successUrl: 'https://monsite.com/commande/succes',
  failUrl: 'https://monsite.com/commande/annulee',
  allowedMethods: ['ORANGE_MONEY', 'MTN_MOMO', 'CARD', 'PAYPAL'],
  metadata: {'order_id': 'CMD_7781'},
);

print('Lien Hosted Checkout : ${session.checkoutUrl}');
print('Référence : ${session.reference}');

// Ouvrir le lien dans un WebView ou dans le navigateur externe :
// launchUrl(Uri.parse(session.checkoutUrl), mode: LaunchMode.externalApplication);
```

---

### 2. Modal de Paiement Flutter Clé-en-Main

```dart
await BaasPaymentModal.show(
  context,
  amount: 3000, // Montant en FCFA
  description: 'Achat du livre NGÙL LEKAN',
  initialPhone: '697336094',
  customerName: 'Adonis BOPDA',
  onSuccess: (transaction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paiement validé : ${transaction.reference}')),
    );
  },
  onError: (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Échec du paiement : $error')),
    );
  },
);
```

---

### 3. Suivi Réactif d'une Transaction (Stream Polling)

```dart
BaaS.instance.payments.pollTransactionStatus(session.reference).listen((tx) {
  print('Statut en direct : ${tx.status}');
  if (tx.isSuccessful) {
    print('Paiement validé ! Montant Net : ${tx.netAmount} ${tx.currency}');
  }
});
```

---

## 🛡️ Sécurité & Bonnes Pratiques

* 🔑 **Clé Publique (`pk_live_...`)** : À utiliser dans vos applications Flutter mobiles.
* 🔒 **Clé Secrète (`sk_live_...`)** : **JAMAIS** dans une application cliente Flutter !
* 📦 **Persistance** : Sauvegarde automatique du token via `SharedPreferences`.

---

## 📄 Licence & Support

* **Licence** : [MIT License](LICENSE)
* **Auteur / Support** : CamSchool Engineering Team (`support@camschool.cm`)
* **Dépôt GitHub** : [https://github.com/etienne500/camschool_baas_flutter](https://github.com/etienne500/camschool_baas_flutter)
* **Console Web BaaS** : [https://camschool.kmrshop.com/baas](https://camschool.kmrshop.com/baas)