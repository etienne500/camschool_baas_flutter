# 🚀 CamSchool BaaS — Guide Complet & Documentation Officielle du SDK Flutter

> **Package :** `camschool_baas_flutter`  
> **Version :** `1.0.0`  
> **Compatibilité :** Dart 3.0+ / Flutter 3.0+ (Android, iOS, Web, Windows, macOS, Linux)

---

## 1. 📖 Présentation du BaaS CamSchool

Le BaaS (**Backend-as-a-Service**) de CamSchool est une infrastructure backend complète et puissante développée en Laravel, offrant une alternative autonome à Firebase et Supabase.

### 🌟 Fonctionnalités Clés :
* **Base de données NoSQL Firestore-like** : Collections, documents JSON imbriqués, requêtes flexibles (`where`, `in`, `contains`), tri, pagination et écritures par lots (*Batch writes*).
* **Moteur d'Authentification Multi-Méthodes** :
  * 📧 Email & Mot de passe
  * 📱 Numéro de téléphone + Code OTP SMS (adapté pour les passerelles SMS locales)
  * 🕶️ Connexion Anonyme / Invité
  * 🔄 Persistance automatique de la session JWT via `SharedPreferences`.
* **Stockage de Fichiers (Cloud Storage)** : Téléversement multi-fichiers, métadonnées, URLs publiques et URLs signées temporaires.
* **Notifications Push** : Enregistrement de tokens d'appareils (FCM / APNs), gestion de sujets (*Topics*) et diffusion ciblée.
* **Moteur de Règles de Sécurité (*Security Rules*)** : Évaluation granulaire des permissions de lecture/écriture selon l'utilisateur connecté.

---

## 2. 📦 Installation & Configuration

### Étape 1 : Ajouter la dépendance dans `pubspec.yaml`

Vous pouvez intégrer le package soit en chemin local (si le dossier `packages/camschool_baas_flutter` est dans votre workspace), soit via Git :

#### Option A : Dépendance locale (Recommandée en développement)
```yaml
dependencies:
  flutter:
    sdk: flutter
  camschool_baas_flutter:
    path: ../packages/camschool_baas_flutter
  # ou shared_preferences & http si utilisation directe
```

#### Option B : Dépendance Git
```yaml
dependencies:
  camschool_baas_flutter:
    git:
      url: https://github.com/votre-compte/camschool_baas_flutter.git
      ref: main
```

Puis lancez la récupération des dépendances :
```bash
flutter pub get
```

---

## 3. ⚙️ Initialisation du SDK

Dans votre point d'entrée principal (`main.dart`), initialisez le client BaaS avant de lancer l'application :

```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du client BaaS CamSchool
  await BaaS.initialize(
    baseUrl: 'https://api.votre-domaine.cm', // ou http://10.0.2.2:8000 pour émulateur Android
    projectId: 'votre_project_id',           // Identifiant de votre projet dans la console BaaS
    apiKey: 'baas_pub_xxxxxxxxxxxxxxxxxxxx',  // Votre clé API publique
    autoRestoreSession: true,               // Restaure automatiquement le token JWT sauvegardé
  );

  runApp(const MyApp());
}
```

Une fois initialisé, accédez au client partout dans l'application via le singleton :
```dart
final baas = BaaS.instance;
```

---

## 4. 🔐 Authentification des Utilisateurs

### 4.1 Inscription par Email & Mot de passe
```dart
try {
  final user = await BaaS.instance.auth.signUpWithEmail(
    email: 'etudiant@camschool.cm',
    password: 'SuperSecretPassword123!',
    displayName: 'Paul Biya',
    metadata: {'classe': 'Terminale C', 'ville': 'Yaoundé'},
  );
  print('Utilisateur inscrit avec succès : ${user.id} - ${user.displayName}');
} on BaasAuthException catch (e) {
  print('Erreur d\'inscription : ${e.message}');
}
```

### 4.2 Connexion par Email & Mot de passe
```dart
try {
  final user = await BaaS.instance.auth.signInWithEmail(
    email: 'etudiant@camschool.cm',
    password: 'SuperSecretPassword123!',
  );
  print('Connecté avec le token : ${BaaS.instance.authToken}');
} on BaasAuthException catch (e) {
  print('Identifiants incorrects : ${e.message}');
}
```

### 4.3 Connexion par Téléphone & OTP SMS
Idéal pour le public camerounais et africain :

```dart
// Étape 1 : Demander l'envoi du code OTP par SMS
final otpResponse = await BaaS.instance.auth.sendPhoneOtp(
  phoneNumber: '+237695512390',
);
final String otpToken = otpResponse['otp_token']; // Token de transaction OTP

// Étape 2 : L'utilisateur saisit le code reçu (ex: "482910")
try {
  final user = await BaaS.instance.auth.verifyPhoneOtp(
    phoneNumber: '+237695512390',
    code: '482910',
    token: otpToken,
  );
  print('Connexion réussie par téléphone : ${user.phoneNumber}');
} on BaasAuthException catch (e) {
  print('Code SMS invalide ou expiré : ${e.message}');
}
```

