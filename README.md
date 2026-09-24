# 🚀 CamSchool BaaS — SDK Flutter Officiel

[![GitHub](https://img.shields.io/badge/GitHub-etienne500%2Fcamschool__baas__flutter-blue?logo=github)](https://github.com/etienne500/camschool_baas_flutter)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Client Flutter / Dart officiel pour CamSchool BaaS (Backend-as-a-Service).**  
> Alternative souveraine, ultra-rapide et tout-en-un à Firebase / Supabase spécialement optimisée pour les applications mobiles et web : base de données NoSQL Firestore-like, Authentification multi-canal (Email, Téléphone avec mot de passe ou SMS OTP, Anonyme), Cloud Storage, Notifications Push et **Paiements Hosted Checkout multi-passerelles (`orange_money`, `mtn_momo`, `PayPal`, `card`)**. *(Les retraits de fonds s'effectuent directement depuis le tableau de bord développeur et sont traités sous un délai de 3 jours par un administrateur).*

---

## 📑 Sommaire

1. [🌟 Fonctionnalités Clés](#-fonctionnalités-clés)
2. [📦 Installation](#-installation)
3. [⚡ Initialisation Rapide](#-initialisation-rapide)
4. [🔐 Authentification (BaasAuth)](#-authentification-baasauth)
5. [🗄️ Base de Données NoSQL (BaasDatabase)](#️-base-de-données-nosql-baasdatabase)
6. [☁️ Cloud Storage (BaasStorage)](#️-cloud-storage-baasstorage)
7. [🔔 Notifications Push (BaasNotifications)](#-notifications-push-baasnotifications)
8. [💬 Messagerie SMS & Emails (BaasSms & BaasMail)](#-messagerie-sms--emails-baassms--baasmail)
9. [💳 Module Paiements Hosted Checkout & Webhooks](#-module-paiements-hosted-checkout--webhooks)
10. [💡 Module Factures & Services Concessionnaires (ENEO, CamWater, Canal+, Airtime)](#-module-factures--services-concessionnaires)
11. [📜 Historique des Transactions & Factures (Invoices)](#-module-factures--services-concessionnaires)
12. [🛡️ Sécurité & Bonnes Pratiques](#️-sécurité--bonnes-pratiques)
13. [📄 Licence & Support](#-licence--support)

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
* 💬 **Messagerie SMS & Emails Transactionnels** :
  * Envoi de **SMS facturés à 25 FCFA / SMS** (envois unitaires ou bulk vers plusieurs destinataires).
  * Envoi d'**Emails transactionnels HTML ou texte brut** avec expéditeur, Reply-To et pièces jointes.
  * Journalisation et historique consultable en temps réel.
* 💳 **Paiements Hosted Checkout Multi-Passerelles (BaaS Pay)** :
  * Moyens de paiement supportés : **`'orange_money'`**, **`'mtn_momo'`**, **`'PayPal'`**, **`'card'`** (Visa/Mastercard).
  * Génération de sessions sécurisées (`checkout_url`) pour redirection web ou WebView in-app.
  * Notifications IPN Webhook avec signature HMAC SHA256 et écoute réactive (`pollTransactionStatus`).
  * *Note : Les retraits de solde sont initiés depuis le tableau de bord développeur et traités sous un délai de 3 jours par un administrateur.*

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

### 4. [V2] Filtrage des champs (Select) & Sync Différentiel

La Version 2 de l'API permet de réduire drastiquement la consommation de données (économie de batterie et de forfait) grâce au cache ETag et au filtrage des champs :

```dart
// Récupérer uniquement les titres et les prix
var snapshotOptimized = await BaaS.instance.v2.database
    .collection('livres')
    .select(['titre', 'prix'])
    .updatedAfter('2023-10-01T00:00:00Z') // Synchronisation différentielle
    .get();
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

CamSchool BaaS propose une infrastructure de **Notifications Push cross-platform (Android, iOS & Web)** basée sur Firebase Cloud Messaging (FCM) et Apple Push Notification service (APNs).

---

### 1. Prérequis & Fichiers de Configuration

Pour activer les notifications sur votre application Flutter :

1. **Projet Firebase** : Créez un projet sur la [Console Firebase](https://console.firebase.google.com).
2. **Android** :
   - Téléchargez votre fichier **`google-services.json`** et placez-le dans **`android/app/`**.
   - Dans `android/build.gradle` (au niveau projet), ajoutez `classpath 'com.google.gms:google-services:4.4.1'`.
   - Dans `android/app/build.gradle` (au niveau app), appliquez le plugin `apply plugin: 'com.google.gms.google-services'`.
3. **iOS (APNs)** :
   - Téléchargez votre fichier **`GoogleService-Info.plist`** et ajoutez-le via Xcode dans **`ios/Runner/`**.
   - Ouvrez votre projet dans **Xcode** (`ios/Runner.xcworkspace`) > **Signing & Capabilities** :
     - Cliquez sur **+ Capability** et ajoutez **Push Notifications**.
     - Cliquez sur **+ Capability** et ajoutez **Background Modes** (cochez *Background fetch* et *Remote notifications*).
   - Sur votre compte Apple Developer, générez une clé APNs (`.p8`) et importez-la dans la console Firebase (Paramètres du projet > Cloud Messaging > Configuration de l'application Apple).

---

### 2. Dépendances Flutter (`pubspec.yaml`)

Ajoutez les packages officiels Firebase dans votre `pubspec.yaml` :

```yaml
dependencies:
  flutter:
    sdk: flutter
  camschool_baas_flutter:
    path: ./packages/camschool_baas_flutter
  firebase_core: ^3.1.0
  firebase_messaging: ^15.0.1
  flutter_local_notifications: ^17.1.2 # Optionnel : pour bannières en premier plan
```

---

### 3. Implémentation Complète (`main.dart`)

Voici le flux complet : configuration du gestionnaire d'arrière-plan, demande de permission, récupération du token FCM, enregistrement sur CamSchool BaaS et écoute des clics/événements.

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

// 1. Handler pour les notifications reçues quand l'application est en arrière-plan ou fermée
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔔 [Arrière-plan] Message reçu : ${message.notification?.title} - ${message.notification?.body}');
  print('📦 Données personnalisées : ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Firebase & du BaaS CamSchool
  await Firebase.initializeApp();
  await BaaS.init(
    projectId: 'proj_zf3qirtdv4xc',
    publicKey: 'pk_live_smULRpyZL00lxUVG97sZ9o0ruB9MxUw7UXg8GfTw',
    baseUrl: 'https://camschool.kmrshop.com/api/baas/v1',
  );

  // Définir le handler d'arrière-plan
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initPushNotifications();
  }

  Future<void> _initPushNotifications() async {
    final messaging = FirebaseMessaging.instance;

    // 2. Demander la permission à l'utilisateur (iOS / Android 13+)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Permission de notification accordée');

      // 3. Récupérer le token FCM de l'appareil
      String? fcmToken = await messaging.getToken();
      print('🔑 Token FCM de l\'appareil : $fcmToken');

      if (fcmToken != null) {
        // 4. Enregistrer le token auprès de CamSchool BaaS
        await BaaS.instance.notifications.registerDevice(
          fcmToken: fcmToken,
          platform: Theme.of(context).platform == TargetPlatform.iOS ? 'ios' : 'android',
          topics: ['actualites', 'annonces_cours'],
        );
        print('📱 Appareil enregistré avec succès sur CamSchool BaaS !');
      }

      // Écouter le rafraîchissement éventuel du token
      messaging.onTokenRefresh.listen((newToken) async {
        await BaaS.instance.notifications.registerDevice(
          fcmToken: newToken,
          platform: Theme.of(context).platform == TargetPlatform.iOS ? 'ios' : 'android',
        );
      });
    }

    // 5. Réception de notifications au premier plan (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('💬 [Premier plan] Message reçu : ${message.notification?.title}');
      
      // Afficher un SnackBar ou une alerte in-app
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${message.notification?.title ?? "Alerte"} : ${message.notification?.body ?? ""}'),
            backgroundColor: Colors.indigo,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    // 6. Clic sur notification quand l'application était en arrière-plan
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('👉 Clic sur la notification (App en arrière-plan) : ${message.data}');
      _handleNotificationClick(message.data);
    });

    // 7. Clic sur notification ayant réveillé l'application fermée (Terminated)
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print('🚀 App lancée depuis une notification fermée : ${initialMessage.data}');
      _handleNotificationClick(initialMessage.data);
    }
  }

  void _handleNotificationClick(Map<String, dynamic> data) {
    if (data.containsKey('route')) {
      Navigator.of(context).pushNamed(data['route']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('CamSchool BaaS Push Notifications Ready!')),
      ),
    );
  }
}
```

---

### 4. Envoi de Notifications Push depuis Flutter / Dart Backend

Vous pouvez également déclencher des notifications depuis votre code applicatif ou vos backends :

```dart
// 1. Envoi Général (Broadcast à tous les appareils enregistrés)
await BaaS.instance.notifications.send(
  title: 'Nouvelle fonctionnalité disponible !',
  body: 'Mettez à jour votre profil étudiant dès maintenant.',
  targetType: 'all',
  data: {'screen': '/profile', 'action': 'refresh'},
);

// 2. Envoi Ciblé à un Utilisateur Connecté
await BaaS.instance.notifications.send(
  title: 'Paiement confirmé 🎉',
  body: 'Votre abonnement annuel a été activé avec succès.',
  targetType: 'user',
  target: 'usr_9841', // UID de l'utilisateur dans le projet
  data: {'order_id': 'CMD_5541'},
);

// 3. Envoi sur un Topic Thématique
await BaaS.instance.notifications.send(
  title: 'Rappel Cours de Mathématiques',
  body: 'Le cours débutera dans 15 minutes en direct.',
  targetType: 'topic',
  target: 'annonces_cours',
);
```

---

## 💬 Messagerie SMS & Emails (BaasSms & BaasMail)

Envoyez facilement des SMS transactionnels et des emails depuis votre application Flutter ou votre backend Dart.

> 💰 **Facturation SMS :** Les SMS sont facturés à **25 FCFA (25 frs) par SMS**. Le montant est automatiquement débité et tracé au niveau du projet.

### 1. Envoi de SMS (Unitaire ou en Masse)

```dart
// Envoi d'un SMS unitaire (Coût : 25 FCFA / SMS)
try {
  BaasSmsResponse res = await BaaS.instance.sms.send(
    to: '+237655797860',
    message: 'Votre commande #CMD_1029 a bien été validée.',
    senderId: 'CamSchool', // Optionnel (jusqu'à 11 caractères)
  );

  print('SMS envoyé avec succès : ${res.success}');
  print('Coût total débité : ${res.totalCost} ${res.currency}'); // 25.0 XAF
} on BaasException catch (e) {
  print('Erreur SMS : ${e.message}');
}

// Envoi de SMS groupés (Bulk : 25 FCFA x nombre de destinataires)
BaasSmsResponse bulkRes = await BaaS.instance.sms.sendBulk(
  recipients: ['+237655797860', '+237697336094', '+237670000000'],
  message: 'Rappel : Événement spécial demain matin dès 9h00.',
);

print('Nombre de SMS envoyés : ${bulkRes.sentCount}');
print('Coût total : ${bulkRes.totalCost} FCFA'); // 75.0 XAF (3 x 25 FCFA)
```

### 2. Envoi d'Emails Transactionnels

```dart
try {
  BaasEmailResponse mailRes = await BaaS.instance.mail.send(
    to: 'etudiant@camschool.cm',
    subject: 'Confirmation de votre inscription',
    html: '''
      <div style="font-family: Arial, sans-serif; padding: 20px;">
        <h2 style="color: #0284c7;">Bienvenue sur CamSchool !</h2>
        <p>Votre compte a été activé avec succès.</p>
      </div>
    ''',
    fromName: 'Service des Admissions',
    replyTo: 'admissions@camschool.cm',
  );

  print('Email envoyé : ${mailRes.success}');
} on BaasException catch (e) {
  print('Erreur Email : ${e.message}');
}
```

---

## 💳 Module Paiements, Liens Hosted Checkout & Passerelles (PayMooney & NoKash)

Le module de paiement BaaS pour Flutter permet de **générer des liens de paiement hébergés uniques (`checkout_url`)** supportant les passerelles de premier ordre :
* 📱 **Orange Money** (`'ORANGE_MONEY'`, `'ORANGE_MONEY_NOKASH'`) via **NoKash** ou **PayMooney** (Push USSD `#150*50#`)
* 📱 **MTN Mobile Money** (`'MTN_MOMO'`, `'MTN_MOMO_NOKASH'`) via **NoKash** ou **PayMooney** (Push USSD `*126#`)
* 💼 **Express Union Mobile** (`'EU_MOBILE'`, `'EU_MOBILE_NOKASH'`) via **NoKash**
* 🌐 **PayPal** (`'PAYPAL'`, `'PAYPAL_PAYMOONEY'`) via **PayMooney**
* 💳 **Cartes Bancaires Visa & Mastercard** (`'CARD'`, `'CARD_PAYMOONEY'`, `'CARD_NOKASH'`) via **PayMooney** ou **NoKash**

> ⚡ **Passerelle NoKash Mobile Money Haute Vitesse :**  
> Prise en charge native avec Push USSD interactif, statut en temps réel (`REQUEST_OK`, `PENDING`, `SUCCESS`) et reversements automatisés (Payouts).

> 📊 **Calcul Dynamique des Frais par Tranches de Montants :**  
> Les administrateurs peuvent configurer des **paliers tarifaires** par tranche de montant (ex: 100 à 2 500 FCFA à 3%, 2 501 à 10 000 FCFA à 3%, 10 001 à 50 000 FCFA à 2.5%, > 50 000 FCFA à 2%). Le montant net et les frais sont calculés automatiquement.

### 1. Consulter les Méthodes & Tarifs en Direct

```dart
final methods = await BaaS.instance.payments.getMethods();
print('Moyens disponibles : ${methods.length}');
// Contient la passerelle active (NoKash / PayMooney), le tarif SMS (25 FCFA) et les tranches
```

### 2. Générer une Session Hosted Checkout (Lien Unique de Redirection)

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
  allowedMethods: ['ORANGE_MONEY_NOKASH', 'MTN_MOMO_NOKASH', 'EU_MOBILE_NOKASH', 'CARD_PAYMOONEY'],
  metadata: {'order_id': 'CMD_7781'},
);

print('Lien Hosted Checkout : ${session.checkoutUrl}');
print('Référence : ${session.reference}');

// Ouvrir le lien dans un WebView ou dans le navigateur externe :
// launchUrl(Uri.parse(session.checkoutUrl), mode: LaunchMode.externalApplication);
```

---

### 3. Modal de Paiement Flutter Clé-en-Main

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

### 4. Suivi Réactif d'une Transaction (Stream Polling)

```dart
BaaS.instance.payments.pollTransactionStatus(session.reference).listen((tx) {
  print('Statut en direct : ${tx.status}');
  if (tx.isSuccessful) {
    print('Paiement validé ! Montant Net : ${tx.netAmount} ${tx.currency}');
  }
});
```

---

## 💡 Module Factures & Services Concessionnaires (ENEO, CamWater, Canal+, Airtime)

Intégrez en quelques lignes de code le paiement des factures d'eau et d'électricité (**ENEO**, **CamWater**), le réabonnement aux chaînes TV (**Canal+**, **StarSat**) et l'achat de crédit téléphonique (**MTN**, **Orange**, **Camtel**, **Nexttel**, **YooMee**) directement dans votre application mobile Flutter, avec des **reçus PDF / HTML entièrement personnalisés à votre marque**.

---

### 1. Lister les Services & Tarifs de Commission

```dart
// Récupérer le catalogue de tous les services actifs
final services = await BaaS.instance.bills.getServices();

for (final s in services) {
  print('${s['name']} (${s['code']}) - Frais: ${s['admin_fee_amount']} XAF');
}

// Filtrer par catégorie ('bill', 'tv', 'airtime', 'data', 'voucher')
final billsOnly = await BaaS.instance.bills.getServices(category: 'bill');
```

---

### 2. Consulter les Factures Impayées (ENEO & CamWater)

```dart
final result = await BaaS.instance.bills.checkBill(
  serviceCode: 'ENEO',
  serviceNumber: '2010023456', // Numéro de police du client
);

print('Nombre de factures trouvées : ${result['bills_count']}');
print('Montant total à payer : ${result['total_amount']} XAF');

for (final bill in result['bills']) {
  print('Facture N° ${bill['bill_number']} - ${bill['amount']} XAF (+ ${bill['admin_fee']} F commission)');
}
```

---

### 3. Lister les Formules et Bouquets TV (Canal+, StarSat)

```dart
final response = await BaaS.instance.bills.getPackages('CANAL_PLUS');

for (final pkg in response['packages']) {
  print('${pkg['name']} : ${pkg['total_price']} XAF (ID: ${pkg['pay_item_id']})');
}
```

---

### 4. Régler une Facture ou un Réabonnement

```dart
final payment = await BaaS.instance.bills.payBill(
  serviceCode: 'ENEO',
  serviceNumber: '2010023456',
  amount: 15000,
  billNumber: 'FAC_ENEO_2026_09',
  customerName: 'Paul Tchinda',
  customerPhone: '699112233',
  customerEmail: 'paul.tchinda@gmail.com',
  paymentMethod: 'WALLET',
);

print('Facture payée avec succès ! PTN : ${payment['ptn']}');
print('URL du reçu client : ${payment['render_url']}');
```

---

### 5. Recharger du Crédit Téléphonique (Airtime & Data)

```dart
final topup = await BaaS.instance.bills.payAirtime(
  serviceCode: 'MTN_AIRTIME',
  phoneNumber: '677889900',
  amount: 1000,
  customerName: 'Franck Kamga',
);

print('Recharge effectuée : ${topup['amount']} XAF');
print('Lien du reçu : ${topup['render_url']}');
```

---

### 6. Personnaliser la Marque et la Mise en Page des Factures

Chaque projet dispose d'une identité de facturation dédiée. Vous pouvez injecter votre logo, couleur primaire, RCCM/NUI et mentions de bas de page :

```dart
await BaaS.instance.bills.updateReceiptTemplate(
  companyName: 'Ma Super FinTech Mobile',
  logoUrl: 'https://monapp.cm/assets/logo.png',
  primaryColor: '#059669', // Vert émeraude
  address: 'Akwa, Douala - Cameroun',
  phone: '+237 690 00 00 00',
  email: 'contact@masuperfintech.cm',
  taxId: 'M092100012345Z',
  footerNote: 'Merci pour votre fidélité ! Reçu certifié conforme.',
  showQrCode: true,
  customFields: {
    'Agent': 'Guichetier Mobile #12',
    'Application': 'FinTech App v2.4'
  },
);
```

---

### 7. Afficher le Reçu dans un WebView Flutter ou Déclencher l'Impression

```dart
import 'package:webview_flutter/webview_flutter.dart';

// Ouvrir directement la page du reçu officiel dans votre interface Flutter :
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: const Text('Reçu Officiel')),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(payment['render_url'])),
      ),
    ),
  ),
);
```

---

### 8. Gestion des Frais et Commissions Administrateur

* Les commissions sur chaque transaction sont définies de façon centralisée par l'administrateur dans le Dashboard BaaS (`/baas/admin`).
* L'administrateur peut choisir une tarification **Fixe** (ex: `250 XAF` sur ENEO, `200 XAF` sur CamWater, `500 XAF` sur Canal+) ou au **Pourcentage** (ex: `2%` sur MTN / Orange Airtime).
* Le SDK calcule et restitue instantanément la décomposition détaillée (`bill_amount`, `admin_fee`, `total_amount`) dans chaque réponse.

---

### 9. Consulter l'Historique des Transactions & Factures / View Invoice History

Après chaque paiement, retrouvez l'intégralité de l'historique de toutes les transactions de votre projet et les détails complets de chaque facture ou reçu.

> **FR** : Filtre automatique par projet via la clé applicative `X-Baas-App-Key`.  
> **EN** : Results are automatically scoped to your project via `X-Baas-App-Key`.

```dart
// FR: Lister toutes les transactions paginées
// EN: List all bill transactions (paginated)
final invoices = await BaaS.instance.bills.listInvoices(
  page: 1,
  perPage: 20,
  serviceCode: 'ENEO',    // Optionnel / Optional
  status: 'completed',    // 'pending' | 'completed' | 'failed'
);

print('Total transactions : ${invoices['total']}');
for (final tx in invoices['data']) {
  print('[${tx['reference']}] ${tx['service_code']} — ${tx['total_amount']} XAF — ${tx['status']}');
  print('  Reçu : ${tx['render_url']}');
}

// FR: Récupérer les détails d'une facture par référence
// EN: Get full details of a specific invoice by reference
final invoice = await BaaS.instance.bills.getInvoice('BILL_O85QALTULG_1790160727');

print('Service : ${invoice['service_code']}');
print('Client : ${invoice['invoice_data']['customer']['name']}');
print('Montant facture : ${invoice['invoice_data']['bill_amount']} XAF');
print('Commission : ${invoice['invoice_data']['admin_fee']} XAF');
print('Total payé : ${invoice['invoice_data']['total_amount']} XAF');

// Ouvrir le reçu dans un WebView Flutter
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: const Text('Facture / Invoice')),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(invoice['render_url'])),
      ),
    ),
  ),
);
```

> 💡 **Auto-service Développeur** : Depuis la console BaaS (`/baas/console/bills`), vous pouvez payer des factures pour votre propre compte et consulter l'historique complet de vos transactions.
>
> 💡 **Developer Self-Service** : From the BaaS Console (`/baas/console/bills`), developers can pay utility bills directly for their own account and access their full transaction history.

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