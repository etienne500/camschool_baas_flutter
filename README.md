# 🚀 CamSchool BaaS — SDK Flutter Officiel

[![GitHub](https://img.shields.io/badge/GitHub-etienne500%2Fcamschool__baas__flutter-blue?logo=github)](https://github.com/etienne500/camschool_baas_flutter)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Client Flutter / Dart officiel pour CamSchool BaaS (Backend-as-a-Service).**  
> Moteur complet pour Base NoSQL, Authentification Téléphone/SMS OTP, Cloud Storage, Notifications Push et **Paiements & Retraits Mobile Money (MTN, Orange, Cartes)**.

---

## 🌟 Fonctionnalités

* 💳 **Paiements & Retraits Universels (BaaS Pay)** :
  * Encaissements (PayIn) Mobile Money MTN (*126#), Orange Money (*150#) et Cartes Bancaires.
  * Commission par défaut : **7% en entrée (PayIn)**, **0% en sortie (PayOut / Retrait)** (modifiable par l'Admin par moyen de paiement).
  * **Widgets UI Drop-in** : Modales complètes `BaasPaymentModal.show(...)` et `BaasPayoutModal.show(...)` prêtes à l'emploi.
  * Polling en direct et webhooks automatiques.
* 🔥 **Base NoSQL Firestore-like** : Collections, documents JSON, requêtes filtrées (`where`), tri, pagination et écritures par lots (*Batch writes*).
* 📱 **Authentification Multi-Méthodes** : Email/Mot de passe, SMS OTP, Anonyme, persistance JWT.
* 💾 **Cloud Storage** : Téléversement multi-fichiers, métadonnées et URLs publiques/signées.
* 🔔 **Notifications Push** : FCM / APNs et Topics.

---

## 📦 Installation Directe depuis GitHub

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

## ⚙️ Initialisation (`main.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BaaS.initialize(
    baseUrl: 'https://camschool.kmrshop.com', // URL BaaS Cloud Officiel
    projectId: 'proj_zf3qirtdv4xc', // Votre Project ID
    apiKey: 'pk_live_Gjh1W9LY8DpJJJyfUuW4iGqHewiJhRDvrb9gyCZI', // Clé Publique
    autoRestoreSession: true,
  );

  runApp(const MyApp());
}
```

---

## 💳 1. PAIEMENTS & RETRAITS MOBILE MONEY

### A. Afficher le Modal de Paiement Clé-en-main (PayIn - 7% Frais)
```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

void openPayment(BuildContext context) {
  BaasPaymentModal.show(
    context,
    amount: 2500, // Montant en XAF
    currency: 'XAF',
    description: 'Abonnement Mensuel Louanges Premium',
    customerName: 'Jean Dupont',
    onSuccess: (transaction) {
      print('✅ Paiement validé avec succès : ${transaction.reference}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paiement réussi ! Réf: ${transaction.reference}')),
      );
    },
    onError: (error) {
      print('❌ Erreur de paiement : $error');
    },
  );
}
```

### B. Afficher le Modal de Retrait Clé-en-main (PayOut - 0% Frais)
```dart
void openWithdrawal(BuildContext context) {
  BaasPayoutModal.show(
    context,
    maxAmount: 50000,
    currency: 'XAF',
    beneficiaryName: 'Jean Dupont',
    onSuccess: (result) {
      print('✅ Demande de retrait envoyée : ${result.reference}');
    },
    onError: (error) {
      print('❌ Erreur de retrait : $error');
    },
  );
}
```

### C. Initier un Paiement par Code (API Directe)
```dart
final payin = await BaaS.instance.payments.initiatePayin(
  amount: 10000,
  paymentMethod: 'MTN_MOMO', // ou 'ORANGE_MONEY', 'CARD'
  phone: '670000000',
  description: 'Achat Recueil de Cantiques',
);

print('Transaction ID: ${payin.transactionId}');
print('Frais BaaS (7%): ${payin.feeAmount} XAF');
print('Net crédité: ${payin.netAmount} XAF');
print('Message USSD: ${payin.ussdPrompt}');

// Écouter le statut en direct
BaaS.instance.payments.pollTransactionStatus(payin.reference).listen((tx) {
  if (tx.isSuccessful) {
    print('Paiement confirmé sur le téléphone du client !');
  }
});
```

---

## 🗄️ 2. BASE DE DONNÉES NoSQL

```dart
// Ajouter un document
final docRef = await BaaS.instance.collection('songbooks').add({
  'title': 'Chants de Victoire',
  'total_songs': 311,
  'published': true,
});

// Requête filtrée
final results = await BaaS.instance
    .collection('songbooks')
    .whereEqualTo('published', true)
    .orderBy('total_songs', descending: true)
    .limit(20)
    .get();
```

---

## 📁 3. CLOUD STORAGE

```dart
final fileInfo = await BaaS.instance.storage.uploadBytes(
  path: 'songbooks/recueil.pdf',
  bytes: pdfBytes,
  filename: 'recueil.pdf',
  mimeType: 'application/pdf',
  isPublic: true,
);

print('URL Cloud du PDF: ${fileInfo.url}');
```

---

## 📚 Documentation Complète

Consultez le guide exhaustif **[doc.md](./doc.md)** pour l'architecture détaillée, les règles de sécurité et les webhooks.

## 📄 Licence
Licence MIT - voir le fichier [LICENSE](./LICENSE).