### 4.4 Connexion Anonyme (Mode Invité)
```dart
final anonymousUser = await BaaS.instance.auth.signInAnonymously();
print('Utilisateur invité : ${anonymousUser.id}');
```

### 4.5 Écoute de l'état d'authentification en direct
```dart
StreamBuilder<BaasUser?>(
  stream: BaaS.instance.auth.onAuthStateChanged,
  builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  },
);
```

### 4.6 Déconnexion
```dart
await BaaS.instance.auth.signOut();
```

---

## 5. 🗄️ Base de Données NoSQL (Firestore-like)

### 5.1 Ajouter un nouveau document (ID automatique)
```dart
final docRef = await BaaS.instance.collection('courses').add({
  'title': 'Mathématiques Générales',
  'teacher': 'M. Kamdem',
  'level': 'Terminale',
  'coefficient': 4,
  'published': true,
  'created_at': DateTime.now().toIso8601String(),
});

print('Document créé avec ID : ${docRef.id}');
```

### 5.2 Créer ou écraser un document avec un ID spécifique (`set`)
```dart
await BaaS.instance.collection('user_profiles').doc(user.id).set({
  'bio': 'Étudiant passionné d\'informatique',
  'interests': ['Flutter', 'Laravel', 'IA'],
  'updated_at': DateTime.now().toIso8601String(),
}, merge: true); // merge: true met à jour sans effacer les autres champs
```

### 5.3 Mettre à jour des champs spécifiques (`update`)
```dart
await BaaS.instance.collection('courses').doc('math-101').update({
  'coefficient': 5,
  'last_reviewed_by': 'Inspecteur Pédagogique',
});
```

### 5.4 Lire un document unique (`get`)
```dart
try {
  final snapshot = await BaaS.instance.collection('courses').doc('math-101').get();
  
  if (snapshot.exists) {
    print('Titre : ${snapshot.get('title')}');
    print('Données complètes : ${snapshot.data}');
  }
} on BaasNotFoundException {
  print('Le cours demandé n\'existe pas.');
}
```

### 5.5 Supprimer un document (`delete`)
```dart
await BaaS.instance.collection('courses').doc('math-101').delete();
```

### 5.6 Requêtes Avancées avec Filtres, Tri & Pagination
Le SDK prend en charge un constructeur de requêtes puissant :

```dart
final List<BaasDocumentSnapshot> results = await BaaS.instance
    .collection('courses')
    .whereEqualTo('level', 'Terminale')
    .whereGreaterThanOrEqualTo('coefficient', 3)
    .whereIn('category', ['Scientifique', 'Technologique'])
    .orderBy('coefficient', descending: true)
    .limit(20)
    .page(1)
    .get();

for (final doc in results) {
  print('- [${doc.id}] ${doc.get('title')} (Coeff: ${doc.get('coefficient')})');
}
```

#### Opérateurs de filtrage supportés :
* `whereEqualTo(field, value)` (`==`)
* `whereNotEqualTo(field, value)` (`!=`)
* `whereGreaterThan(field, value)` (`>`)
* `whereGreaterThanOrEqualTo(field, value)` (`>=`)
* `whereLessThan(field, value)` (`<`)
* `whereLessThanOrEqualTo(field, value)` (`<=`)
* `whereIn(field, List)` (`in`)
* `whereContains(field, value)` (`contains`)

### 5.7 Écritures par Lots (*Batch Writes*) Atomiques
Exécutez plusieurs ajouts, modifications et suppressions en une seule transaction :

```dart
final batch = BaaS.instance.database.batch();

final doc1 = BaaS.instance.collection('notifications').doc('notif_1');
final doc2 = BaaS.instance.collection('stats').doc('today');

batch.set(doc1, {'message': 'Nouveau devoir disponible !', 'read': false});
batch.update(doc2, {'total_notifications': 42});

await batch.commit();
print('Lot de modifications exécuté avec succès !');
```

---

## 6. 📁 Stockage de Fichiers (Cloud Storage)

### 6.1 Téléverser un fichier depuis la mémoire ou le disque
```dart
import 'dart:io';

final File imageFile = File('/chemin/vers/photo.jpg');
final bytes = await imageFile.readAsBytes();

final BaasFileMetadata fileInfo = await BaaS.instance.storage.uploadBytes(
  path: 'avatars/${user.id}/photo.jpg',
  bytes: bytes,
  filename: 'avatar.jpg',
  mimeType: 'image/jpeg',
  isPublic: true,
);

print('Fichier accessible via URL : ${fileInfo.url}');
print('Taille du fichier : ${fileInfo.size} octets');
```

### 6.2 Obtenir une URL Signée Temporaire (Fichier Privé)
```dart
final String signedUrl = await BaaS.instance.storage.getSignedUrl(
  'documents_confidentiels/bulletin_t1.pdf',
  expiresInMinutes: 30, // Valable 30 minutes
);

print('Lien sécurisé temporaire : $signedUrl');
```

### 6.3 Supprimer un fichier
```dart
await BaaS.instance.storage.deleteFile('avatars/${user.id}/photo.jpg');
```

---

## 7. 🔔 Notifications Push & Alertes

### 7.1 Enregistrer le Token FCM de l'appareil
```dart
import 'package:firebase_messaging/firebase_messaging.dart';

// Récupérer le token FCM de l'appareil
String? fcmToken = await FirebaseMessaging.instance.getToken();

if (fcmToken != null) {
  await BaaS.instance.notifications.registerDeviceToken(
    token: fcmToken,
    platform: 'android', // 'android' ou 'ios'
    topics: ['annonces_generales', 'terminale_c'],
  );
  print('Device Token enregistré sur CamSchool BaaS !');
}
```

### 7.2 Envoyer une Notification Push
```dart
await BaaS.instance.notifications.send(
  topic: 'terminale_c',
  title: 'Rappel Examen Blanc',
  body: 'L\'épreuve de Physique débutera demain à 08h00.',
  data: {'screen': '/exams', 'exam_id': 'phys_2026'},
);
```

---

## 8. 🛡️ Gestion des Erreurs

Toutes les erreurs de l'API sont typées pour une gestion fine et propre dans vos interfaces Flutter :

```dart
try {
  await BaaS.instance.collection('secrets').doc('admin').get();
} on BaasPermissionDeniedException catch (e) {
  // Erreur 403 : Accès interdit par les règles de sécurité (Security Rules)
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Accès refusé : ${e.message}')),
  );
} on BaasNotFoundException catch (e) {
  // Erreur 404 : Document introuvable
  print('Non trouvé : ${e.message}');
} on BaasQuotaExceededException catch (e) {
  // Erreur 429 : Quota du projet atteint
  print('Quota d\'appels API dépassé : ${e.message}');
} on BaasAuthException catch (e) {
  // Erreur 401 : Non authentifié ou token expiré
  print('Session expirée, veuillez vous reconnecter.');
} on BaasException catch (e) {
  // Erreur générique BaaS
  print('Erreur BaaS : ${e.message} (Code: ${e.statusCode})');
}
```

---

## 9. 📱 Exemple d'Implémentation Complète dans un Widget Flutter

Voici un écran complet affichant une liste de cours avec ajout en direct :

```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<BaasDocumentSnapshot> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    setState(() => _isLoading = true);
    try {
      final results = await BaaS.instance
          .collection('courses')
          .orderBy('title')
          .limit(50)
          .get();

      setState(() {
        _courses = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  Future<void> _addNewCourse() async {
    final titleController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nouveau Cours'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Titre du cours (ex: SVT)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                await BaaS.instance.collection('courses').add({
                  'title': titleController.text.trim(),
                  'created_at': DateTime.now().toIso8601String(),
                });
                Navigator.pop(ctx);
                _fetchCourses();
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CamSchool — Liste des Cours'),
        actions: [
          IconButton(onPressed: _fetchCourses, icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCourse,
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _courses.isEmpty
              ? const Center(child: Text('Aucun cours disponible.'))
              : ListView.builder(
                  itemCount: _courses.length,
                  itemBuilder: (context, index) {
                    final doc = _courses[index];
                    return ListTile(
                      title: Text(doc.get('title') ?? 'Sans titre'),
                      subtitle: Text('ID: ${doc.id}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await doc.reference.delete();
                          _fetchCourses();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
```

---

## 8. 💬 Messagerie SMS & Emails

### 8.1 Envoi de SMS (25 FCFA / SMS)

Le module SMS permet de notifier directement vos étudiants, clients ou administrateurs par SMS avec suivi en direct.

```dart
// Envoi d'un SMS unitaire (25 FCFA)
final smsResult = await BaaS.instance.sms.send(
  to: '+237655797860',
  message: 'Rappel : Votre cours de Mathématiques commence à 15h.',
  senderId: 'CamSchool',
);

print('SMS envoyé : ${smsResult.success}');
print('Coût total : ${smsResult.totalCost} ${smsResult.currency}'); // 25.0 XAF

// Envoi de SMS groupés
final bulkResult = await BaaS.instance.sms.sendBulk(
  recipients: ['+237655797860', '+237697336094'],
  message: 'Nouvelle publication disponible sur votre espace.',
);
print('Envoyés : ${bulkResult.sentCount} / Coût : ${bulkResult.totalCost} FCFA');
```

### 8.2 Envoi d'Emails Transactionnels

```dart
final emailResult = await BaaS.instance.mail.send(
  to: 'parent@camschool.cm',
  subject: 'Convocation réunion parents-enseignants',
  html: '<h2>Chers parents,</h2><p>Vous êtes conviés ce samedi à 10h.</p>',
  fromName: 'Direction CamSchool',
  replyTo: 'contact@camschool.cm',
);
print('Email expédié : ${emailResult.success}');
```

---

## 10. 🏆 Résumé & Bonnes Pratiques

1. **Toujours initialiser dans `main.dart`** avec `await BaaS.initialize(...)`.
2. **Ne stockez jamais votre `secret_key` dans le code Flutter** ; utilisez uniquement la clé d'API publique (`apiKey`).
3. **Configurez des règles de sécurité (`Security Rules`)** dans votre console BaaS CamSchool pour protéger vos collections privées.
