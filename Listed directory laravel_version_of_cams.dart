Listed directory laravel_version_of_camschool_api
Ran command: `Get-ChildItem -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS" -Recurse | Select-Object FullName`

J'analyse la structure du système BaaS dans votre projet Laravel CamSchool...

Used tool: manage_task
Used tool: schedule

Analyse en cours du système BaaS...

Used tool: manage_task
Used tool: manage_task
Ran command: `powershell -Command "Get-ChildItem 'C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS' -Recurse | Select-Object -ExpandProperty FullName"`
Used tool: schedule

Analyse des composants BaaS...

Used tool: manage_task
Used tool: manage_task
Ran command: `cmd /c dir /b "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS"`
Used tool: schedule

Lecture du dossier BaaS en cours...

Ran command: `cmd /c dir /s /b "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS"`
Used tool: schedule

Analyse de l'arborescence BaaS en cours...

Used tool: manage_task
Ran command: `cmd /c dir /s /b "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\Http"`
Used tool: schedule

Analyse des contrôleurs BaaS en cours...

Used tool: manage_task
Used tool: manage_task
Ran command: `cmd /c type "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\BaasServiceProvider.php"`
Used tool: schedule

Lecture de la configuration du service BaaS...

Used tool: manage_task
Used tool: manage_task
Ran command: `Get-Content -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\routes\baas_api.php" -Raw`
Used tool: schedule

Lecture des routes BaaS API...

Ran command: `Get-Content -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\SDK\Js\baas_client.js" -Raw`
Used tool: schedule
Used tool: manage_task
Used tool: schedule

Lecture du SDK JS...

Used tool: manage_task
Ran command: `Get-Content -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\SDK\Flutter\baas_flutter_sdk.dart" -Raw`
Used tool: schedule

Lecture du SDK Flutter...

Used tool: manage_task
Ran command: `Get-Content -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\Http\Controllers\Api\V1\DatabaseApiController.php" -Raw`
Used tool: schedule
Used tool: manage_task
Used tool: schedule
Used tool: manage_task
Used tool: manage_task
Ran command: `cmd /c dir "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\SDK"`
Used tool: schedule
Used tool: manage_task
Used tool: manage_task
Ran command: `powershell -Command "New-Item -ItemType Directory -Force -Path 'C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src' ; New-Item -ItemType Directory -Force -Path 'C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src'"`
Used tool: schedule

Création des dossiers de packages...

Used tool: manage_task
Used tool: manage_task
Ran command: `New-Item -ItemType Directory -Force -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src", "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src"`
Used tool: schedule

Création des répertoires de packages...

Used tool: manage_task
Created pubspec.yaml
Ran command: `@'
name: camschool_baas_flutter
description: Complete Client SDK for CamSchool BaaS (Backend-as-a-Service) providing Firestore-like NoSQL database, phone & email Auth, Storage and Push Notifications.
version: 1.0.0
homepage: https://camschool.cm
repository: https://github.com/camschool/baas-flutter-sdk

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.0.0'

dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\pubspec.yaml" -Encoding utf8`
Used tool: schedule
Ran command: `@'
/// CamSchool BaaS Flutter SDK
/// 
/// Official Flutter / Dart client for CamSchool Backend-as-a-Service.
/// Provides Firestore-like NoSQL JSON document store, Authentication (Email, Phone OTP, Anonymous),
/// Cloud Storage and Push Notifications.
library camschool_baas_flutter;

export 'src/client.dart';
export 'src/auth.dart';
export 'src/database.dart';
export 'src/storage.dart';
export 'src/notifications.dart';
export 'src/exceptions.dart';
export 'src/models.dart';
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\camschool_baas_flutter.dart" -Encoding utf8`
Used tool: schedule
Ran command: `@'
/// Custom BaaS Exceptions
class BaasException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  BaasException(this.message, {this.statusCode, this.details});

  @override
  String toString() => 'BaasException: $message (status: $statusCode)';
}

class BaasAuthException extends BaasException {
  BaasAuthException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode, details: details);
}

class BaasPermissionDeniedException extends BaasException {
  BaasPermissionDeniedException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode ?? 403, details: details);
}

class BaasNotFoundException extends BaasException {
  BaasNotFoundException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode ?? 404, details: details);
}

class BaasQuotaExceededException extends BaasException {
  BaasQuotaExceededException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode ?? 429, details: details);
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\exceptions.dart" -Encoding utf8`
Ran command: `@'
/// BaaS User Model
class BaasUser {
  final String id;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? avatarUrl;
  final bool isAnonymous;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;

  BaasUser({
    required this.id,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.avatarUrl,
    this.isAnonymous = false,
    this.metadata = const {},
    this.createdAt,
  });

  factory BaasUser.fromMap(Map<String, dynamic> map) {
    return BaasUser(
      id: (map['id'] ?? map['user_id'] ?? '').toString(),
      email: map['email'],
      phoneNumber: map['phone_number'] ?? map['phone'],
      displayName: map['display_name'] ?? map['name'],
      avatarUrl: map['avatar_url'] ?? map['photo_url'],
      isAnonymous: map['is_anonymous'] ?? false,
      metadata: map['metadata'] is Map<String, dynamic> ? map['metadata'] : {},
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone_number': phoneNumber,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'is_anonymous': isAnonymous,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

/// BaaS Document Snapshot
class BaasDocumentSnapshot {
  final String id;
  final String collection;
  final Map<String, dynamic> data;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaasDocumentSnapshot({
    required this.id,
    required this.collection,
    required this.data,
    this.createdAt,
    this.updatedAt,
  });

  bool get exists => data.isNotEmpty;

  dynamic get(String field) {
    return data[field];
  }

  factory BaasDocumentSnapshot.fromMap(Map<String, dynamic> map, {String? collection}) {
    final rawData = map['data'];
    Map<String, dynamic> docData = {};
    if (rawData is Map<String, dynamic>) {
      docData = rawData;
    } else if (map.containsKey('data') && map['data'] == null) {
      docData = {};
    } else {
      docData = Map<String, dynamic>.from(map);
      docData.remove('id');
      docData.remove('document_id');
      docData.remove('collection');
      docData.remove('created_at');
      docData.remove('updated_at');
    }

    return BaasDocumentSnapshot(
      id: (map['document_id'] ?? map['id'] ?? '').toString(),
      collection: collection ?? map['collection'] ?? '',
      data: docData,
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'].toString()) : null,
      updatedAt: map['updated_at'] != null ? DateTime.tryParse(map['updated_at'].toString()) : null,
    );
  }
}

/// BaaS File Metadata
class BaasFileMetadata {
  final String id;
  final String path;
  final String filename;
  final String url;
  final int size;
  final String? mimeType;
  final DateTime? createdAt;

  BaasFileMetadata({
    required this.id,
    required this.path,
    required this.filename,
    required this.url,
    required this.size,
    this.mimeType,
    this.createdAt,
  });

  factory BaasFileMetadata.fromMap(Map<String, dynamic> map) {
    return BaasFileMetadata(
      id: (map['id'] ?? '').toString(),
      path: map['path'] ?? '',
      filename: map['filename'] ?? map['original_name'] ?? '',
      url: map['url'] ?? '',
      size: map['size'] ?? 0,
      mimeType: map['mime_type'],
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'].toString()) : null,
    );
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\models.dart" -Encoding utf8`
Used tool: schedule
Ran command: `@'
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'database.dart';
import 'storage.dart';
import 'notifications.dart';
import 'exceptions.dart';

/// Main CamSchool BaaS Client
class BaaS {
  static BaaS? _instance;

  final String baseUrl;
  final String projectId;
  final String apiKey;
  final String prefix;

  String? _authToken;

  late final BaasAuth auth;
  late final BaasDatabase database;
  late final BaasStorage storage;
  late final BaasNotifications notifications;

  BaaS._internal({
    required this.baseUrl,
    required this.projectId,
    required this.apiKey,
    this.prefix = 'api/baas/v1',
  }) {
    auth = BaasAuth(this);
    database = BaasDatabase(this);
    storage = BaasStorage(this);
    notifications = BaasNotifications(this);
  }

  /// Initialize the BaaS Singleton instance.
  static Future<BaaS> initialize({
    required String baseUrl,
    required String projectId,
    required String apiKey,
    String prefix = 'api/baas/v1',
    bool autoRestoreSession = true,
  }) async {
    final cleanUrl = baseUrl.replaceAll(RegExp(r'/+$'), '');
    final client = BaaS._internal(
      baseUrl: cleanUrl,
      projectId: projectId,
      apiKey: apiKey,
      prefix: prefix,
    );

    if (autoRestoreSession) {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString('camschool_baas_auth_token_${projectId}');
      if (savedToken != null && savedToken.isNotEmpty) {
        client._authToken = savedToken;
      }
    }

    _instance = client;
    return client;
  }

  /// Get the active Singleton instance.
  static BaaS get instance {
    if (_instance == null) {
      throw StateError(
        'BaaS has not been initialized. Call await BaaS.initialize(...) first in your main().',
      );
    }
    return _instance!;
  }

  /// Current Auth JWT Token
  String? get authToken => _authToken;

  /// Update active auth token and optionally persist to device.
  Future<void> setAuthToken(String? token, {bool persist = true}) async {
    _authToken = token;
    if (persist) {
      final prefs = await SharedPreferences.getInstance();
      if (token == null) {
        await prefs.remove('camschool_baas_auth_token_${projectId}');
      } else {
        await prefs.setString('camschool_baas_auth_token_${projectId}', token);
      }
    }
  }

  /// Construct full URL for an endpoint
  Uri buildUrl(String endpoint) {
    final cleanEndpoint = endpoint.replaceAll(RegExp(r'^/+'), '');
    final fullPath = '$baseUrl/$prefix/$projectId/$cleanEndpoint';
    return Uri.parse(fullPath);
  }

  /// Default HTTP headers
  Map<String, String> get defaultHeaders {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-API-Key': apiKey,
      'X-Project-ID': projectId,
    };
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  /// Helper for executing JSON requests
  Future<dynamic> request(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? customHeaders,
  }) async {
    final url = buildUrl(endpoint);
    final headers = {
      ...defaultHeaders,
      if (customHeaders != null) ...customHeaders,
    };

    http.Response response;
    final encodedBody = body != null ? jsonEncode(body) : null;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(url, headers: headers);
        break;
      case 'POST':
        response = await http.post(url, headers: headers, body: encodedBody);
        break;
      case 'PUT':
        response = await http.put(url, headers: headers, body: encodedBody);
        break;
      case 'PATCH':
        response = await http.patch(url, headers: headers, body: encodedBody);
        break;
      case 'DELETE':
        response = await http.delete(url, headers: headers, body: encodedBody);
        break;
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }

    dynamic jsonResponse;
    try {
      jsonResponse = jsonDecode(response.body);
    } catch (_) {
      jsonResponse = {'message': response.body};
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonResponse;
    }

    final message = jsonResponse is Map && jsonResponse['message'] != null
        ? jsonResponse['message'].toString()
        : 'Request failed with status ${response.statusCode}';

    switch (response.statusCode) {
      case 401:
        throw BaasAuthException(message, statusCode: 401, details: jsonResponse);
      case 403:
        throw BaasPermissionDeniedException(message, statusCode: 403, details: jsonResponse);
      case 404:
        throw BaasNotFoundException(message, statusCode: 404, details: jsonResponse);
      case 429:
        throw BaasQuotaExceededException(message, statusCode: 429, details: jsonResponse);
      default:
        throw BaasException(message, statusCode: response.statusCode, details: jsonResponse);
    }
  }

  /// Convenient shortcuts
  BaasCollectionReference collection(String name) => database.collection(name);
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\client.dart" -Encoding utf8`
Ran command: `@'
import 'dart:async';
import 'client.dart';
import 'models.dart';
import 'exceptions.dart';

/// Authentication Module
class BaasAuth {
  final BaaS _client;
  BaasUser? _currentUser;
  final StreamController<BaasUser?> _authStateController = StreamController<BaasUser?>.broadcast();

  BaasAuth(this._client);

  /// Currently authenticated user, or null.
  BaasUser? get currentUser => _currentUser;

  /// Whether a user is currently signed in.
  bool get isAuthenticated => _client.authToken != null && _client.authToken!.isNotEmpty;

  /// Stream emitting auth state changes.
  Stream<BaasUser?> get onAuthStateChanged => _authStateController.stream;

  /// Register a new user with email and password.
  Future<BaasUser> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
    Map<String, dynamic>? metadata,
  }) async {
    final res = await _client.request('POST', 'auth/register', body: {
      'email': email,
      'password': password,
      if (displayName != null) 'display_name': displayName,
      if (metadata != null) 'metadata': metadata,
    });

    final data = res['data'] ?? {};
    final token = data['token'];
    if (token != null) {
      await _client.setAuthToken(token.toString());
    }

    final userData = data['user'] is Map<String, dynamic> ? data['user'] : data;
    _currentUser = BaasUser.fromMap(userData);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Sign in with email and password.
  Future<BaasUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final res = await _client.request('POST', 'auth/login', body: {
      'email': email,
      'password': password,
    });

    final data = res['data'] ?? {};
    final token = data['token'];
    if (token != null) {
      await _client.setAuthToken(token.toString());
    }

    final userData = data['user'] is Map<String, dynamic> ? data['user'] : data;
    _currentUser = BaasUser.fromMap(userData);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Request an SMS OTP code for a phone number.
  Future<Map<String, dynamic>> sendPhoneOtp({
    required String phoneNumber,
  }) async {
    final res = await _client.request('POST', 'auth/otp/send', body: {
      'phone_number': phoneNumber,
    });
    return res['data'] is Map<String, dynamic> ? res['data'] : {'message': res['message']};
  }

  /// Verify an SMS OTP code and log the user in.
  Future<BaasUser> verifyPhoneOtp({
    required String phoneNumber,
    required String code,
    required String token,
  }) async {
    final res = await _client.request('POST', 'auth/otp/verify', body: {
      'phone_number': phoneNumber,
      'code': code,
      'token': token,
    });

    final data = res['data'] ?? {};
    final jwtToken = data['token'];
    if (jwtToken != null) {
      await _client.setAuthToken(jwtToken.toString());
    }

    final userData = data['user'] is Map<String, dynamic> ? data['user'] : data;
    _currentUser = BaasUser.fromMap(userData);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Sign in anonymously.
  Future<BaasUser> signInAnonymously({String? deviceId}) async {
    final res = await _client.request('POST', 'auth/anonymous', body: {
      if (deviceId != null) 'device_id': deviceId,
    });

    final data = res['data'] ?? {};
    final token = data['token'];
    if (token != null) {
      await _client.setAuthToken(token.toString());
    }

    final userData = data['user'] is Map<String, dynamic> ? data['user'] : data;
    _currentUser = BaasUser.fromMap(userData);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Refresh active session token.
  Future<String> refreshToken({String? refreshToken}) async {
    final res = await _client.request('POST', 'auth/refresh', body: {
      if (refreshToken != null) 'refresh_token': refreshToken,
    });

    final data = res['data'] ?? {};
    final newToken = data['token']?.toString() ?? '';
    if (newToken.isNotEmpty) {
      await _client.setAuthToken(newToken);
    }
    return newToken;
  }

  /// Fetch the authenticated user's profile from the server.
  Future<BaasUser> getProfile() async {
    final res = await _client.request('GET', 'auth/me');
    final userData = res['data'] is Map<String, dynamic> ? res['data'] : {};
    _currentUser = BaasUser.fromMap(userData);
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Sign out the current user and clear stored token.
  Future<void> signOut() async {
    await _client.setAuthToken(null);
    _currentUser = null;
    _authStateController.add(null);
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\auth.dart" -Encoding utf8`
Ran command: `@'
import 'client.dart';
import 'models.dart';

/// Database Manager (Firestore-like NoSQL)
class BaasDatabase {
  final BaaS _client;

  BaasDatabase(this._client);

  /// Access a collection reference
  BaasCollectionReference collection(String collectionName) {
    return BaasCollectionReference(_client, collectionName);
  }

  /// Create a batch for atomic multiple writes
  BaasWriteBatch batch() {
    return BaasWriteBatch(_client);
  }
}

/// Query Builder & Collection Reference
class BaasCollectionReference extends BaasQuery {
  final BaaS _client;
  final String collectionName;

  BaasCollectionReference(this._client, this.collectionName)
      : super(_client, collectionName);

  /// Get a reference to a document in this collection
  BaasDocumentReference doc([String? documentId]) {
    return BaasDocumentReference(_client, collectionName, documentId);
  }

  /// Add a new document with an auto-generated or server-assigned ID.
  Future<BaasDocumentReference> add(Map<String, dynamic> data) async {
    final res = await _client.request(
      'POST',
      'collections/$collectionName/documents',
      body: {'data': data},
    );

    final docData = res['data'] is Map<String, dynamic> ? res['data'] : {};
    final docId = (docData['document_id'] ?? docData['id'] ?? '').toString();
    return doc(docId);
  }
}

/// Query Class for filtering and sorting
class BaasQuery {
  final BaaS _client;
  final String _collectionName;
  final List<Map<String, dynamic>> _filters = [];
  String? _orderByField;
  String _orderDirection = 'asc';
  int? _limitCount;
  int? _page;

  BaasQuery(this._client, this._collectionName);

  /// Add a filter condition (==, !=, >, >=, <, <=, in, not_in, contains)
  BaasQuery where(String field, String operator, dynamic value) {
    final query = _clone();
    query._filters.add({
      'field': field,
      'operator': operator,
      'value': value,
    });
    return query;
  }

  BaasQuery whereEqualTo(String field, dynamic value) => where(field, '==', value);
  BaasQuery whereNotEqualTo(String field, dynamic value) => where(field, '!=', value);
  BaasQuery whereGreaterThan(String field, dynamic value) => where(field, '>', value);
  BaasQuery whereGreaterThanOrEqualTo(String field, dynamic value) => where(field, '>=', value);
  BaasQuery whereLessThan(String field, dynamic value) => where(field, '<', value);
  BaasQuery whereLessThanOrEqualTo(String field, dynamic value) => where(field, '<=', value);
  BaasQuery whereIn(String field, List<dynamic> values) => where(field, 'in', values);
  BaasQuery whereContains(String field, dynamic value) => where(field, 'contains', value);

  /// Order documents by a field
  BaasQuery orderBy(String field, {bool descending = false}) {
    final query = _clone();
    query._orderByField = field;
    query._orderDirection = descending ? 'desc' : 'asc';
    return query;
  }

  /// Limit the number of documents returned
  BaasQuery limit(int count) {
    final query = _clone();
    query._limitCount = count;
    return query;
  }

  /// Page for pagination
  BaasQuery page(int pageNumber) {
    final query = _clone();
    query._page = pageNumber;
    return query;
  }

  BaasQuery _clone() {
    final copy = BaasQuery(_client, _collectionName);
    copy._filters.addAll(_filters);
    copy._orderByField = _orderByField;
    copy._orderDirection = _orderDirection;
    copy._limitCount = _limitCount;
    copy._page = _page;
    return copy;
  }

  /// Execute the query and get matching documents
  Future<List<BaasDocumentSnapshot>> get() async {
    final payload = <String, dynamic>{
      'filters': _filters,
      if (_orderByField != null) 'order_by': _orderByField,
      'order_dir': _orderDirection,
      if (_limitCount != null) 'limit': _limitCount,
      if (_page != null) 'page': _page,
    };

    final res = await _client.request(
      'POST',
      'collections/$_collectionName/query',
      body: payload,
    );

    final rawList = res['data'] is List ? res['data'] as List : [];
    return rawList
        .map((item) => BaasDocumentSnapshot.fromMap(
              item is Map<String, dynamic> ? item : {},
              collection: _collectionName,
            ))
        .toList();
  }
}

/// Document Reference for direct single document operations
class BaasDocumentReference {
  final BaaS _client;
  final String collectionName;
  final String? documentId;

  BaasDocumentReference(this._client, this.collectionName, this.documentId);

  String get id => documentId ?? '';
  String get path => 'collections/$collectionName/documents/$documentId';

  /// Get the current snapshot of this document
  Future<BaasDocumentSnapshot> get() async {
    if (documentId == null || documentId!.isEmpty) {
      throw ArgumentError('Document ID is required to fetch a document snapshot.');
    }

    final res = await _client.request(
      'GET',
      'collections/$collectionName/documents/$documentId',
    );

    final rawData = res['data'] is Map<String, dynamic> ? res['data'] as Map<String, dynamic> : {};
    return BaasDocumentSnapshot.fromMap(rawData, collection: collectionName);
  }

  /// Overwrite or create a document with a specific ID.
  Future<void> set(Map<String, dynamic> data, {bool merge = false}) async {
    if (documentId == null || documentId!.isEmpty) {
      throw ArgumentError('Document ID is required for set(). Use collection.add() for auto IDs.');
    }

    await _client.request(
      'PUT',
      'collections/$collectionName/documents/$documentId',
      body: {
        'data': data,
        'merge': merge,
      },
    );
  }

  /// Update specific fields in this document
  Future<void> update(Map<String, dynamic> data) async {
    if (documentId == null || documentId!.isEmpty) {
      throw ArgumentError('Document ID is required for update().');
    }

    await _client.request(
      'PATCH',
      'collections/$collectionName/documents/$documentId',
      body: data,
    );
  }

  /// Delete this document
  Future<void> delete() async {
    if (documentId == null || documentId!.isEmpty) {
      throw ArgumentError('Document ID is required for delete().');
    }

    await _client.request(
      'DELETE',
      'collections/$collectionName/documents/$documentId',
    );
  }
}

/// Transactional Batch Writes
class BaasWriteBatch {
  final BaaS _client;
  final List<Map<String, dynamic>> _operations = [];

  BaasWriteBatch(this._client);

  void set(BaasDocumentReference doc, Map<String, dynamic> data, {bool merge = false}) {
    _operations.add({
      'type': 'set',
      'collection': doc.collectionName,
      'document_id': doc.id,
      'data': data,
      'merge': merge,
    });
  }

  void update(BaasDocumentReference doc, Map<String, dynamic> data) {
    _operations.add({
      'type': 'update',
      'collection': doc.collectionName,
      'document_id': doc.id,
      'data': data,
    });
  }

  void delete(BaasDocumentReference doc) {
    _operations.add({
      'type': 'delete',
      'collection': doc.collectionName,
      'document_id': doc.id,
    });
  }

  /// Commit all batch operations atomically
  Future<dynamic> commit() async {
    return await _client.request(
      'POST',
      'batch',
      body: {'operations': _operations},
    );
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\database.dart" -Encoding utf8`
Ran command: `@'
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'client.dart';
import 'models.dart';
import 'exceptions.dart';

/// Cloud Storage Module
class BaasStorage {
  final BaaS _client;

  BaasStorage(this._client);

  /// Upload file bytes to cloud storage
  Future<BaasFileMetadata> uploadBytes({
    required String path,
    required List<int> bytes,
    required String filename,
    String? mimeType,
    bool isPublic = true,
  }) async {
    final uri = _client.buildUrl('storage/upload');
    final request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'X-API-Key': _client.apiKey,
      'X-Project-ID': _client.projectId,
      'Accept': 'application/json',
    });
    if (_client.authToken != null && _client.authToken!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer ${_client.authToken}';
    }

    request.fields['path'] = path;
    request.fields['visibility'] = isPublic ? 'public' : 'private';

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: filename,
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    dynamic json;
    try {
      json = jsonDecode(response.body);
    } catch (_) {
      json = {'message': response.body};
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final fileData = json['data'] is Map<String, dynamic> ? json['data'] : json;
      return BaasFileMetadata.fromMap(fileData);
    }

    throw BaasException(
      json['message'] ?? 'Storage upload failed',
      statusCode: response.statusCode,
      details: json,
    );
  }

  /// List files in storage
  Future<List<BaasFileMetadata>> listFiles({String? path, int limit = 50}) async {
    final queryParams = <String, dynamic>{
      if (path != null) 'path': path,
      'limit': limit,
    };

    final res = await _client.request('GET', 'storage/files');
    final rawList = res['data'] is List ? res['data'] as List : [];
    return rawList.map((item) => BaasFileMetadata.fromMap(item)).toList();
  }

  /// Generate a temporary signed download URL
  Future<String> getSignedUrl(String path, {int expiresInMinutes = 60}) async {
    final res = await _client.request('POST', 'storage/signed-url', body: {
      'path': path,
      'expires_in': expiresInMinutes,
    });
    return res['data']['signed_url'] ?? res['data']['url'] ?? '';
  }

  /// Delete a file by path
  Future<bool> deleteFile(String path) async {
    final res = await _client.request('DELETE', 'storage/files', body: {
      'path': path,
    });
    return res['success'] == true;
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\storage.dart" -Encoding utf8`
Ran command: `@'
import 'client.dart';

/// Push Notifications Module
class BaasNotifications {
  final BaaS _client;

  BaasNotifications(this._client);

  /// Register a device FCM/APNs push token with platform and topics
  Future<void> registerDeviceToken({
    required String token,
    String platform = 'android',
    List<String>? topics,
  }) async {
    await _client.request('POST', 'notifications/devices', body: {
      'token': token,
      'platform': platform,
      'topics': topics ?? [],
    });
  }

  /// Send a notification to a specific user or broadcast topic
  Future<Map<String, dynamic>> send({
    String? userId,
    String? topic,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final res = await _client.request('POST', 'notifications/send', body: {
      if (userId != null) 'user_id': userId,
      if (topic != null) 'topic': topic,
      'title': title,
      'body': body,
      'data': data ?? {},
    });
    return res['data'] is Map<String, dynamic> ? res['data'] : {'success': true};
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\lib\src\notifications.dart" -Encoding utf8`
Ran command: `@'
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

## 10. 🏆 Résumé & Bonnes Pratiques

1. **Toujours initialiser dans `main.dart`** avec `await BaaS.initialize(...)`.
2. **Ne stockez jamais votre `secret_key` dans le code Flutter** ; utilisez uniquement la clé d'API publique (`apiKey`).
3. **Configurez des règles de sécurité (`Security Rules`)** dans votre console BaaS CamSchool pour protéger vos collections privées.
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\doc.md" -Encoding utf8`
Ran command: `@'
# camschool_baas_flutter

Official Flutter SDK for **CamSchool BaaS** (Backend-as-a-Service).

## Features
- 🔥 Firestore-like NoSQL JSON document database
- 📱 Phone OTP SMS, Email/Password and Anonymous Authentication
- 💾 Cloud Storage with file upload, public and signed URLs
- 🔔 Push Notifications registration and dispatch
- 🔒 Security Rules evaluation and JWT session handling

## Documentation
Please check [doc.md](./doc.md) for full documentation, installation guide, and code examples.
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\README.md" -Encoding utf8`
Ran command: `@'
{
  "name": "@camschool/baas-js",
  "version": "1.0.0",
  "description": "Universal JavaScript / TypeScript Client SDK for CamSchool BaaS (Backend-as-a-Service) for Web, Node.js, React, Vue, React Native.",
  "main": "dist/index.js",
  "module": "dist/index.mjs",
  "types": "dist/index.d.ts",
  "scripts": {
    "build": "tsc",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [
    "camschool",
    "baas",
    "backend-as-a-service",
    "firestore",
    "nosql",
    "auth",
    "storage",
    "notifications",
    "cameroon",
    "sdk"
  ],
  "author": "CamSchool Team",
  "license": "MIT"
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\package.json" -Encoding utf8`
Ran command: `@'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "declaration": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\tsconfig.json" -Encoding utf8`
Ran command: `@'
export interface BaasConfig {
  baseUrl: string;
  projectId: string;
  apiKey: string;
  prefix?: string;
  storageKey?: string;
  autoRestoreSession?: boolean;
}

export interface BaasUser {
  id: string;
  email?: string;
  phoneNumber?: string;
  displayName?: string;
  avatarUrl?: string;
  isAnonymous?: boolean;
  metadata?: Record<string, any>;
  createdAt?: string;
}

export interface BaasAuthResponse {
  token: string;
  user: BaasUser;
  expires_at?: string;
}

export interface BaasDocument<T = Record<string, any>> {
  id: string;
  document_id?: string;
  data: T;
  created_at?: string;
  updated_at?: string;
}

export type QueryOperator =
  | '=='
  | '='
  | '!='
  | '>'
  | '>='
  | '<'
  | '<='
  | 'in'
  | 'not_in'
  | 'contains'
  | 'array_contains';

export interface QueryFilter {
  field: string;
  operator: QueryOperator;
  value: any;
}

export interface QueryOptions {
  filters?: QueryFilter[];
  order_by?: string | null;
  order_dir?: 'asc' | 'desc';
  limit?: number;
  page?: number;
}

export interface BaasFileMetadata {
  id: string;
  path: string;
  filename: string;
  url: string;
  size: number;
  mime_type?: string;
  created_at?: string;
}

export interface BatchOperation {
  type: 'set' | 'update' | 'delete';
  collection: string;
  document_id: string;
  data?: Record<string, any>;
  merge?: boolean;
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\types.ts" -Encoding utf8`
Ran command: `@'
export class BaasError extends Error {
  public statusCode?: number;
  public details?: any;

  constructor(message: string, statusCode?: number, details?: any) {
    super(message);
    this.name = 'BaasError';
    this.statusCode = statusCode;
    this.details = details;
  }
}

export class BaasAuthError extends BaasError {
  constructor(message: string, statusCode = 401, details?: any) {
    super(message, statusCode, details);
    this.name = 'BaasAuthError';
  }
}

export class BaasPermissionError extends BaasError {
  constructor(message: string, statusCode = 403, details?: any) {
    super(message, statusCode, details);
    this.name = 'BaasPermissionError';
  }
}

export class BaasNotFoundError extends BaasError {
  constructor(message: string, statusCode = 404, details?: any) {
    super(message, statusCode, details);
    this.name = 'BaasNotFoundError';
  }
}

export class BaasQuotaError extends BaasError {
  constructor(message: string, statusCode = 429, details?: any) {
    super(message, statusCode, details);
    this.name = 'BaasQuotaError';
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\errors.ts" -Encoding utf8`
Ran command: `@'
import { BaasConfig } from './types';
import { BaasAuth } from './auth';
import { BaasDatabase, BaasCollectionReference } from './database';
import { BaasStorage } from './storage';
import { BaasNotifications } from './notifications';
import {
  BaasError,
  BaasAuthError,
  BaasPermissionError,
  BaasNotFoundError,
  BaasQuotaError,
} from './errors';

export class BaasClient {
  public baseUrl: string;
  public projectId: string;
  public apiKey: string;
  public prefix: string;
  private authToken: string | null = null;
  private storageKey: string;

  public auth: BaasAuth;
  public database: BaasDatabase;
  public storage: BaasStorage;
  public notifications: BaasNotifications;

  constructor(config: BaasConfig) {
    this.baseUrl = config.baseUrl.replace(/\/+$/, '');
    this.projectId = config.projectId;
    this.apiKey = config.apiKey;
    this.prefix = config.prefix || 'api/baas/v1';
    this.storageKey = config.storageKey || `camschool_baas_token_${this.projectId}`;

    // Initialize submodules
    this.auth = new BaasAuth(this);
    this.database = new BaasDatabase(this);
    this.storage = new BaasStorage(this);
    this.notifications = new BaasNotifications(this);

    // Auto-restore session from localStorage if in browser environment
    if (config.autoRestoreSession !== false && typeof window !== 'undefined' && window.localStorage) {
      const savedToken = window.localStorage.getItem(this.storageKey);
      if (savedToken) {
        this.authToken = savedToken;
      }
    }
  }

  public getAuthToken(): string | null {
    return this.authToken;
  }

  public setAuthToken(token: string | null): void {
    this.authToken = token;
    if (typeof window !== 'undefined' && window.localStorage) {
      if (token) {
        window.localStorage.setItem(this.storageKey, token);
      } else {
        window.localStorage.removeItem(this.storageKey);
      }
    }
  }

  public buildUrl(endpoint: string): string {
    const cleanEndpoint = endpoint.replace(/^\/+/, '');
    return `${this.baseUrl}/${this.prefix}/${this.projectId}/${cleanEndpoint}`;
  }

  public getHeaders(customHeaders: Record<string, string> = {}): Record<string, string> {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
      Accept: 'application/json',
      'X-API-Key': this.apiKey,
      'X-Project-ID': this.projectId,
      ...customHeaders,
    };
    if (this.authToken) {
      headers['Authorization'] = `Bearer ${this.authToken}`;
    }
    return headers;
  }

  public async request<T = any>(
    method: string,
    endpoint: string,
    options: {
      body?: any;
      headers?: Record<string, string>;
    } = {}
  ): Promise<T> {
    const url = this.buildUrl(endpoint);
    const headers = this.getHeaders(options.headers);

    const init: RequestInit = {
      method: method.toUpperCase(),
      headers,
    };

    if (options.body !== undefined) {
      init.body = typeof options.body === 'string' ? options.body : JSON.stringify(options.body);
    }

    let response: Response;
    try {
      response = await fetch(url, init);
    } catch (err: any) {
      throw new BaasError(`Network error: ${err?.message || 'Failed to fetch'}`);
    }

    let json: any;
    try {
      json = await response.json();
    } catch {
      json = { message: await response.text() };
    }

    if (response.ok) {
      return json;
    }

    const message = json?.message || `Request failed with status ${response.status}`;

    switch (response.status) {
      case 401:
        throw new BaasAuthError(message, 401, json);
      case 403:
        throw new BaasPermissionError(message, 403, json);
      case 404:
        throw new BaasNotFoundError(message, 404, json);
      case 429:
        throw new BaasQuotaError(message, 429, json);
      default:
        throw new BaasError(message, response.status, json);
    }
  }

  public collection<T = Record<string, any>>(name: string): BaasCollectionReference<T> {
    return this.database.collection<T>(name);
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\client.ts" -Encoding utf8`
Ran command: `@'
import { BaasClient } from './client';
import { BaasUser, BaasAuthResponse } from './types';

export class BaasAuth {
  private client: BaasClient;
  private currentUser: BaasUser | null = null;
  private listeners: Array<(user: BaasUser | null) => void> = [];

  constructor(client: BaasClient) {
    this.client = client;
  }

  public getCurrentUser(): BaasUser | null {
    return this.currentUser;
  }

  public isAuthenticated(): boolean {
    return !!this.client.getAuthToken();
  }

  public onAuthStateChange(callback: (user: BaasUser | null) => void): () => void {
    this.listeners.push(callback);
    callback(this.currentUser);
    return () => {
      this.listeners = this.listeners.filter((l) => l !== callback);
    };
  }

  private notifyListeners(): void {
    for (const listener of this.listeners) {
      try {
        listener(this.currentUser);
      } catch (err) {
        console.error('Error in onAuthStateChange listener:', err);
      }
    }
  }

  public async signUpWithEmail(
    email: string,
    password: string,
    displayName?: string,
    metadata?: Record<string, any>
  ): Promise<BaasAuthResponse> {
    const res = await this.client.request('POST', 'auth/register', {
      body: {
        email,
        password,
        display_name: displayName,
        metadata,
      },
    });

    const data = res.data || {};
    if (data.token) {
      this.client.setAuthToken(data.token);
    }

    this.currentUser = data.user || data;
    this.notifyListeners();
    return data;
  }

  public async signInWithEmail(email: string, password: string): Promise<BaasAuthResponse> {
    const res = await this.client.request('POST', 'auth/login', {
      body: { email, password },
    });

    const data = res.data || {};
    if (data.token) {
      this.client.setAuthToken(data.token);
    }

    this.currentUser = data.user || data;
    this.notifyListeners();
    return data;
  }

  public async sendPhoneOtp(phoneNumber: string): Promise<{ otp_token: string; message: string }> {
    const res = await this.client.request('POST', 'auth/otp/send', {
      body: { phone_number: phoneNumber },
    });
    return res.data || { message: res.message };
  }

  public async verifyPhoneOtp(
    phoneNumber: string,
    code: string,
    token: string
  ): Promise<BaasAuthResponse> {
    const res = await this.client.request('POST', 'auth/otp/verify', {
      body: {
        phone_number: phoneNumber,
        code,
        token,
      },
    });

    const data = res.data || {};
    if (data.token) {
      this.client.setAuthToken(data.token);
    }

    this.currentUser = data.user || data;
    this.notifyListeners();
    return data;
  }

  public async signInAnonymously(deviceId?: string): Promise<BaasAuthResponse> {
    const res = await this.client.request('POST', 'auth/anonymous', {
      body: { device_id: deviceId },
    });

    const data = res.data || {};
    if (data.token) {
      this.client.setAuthToken(data.token);
    }

    this.currentUser = data.user || data;
    this.notifyListeners();
    return data;
  }

  public async refreshToken(refreshToken?: string): Promise<string> {
    const res = await this.client.request('POST', 'auth/refresh', {
      body: { refresh_token: refreshToken },
    });

    const data = res.data || {};
    const token = data.token;
    if (token) {
      this.client.setAuthToken(token);
    }
    return token;
  }

  public async getProfile(): Promise<BaasUser> {
    const res = await this.client.request('GET', 'auth/me');
    this.currentUser = res.data;
    this.notifyListeners();
    return res.data;
  }

  public signOut(): void {
    this.client.setAuthToken(null);
    this.currentUser = null;
    this.notifyListeners();
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\auth.ts" -Encoding utf8`
Ran command: `@'
import { BaasClient } from './client';
import {
  BaasDocument,
  QueryFilter,
  QueryOperator,
  BatchOperation,
} from './types';

export class BaasDatabase {
  private client: BaasClient;

  constructor(client: BaasClient) {
    this.client = client;
  }

  public collection<T = Record<string, any>>(name: string): BaasCollectionReference<T> {
    return new BaasCollectionReference<T>(this.client, name);
  }

  public batch(): BaasWriteBatch {
    return new BaasWriteBatch(this.client);
  }
}

export class BaasQuery<T = Record<string, any>> {
  protected client: BaasClient;
  public collectionName: string;
  protected filters: QueryFilter[] = [];
  protected orderByField: string | null = null;
  protected orderDir: 'asc' | 'desc' = 'asc';
  protected limitCount?: number;
  protected pageNumber?: number;

  constructor(client: BaasClient, collectionName: string) {
    this.client = client;
    this.collectionName = collectionName;
  }

  public where(field: string, operator: QueryOperator, value: any): BaasQuery<T> {
    const q = this.clone();
    q.filters.push({ field, operator, value });
    return q;
  }

  public orderBy(field: string, direction: 'asc' | 'desc' = 'asc'): BaasQuery<T> {
    const q = this.clone();
    q.orderByField = field;
    q.orderDir = direction;
    return q;
  }

  public limit(count: number): BaasQuery<T> {
    const q = this.clone();
    q.limitCount = count;
    return q;
  }

  public page(num: number): BaasQuery<T> {
    const q = this.clone();
    q.pageNumber = num;
    return q;
  }

  protected clone(): BaasQuery<T> {
    const copy = new BaasQuery<T>(this.client, this.collectionName);
    copy.filters = [...this.filters];
    copy.orderByField = this.orderByField;
    copy.orderDir = this.orderDir;
    copy.limitCount = this.limitCount;
    copy.pageNumber = this.pageNumber;
    return copy;
  }

  public async get(): Promise<BaasDocument<T>[]> {
    const payload: Record<string, any> = {
      filters: this.filters,
      order_dir: this.orderDir,
    };
    if (this.orderByField) payload.order_by = this.orderByField;
    if (this.limitCount !== undefined) payload.limit = this.limitCount;
    if (this.pageNumber !== undefined) payload.page = this.pageNumber;

    const res = await this.client.request(
      'POST',
      `collections/${this.collectionName}/query`,
      { body: payload }
    );

    const items: any[] = Array.isArray(res.data) ? res.data : [];
    return items.map((item) => {
      const docData = item.data !== undefined ? item.data : item;
      return {
        id: item.document_id || item.id,
        document_id: item.document_id || item.id,
        data: docData,
        created_at: item.created_at,
        updated_at: item.updated_at,
      };
    });
  }
}

export class BaasCollectionReference<T = Record<string, any>> extends BaasQuery<T> {
  constructor(client: BaasClient, collectionName: string) {
    super(client, collectionName);
  }

  public doc(documentId?: string): BaasDocumentReference<T> {
    return new BaasDocumentReference<T>(this.client, this.collectionName, documentId);
  }

  public async add(data: T): Promise<BaasDocumentReference<T>> {
    const res = await this.client.request(
      'POST',
      `collections/${this.collectionName}/documents`,
      { body: { data } }
    );

    const docId = res.data?.document_id || res.data?.id;
    return this.doc(docId);
  }
}

export class BaasDocumentReference<T = Record<string, any>> {
  private client: BaasClient;
  public collectionName: string;
  public id: string;

  constructor(client: BaasClient, collectionName: string, documentId?: string) {
    this.client = client;
    this.collectionName = collectionName;
    this.id = documentId || '';
  }

  public async get(): Promise<BaasDocument<T>> {
    if (!this.id) {
      throw new Error('Document ID is required for get().');
    }

    const res = await this.client.request(
      'GET',
      `collections/${this.collectionName}/documents/${this.id}`
    );

    const item = res.data || {};
    return {
      id: item.document_id || item.id || this.id,
      document_id: item.document_id || item.id || this.id,
      data: item.data !== undefined ? item.data : item,
      created_at: item.created_at,
      updated_at: item.updated_at,
    };
  }

  public async set(data: Partial<T>, options: { merge?: boolean } = {}): Promise<void> {
    if (!this.id) {
      throw new Error('Document ID is required for set(). Use collection.add() for auto IDs.');
    }

    await this.client.request(
      'PUT',
      `collections/${this.collectionName}/documents/${this.id}`,
      {
        body: {
          data,
          merge: !!options.merge,
        },
      }
    );
  }

  public async update(data: Partial<T>): Promise<void> {
    if (!this.id) {
      throw new Error('Document ID is required for update().');
    }

    await this.client.request(
      'PATCH',
      `collections/${this.collectionName}/documents/${this.id}`,
      { body: data }
    );
  }

  public async delete(): Promise<boolean> {
    if (!this.id) {
      throw new Error('Document ID is required for delete().');
    }

    const res = await this.client.request(
      'DELETE',
      `collections/${this.collectionName}/documents/${this.id}`
    );
    return res.success === true;
  }
}

export class BaasWriteBatch {
  private client: BaasClient;
  private operations: BatchOperation[] = [];

  constructor(client: BaasClient) {
    this.client = client;
  }

  public set(
    doc: BaasDocumentReference<any>,
    data: Record<string, any>,
    options: { merge?: boolean } = {}
  ): this {
    this.operations.push({
      type: 'set',
      collection: doc.collectionName,
      document_id: doc.id,
      data,
      merge: !!options.merge,
    });
    return this;
  }

  public update(doc: BaasDocumentReference<any>, data: Record<string, any>): this {
    this.operations.push({
      type: 'update',
      collection: doc.collectionName,
      document_id: doc.id,
      data,
    });
    return this;
  }

  public delete(doc: BaasDocumentReference<any>): this {
    this.operations.push({
      type: 'delete',
      collection: doc.collectionName,
      document_id: doc.id,
    });
    return this;
  }

  public async commit(): Promise<any> {
    return await this.client.request('POST', 'batch', {
      body: { operations: this.operations },
    });
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\database.ts" -Encoding utf8`
Ran command: `@'
import { BaasClient } from './client';
import { BaasFileMetadata } from './types';
import { BaasError } from './errors';

export class BaasStorage {
  private client: BaasClient;

  constructor(client: BaasClient) {
    this.client = client;
  }

  public async upload(
    path: string,
    file: Blob | File | any,
    options: {
      filename?: string;
      isPublic?: boolean;
    } = {}
  ): Promise<BaasFileMetadata> {
    const formData = new FormData();
    formData.append('path', path);
    formData.append('visibility', options.isPublic === false ? 'private' : 'public');

    if (options.filename) {
      formData.append('file', file, options.filename);
    } else {
      formData.append('file', file);
    }

    const url = this.client.buildUrl('storage/upload');
    const headers: Record<string, string> = {
      'X-API-Key': this.client.apiKey,
      'X-Project-ID': this.client.projectId,
      Accept: 'application/json',
    };

    const token = this.client.getAuthToken();
    if (token) {
      headers['Authorization'] = `Bearer ${token}`;
    }

    let response: Response;
    try {
      response = await fetch(url, {
        method: 'POST',
        headers,
        body: formData,
      });
    } catch (err: any) {
      throw new BaasError(`File upload network error: ${err?.message}`);
    }

    const json = await response.json();
    if (!response.ok) {
      throw new BaasError(json?.message || 'Storage upload failed', response.status, json);
    }

    return json.data;
  }

  public async listFiles(path?: string, limit = 50): Promise<BaasFileMetadata[]> {
    const res = await this.client.request('GET', 'storage/files');
    return Array.isArray(res.data) ? res.data : [];
  }

  public async getSignedUrl(path: string, expiresInMinutes = 60): Promise<string> {
    const res = await this.client.request('POST', 'storage/signed-url', {
      body: {
        path,
        expires_in: expiresInMinutes,
      },
    });
    return res.data?.signed_url || res.data?.url || '';
  }

  public async deleteFile(path: string): Promise<boolean> {
    const res = await this.client.request('DELETE', 'storage/files', {
      body: { path },
    });
    return res.success === true;
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\storage.ts" -Encoding utf8`
Ran command: `@'
import { BaasClient } from './client';

export class BaasNotifications {
  private client: BaasClient;

  constructor(client: BaasClient) {
    this.client = client;
  }

  public async registerDeviceToken(
    token: string,
    platform: 'web' | 'android' | 'ios' = 'web',
    topics: string[] = []
  ): Promise<void> {
    await this.client.request('POST', 'notifications/devices', {
      body: {
        token,
        platform,
        topics,
      },
    });
  }

  public async send(params: {
    userId?: string;
    topic?: string;
    title: string;
    body: string;
    data?: Record<string, any>;
  }): Promise<{ success: boolean; data?: any }> {
    const res = await this.client.request('POST', 'notifications/send', {
      body: {
        user_id: params.userId,
        topic: params.topic,
        title: params.title,
        body: params.body,
        data: params.data || {},
      },
    });
    return res.data ? { success: true, data: res.data } : { success: true };
  }
}
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\notifications.ts" -Encoding utf8`
Ran command: `@'
import { BaasClient } from './client';
import { BaasConfig } from './types';

/**
 * Initialize a new CamSchool BaaS Client instance.
 */
export function createClient(config: BaasConfig): BaasClient {
  return new BaasClient(config);
}

export { BaasClient };
export * from './types';
export * from './errors';
export * from './auth';
export * from './database';
export * from './storage';
export * from './notifications';

export default createClient;
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\src\index.ts" -Encoding utf8`
Ran command: `@'
# 🌐 CamSchool BaaS — Guide Complet & Documentation Officielle du SDK JavaScript / TypeScript

> **Package :** `@camschool/baas-js`  
> **Version :** `1.0.0`  
> **Environnements supportés :** Navigateurs Web (Chrome, Safari, Firefox, Edge), Node.js (16+), React, Next.js, Vue 3, Svelte, Angular, React Native, Electron.

---

## 1. 📖 Présentation du BaaS CamSchool

Le SDK JavaScript / TypeScript de **CamSchool BaaS** offre une interface fluide et moderne de type Firebase / Supabase pour communiquer avec votre backend Laravel.

### 🌟 Fonctionnalités Clés :
* **Base de données NoSQL (Firestore-like)** : Gestion complète de collections et documents JSON dynamiques, filtres complexes (`where`), tri, pagination et écritures atomiques par lots (*Batch writes*).
* **Système d'Authentification Complet** :
  * 📧 Inscription & Connexion par Email / Mot de passe.
  * 📱 Authentification par Numéro de Téléphone & OTP SMS.
  * 🕶️ Mode Invité (Connexion anonyme).
  * 💾 Sauvegarde et restauration automatique du Token JWT dans `localStorage`.
  * 🔔 Écouteur réactif des changements d'état (`onAuthStateChange`).
* **Cloud Storage** : Upload direct de fichiers (`File`, `Blob`, `Buffer`), récupération d'URLs signées temporaires.
* **Notifications Push** : Enregistrement de tokens d'appareils et déclenchement d'alertes ciblées.
* **Typage TypeScript Exhaustif** : IntelliSense complet avec types génériques pour vos modèles de données.

---

## 2. 📦 Installation & Intégration

### Option A : Installation via NPM / Yarn / PNPM
```bash
npm install @camschool/baas-js
# ou
yarn add @camschool/baas-js
# ou
pnpm add @camschool/baas-js
```

### Option B : Utilisation directe via script CDN (Sans bundler / HTML pur)
```html
<script type="module">
  import { createClient } from 'https://cdn.jsdelivr.net/npm/@camschool/baas-js/+esm';
  
  const baas = createClient({
    baseUrl: 'https://api.votre-domaine.cm',
    projectId: 'votre_project_id',
    apiKey: 'baas_pub_xxxxxxxxxxxxxxxxxxxx',
  });
</script>
```

---

## 3. ⚙️ Initialisation du Client

Dans votre projet (ex: `src/lib/baas.ts` ou `baas.js`) :

```typescript
import { createClient } from '@camschool/baas-js';

export const baas = createClient({
  baseUrl: 'https://api.votre-domaine.cm', // URL racine de votre backend BaaS
  projectId: 'mon-projet-camschool',       // Identifiant de votre projet
  apiKey: 'baas_pub_9a8b7c6d5e4f3a2b1c',   // Clé API publique de votre projet
  autoRestoreSession: true,               // Restauration automatique du token au rafraîchissement
});
```

---

## 4. 🔐 Authentification des Utilisateurs

### 4.1 Inscription par Email & Mot de passe
```typescript
try {
  const result = await baas.auth.signUpWithEmail(
    'jean.dupont@camschool.cm',
    'MotDePasseSecurise123!',
    'Jean Dupont',
    { role: 'enseignant', matiere: 'Physique' }
  );

  console.log('Utilisateur inscrit :', result.user);
  console.log('Token JWT actif :', result.token);
} catch (error: any) {
  console.error('Erreur d\'inscription :', error.message);
}
```

### 4.2 Connexion par Email & Mot de passe
```typescript
try {
  const { user, token } = await baas.auth.signInWithEmail(
    'jean.dupont@camschool.cm',
    'MotDePasseSecurise123!'
  );
  console.log('Connecté avec succès :', user.displayName);
} catch (error: any) {
  console.error('Identifiants incorrects :', error.message);
}
```

### 4.3 Connexion par Numéro de Téléphone & OTP SMS (Idéal Cameroun)
```typescript
// 1. Demander l'envoi du SMS avec le code OTP
const { otp_token } = await baas.auth.sendPhoneOtp('+237695512390');

// 2. Vérifier le code saisi par l'utilisateur
try {
  const { user } = await baas.auth.verifyPhoneOtp(
    '+237695512390',
    '482910', // Code à 6 chiffres reçu
    otp_token
  );
  console.log('Authentifié par téléphone :', user.phoneNumber);
} catch (error: any) {
  console.error('Code OTP invalide ou expiré :', error.message);
}
```

### 4.4 Connexion Anonyme (Invité)
```typescript
const { user } = await baas.auth.signInAnonymously();
console.log('Compte invité créé :', user.id);
```

### 4.5 Écouteur Réactif de Changement d'État (`onAuthStateChange`)
Idéal pour mettre à jour vos composants UI automatiquement :

```typescript
const unsubscribe = baas.auth.onAuthStateChange((user) => {
  if (user) {
    console.log('Utilisateur actuellement connecté :', user.displayName || user.email);
  } else {
    console.log('Aucun utilisateur connecté (mode déconnecté).');
  }
});

// Pour arrêter d'écouter :
// unsubscribe();
```

### 4.6 Déconnexion
```typescript
baas.auth.signOut();
```

---

## 5. 🗄️ Base de Données NoSQL (Firestore-like)

### 5.1 Ajouter un nouveau document avec ID automatique (`add`)
```typescript
interface Course {
  title: string;
  teacher: string;
  level: string;
  coefficient: number;
  published: boolean;
}

const docRef = await baas.collection<Course>('courses').add({
  title: 'Informatique & Algorithmique',
  teacher: 'Professeur Ndongo',
  level: 'Terminale TI',
  coefficient: 5,
  published: true,
});

console.log('Document créé avec ID généré :', docRef.id);
```

### 5.2 Créer ou écraser un document avec ID spécifique (`set`)
```typescript
await baas.collection('profiles').doc('user_12345').set({
  bio: 'Développeur Fullstack & Flutter',
  skills: ['TypeScript', 'Laravel', 'Flutter'],
  last_login: new Date().toISOString(),
}, { merge: true }); // merge: true préserve les champs existants
```

### 5.3 Mettre à jour des champs précis (`update`)
```typescript
await baas.collection('courses').doc('math-101').update({
  coefficient: 6,
  is_verified: true,
});
```

### 5.4 Lire un document unique (`get`)
```typescript
try {
  const doc = await baas.collection('courses').doc('math-101').get();
  console.log('Titre du cours :', doc.data.title);
  console.log('Date de création :', doc.created_at);
} catch (error: any) {
  if (error.name === 'BaasNotFoundError') {
    console.log('Ce document n\'existe pas.');
  }
}
```

### 5.5 Supprimer un document (`delete`)
```typescript
await baas.collection('courses').doc('math-101').delete();
```

### 5.6 Requêtes Avancées (Filtres `where`, Tri & Pagination)
```typescript
const courses = await baas
  .collection('courses')
  .where('level', '==', 'Terminale TI')
  .where('coefficient', '>=', 4)
  .where('category', 'in', ['Sciences', 'Technologie'])
  .orderBy('coefficient', 'desc')
  .limit(10)
  .page(1)
  .get();

courses.forEach((doc) => {
  console.log(`[${doc.id}] ${doc.data.title} — Coeff: ${doc.data.coefficient}`);
});
```

#### Opérateurs de filtrage supportés :
* `==` ou `=` (Égalité)
* `!=` (Différence)
* `>` (Strictement supérieur)
* `>=` (Supérieur ou égal)
* `<` (Strictement inférieur)
* `<=` (Inférieur ou égal)
* `in` (Appartient à la liste de valeurs)
* `not_in` (N'appartient pas à la liste)
* `contains` ou `array_contains` (Contient la sous-chaîne ou l'élément)

### 5.7 Écritures Atomiques par Lots (*Batch Writes*)
```typescript
const batch = baas.database.batch();

const doc1 = baas.collection('stats').doc('global');
const doc2 = baas.collection('logs').doc('log_999');

batch.update(doc1, { active_users: 1540 });
batch.set(doc2, { action: 'user_login', timestamp: Date.now() });

await batch.commit();
console.log('Lot d\'écritures validé en une seule transaction !');
```

---

## 6. 📁 Stockage de Fichiers (Cloud Storage)

### 6.1 Upload de Fichier depuis un input HTML (`<input type="file">`)
```typescript
const fileInput = document.querySelector<HTMLInputElement>('#myFileInput')!;
const file = fileInput.files![0];

try {
  const fileData = await baas.storage.upload(`cours/devoirs/${file.name}`, file, {
    isPublic: true,
  });

  console.log('Fichier téléversé avec succès ! URL publique :', fileData.url);
} catch (error: any) {
  console.error('Échec de l\'upload :', error.message);
}
```

### 6.2 Générer une URL Signée Temporaire (Fichier Privé Sécurisé)
```typescript
const signedUrl = await baas.storage.getSignedUrl('documents/bulletin_secret.pdf', 15);
console.log('Lien valable pendant 15 minutes :', signedUrl);
```

### 6.3 Supprimer un fichier
```typescript
await baas.storage.deleteFile('cours/devoirs/exercice.pdf');
```

---

## 7. 🔔 Notifications Push

### 7.1 Enregistrer le token de notification de l'appareil
```typescript
await baas.notifications.registerDeviceToken(
  'fcm_device_token_xxxxxxxxxxxxxx',
  'web',
  ['tous_les_eleves', 'terminale_c']
);
```

### 7.2 Envoyer une notification ciblée
```typescript
await baas.notifications.send({
  topic: 'terminale_c',
  title: 'Devoir de Mathématiques',
  body: 'La correction du DS N°2 est maintenant disponible en ligne.',
  data: { page: '/devoirs/ds-2' },
});
```

---

## 8. 🛡️ Gestion des Erreurs Typées

```typescript
import {
  BaasAuthError,
  BaasPermissionError,
  BaasNotFoundError,
  BaasQuotaError,
  BaasError,
} from '@camschool/baas-js';

try {
  await baas.collection('finances').doc('compte_principal').get();
} catch (err: any) {
  if (err instanceof BaasPermissionError) {
    // 403 : Règle de sécurité enfreinte
    alert('Accès refusé par les règles de sécurité.');
  } else if (err instanceof BaasNotFoundError) {
    // 404 : Non trouvé
    console.warn('Document introuvable.');
  } else if (err instanceof BaasAuthError) {
    // 401 : Session expirée
    baas.auth.signOut();
  } else if (err instanceof BaasQuotaError) {
    // 429 : Quotas de requêtes dépassés
    console.error('Quota d\'API atteint pour ce projet.');
  } else {
    console.error('Erreur inattendue :', err.message);
  }
}
```

---

## 9. ⚛️ Exemple d'Intégration dans React / Next.js

```tsx
import React, { useEffect, useState } from 'react';
import { createClient, BaasDocument } from '@camschool/baas-js';

const baas = createClient({
  baseUrl: 'https://api.votre-domaine.cm',
  projectId: 'camschool_demo',
  apiKey: 'baas_pub_xxxxxx',
});

export default function CoursesList() {
  const [courses, setCourses] = useState<BaasDocument[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadCourses();
  }, []);

  async function loadCourses() {
    try {
      const data = await baas
        .collection('courses')
        .orderBy('created_at', 'desc')
        .limit(20)
        .get();
      setCourses(data);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function handleAdd() {
    const title = prompt('Titre du cours :');
    if (!title) return;

    await baas.collection('courses').add({
      title,
      created_at: new Date().toISOString(),
    });
    loadCourses();
  }

  if (loading) return <div>Chargement des cours...</div>;

  return (
    <div style={{ padding: 20 }}>
      <h1>Liste des Cours (CamSchool BaaS)</h1>
      <button onClick={handleAdd}>+ Ajouter un cours</button>

      <ul>
        {courses.map((c) => (
          <li key={c.id}>
            <strong>{c.data.title}</strong> (ID: {c.id})
          </li>
        ))}
      </ul>
    </div>
  );
}
```

---

## 10. 🏆 Bonnes Pratiques & Sécurité

1. **Clé API Publique (`apiKey`)** : Vous pouvez exposer sans risque votre `apiKey` publique dans votre frontend JavaScript.
2. **Ne jamais exposer la `secret_key`** dans un environnement client/navigateur. Réservez la `secret_key` à vos scripts serveurs ou cron jobs backend.
3. **Configurez vos `Security Rules`** dans l'espace d'administration CamSchool BaaS pour sécuriser les accès par utilisateur (`auth.id == doc.user_id`).
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\doc.md" -Encoding utf8`
Ran command: `@'
# @camschool/baas-js

Official Universal JavaScript / TypeScript SDK for **CamSchool BaaS** (Backend-as-a-Service).

## Features
- 🔥 Firestore-like NoSQL JSON document store with queries, ordering and batch writes
- 📱 Phone OTP SMS, Email/Password and Anonymous Authentication
- 💾 Cloud Storage with file upload, public and signed URLs
- 🔔 Push Notifications registration and dispatch
- 🔒 Security Rules evaluation, JWT session persistence & reactive auth listeners

## Documentation
Please check [doc.md](./doc.md) for full documentation, installation guide, and code examples for Web, React, Vue, Node.js and React Native.
'@ | Out-File -FilePath "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\README.md" -Encoding utf8`
Ran command: `Copy-Item -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_flutter\doc.md" -Destination "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\SDK\Flutter\doc.md" ; Copy-Item -Path "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages\camschool_baas_js\doc.md" -Destination "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\app\BaaS\SDK\Js\doc.md"`
Ran command: `Get-ChildItem "C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api\packages" -Recurse | Select-Object FullName`

# 💋 Étude & Analyse Exhaustive du Système BaaS CamSchool

J'ai étudié en détail l'architecture du système **BaaS (Backend-as-a-Service)** situé dans :  
`C:\laragon\www\CamShool\camschool_mobile_last_version\camschoolapifinal\laravel_version_of_camschool_api`

---

## 1. 🔍 Ce que contient votre système BaaS Laravel

Votre système BaaS est une infrastructure autonome et complète (façon **Firebase** ou **Supabase**) intégrée dans Laravel, multi-tenant et sécurisée :

```
app/BaaS/
├── Auth/           # Authentification Email, SMS OTP (passerelle locale), Session Anonyme
├── Database/       # Base NoSQL dynamique (JSON documents / Collections Firestore-like)
├── Storage/        # Téléversement de fichiers, URLs publiques & URLs signées temporaires
├── Notifications/  # Notifications Push (FCM / APNs) avec gestion de Topics
├── Security/       # Moteur d'évaluation des règles de sécurité (Security Rules)
├── Usage/          # Suivi des métriques & Quotas par projet
├── Billing/        # Facturation & passerelles de paiement (MTN / Orange Money / etc.)
├── Webhooks/       # Déclenchement d'événements HTTP externes
└── Http/           # Contrôleurs API REST v1 & Middlewares (API Key, Quotas, User JWT)
```

### Les 4 Piliers Clés de l'API REST v1 :
1. **`auth/`** : Inscription/connexion email, envoi & vérification de codes SMS OTP, connexion anonyme invité, rafraîchissement JWT.
2. **`collections/{collection}/...`** : Création dynamique de collections, filtres avancés (`where`, `in`, `contains`), tri, pagination et écritures par lots atomiques (*Batch writes*).
3. **`storage/...`** : Upload multipart, fichiers publics/privés, URLs signées sécurisées.
4. **`notifications/...`** : Enregistrement des tokens d'appareils et envoi de push ciblés.

---

## 2. ❓ Faut-il des packages / SDKs pour l'intégrer ?

**Oui, absolument !**  
Bien qu'il soit techniquement possible de faire des appels `http` ou `fetch` manuels, l'utilisation de **packages SDK dédiés** est indispensable en production pour :
* Gérer automatiquement les en-têtes obligatoires (`X-API-Key`, `X-Project-ID`, `Authorization: Bearer <JWT>`).
* Offrir une syntaxe fluide et intuitive de type Firestore :  
  `baas.collection('courses').where('level', '==', 'Terminale').get()`
* Gérer la **persistance automatique du Token JWT** (`SharedPreferences` en Flutter, `localStorage` en JS).
* Typage complet des requêtes, gestion des erreurs fines (`BaasAuthException`, `BaasPermissionDeniedException`, `BaasNotFoundException`).

---

## 3. 📦 Packages Créés & Prêts à l'Emploi

J'ai structuré et généré **2 packages complets et autonomes**, chacun doté de son code source, de son fichier de configuration (`pubspec.yaml` / `package.json`) et de son fichier **`doc.md` exhaustif** :

```
laravel_version_of_camschool_api/
└── packages/
    ├── camschool_baas_flutter/        # 📱 Package Flutter / Dart
    │   ├── pubspec.yaml
    │   ├── README.md
    │   ├── doc.md                     # 📖 Documentation complète Flutter
    │   └── lib/
    │       ├── camschool_baas_flutter.dart
    │       └── src/
    │           ├── client.dart        # Singleton BaaS & Session
    │           ├── auth.dart          # Email, OTP SMS, Anonymous
    │           ├── database.dart      # Firestore-like Collections & Queries
    │           ├── storage.dart       # Upload & URLs signées
    │           ├── notifications.dart  # Tokens FCM & Push
    │           ├── models.dart        # BaasUser, BaasDocumentSnapshot, etc.
    │           └── exceptions.dart    # Erreurs typées (401, 403, 404, 429)
    │
    └── camschool_baas_js/             # 🌐 Package JavaScript / TypeScript (Web, React, Vue, Node.js)
        ├── package.json
        ├── tsconfig.json
        ├── README.md
        ├── doc.md                     # 📖 Documentation complète JS / TS
        └── src/
            ├── index.ts               # createClient()
            ├── client.ts              # BaasClient universel
            ├── auth.ts                # Gestion d'authentification
            ├── database.ts            # Collections, Queries & Batch writes
            ├── storage.ts             # Cloud Storage & Upload
            ├── notifications.ts       # Push notifications
            ├── types.ts               # Interfaces TypeScript
            └── errors.ts              # Classes d'erreurs
```

*(Une copie synchronisée des documentations et codes a également été placée dans `app/BaaS/SDK/Flutter/doc.md` et `app/BaaS/SDK/Js/doc.md`).*

---

## 4. 📱 Résumé d'Intégration Flutter (`camschool_baas_flutter`)

### 1. Déclaration dans `pubspec.yaml`
```yaml
dependencies:
  flutter:
    sdk: flutter
  camschool_baas_flutter:
    path: ../laravel_version_of_camschool_api/packages/camschool_baas_flutter
```

### 2. Initialisation dans `main.dart`
```dart
import 'package:flutter/material.dart';
import 'package:camschool_baas_flutter/camschool_baas_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BaaS.initialize(
    baseUrl: 'https://votre-domaine.cm',
    projectId: 'votre_project_id',
    apiKey: 'baas_pub_xxxxxxxxxxxxxxxx',
    autoRestoreSession: true, // Restauration auto de la session
  );

  runApp(const MyApp());
}
```

### 3. Exemples d'Utilisation en Flutter

#### 🔐 Authentification par Téléphone & OTP SMS (Idéal Cameroun / MTN / Orange) :
```dart
// 1. Envoi de l'OTP
final res = await BaaS.instance.auth.sendPhoneOtp(phoneNumber: '+237695512390');
final otpToken = res['otp_token'];

// 2. Vérification du code
final user = await BaaS.instance.auth.verifyPhoneOtp(
  phoneNumber: '+237695512390',
  code: '482910',
  token: otpToken,
);
```

#### 🗄️ Requêtes NoSQL Firestore-like :
```dart
// Ajouter un document
final docRef = await BaaS.instance.collection('courses').add({
  'title': 'Mathématiques Terminale C',
  'teacher': 'M. Kamdem',
  'coefficient': 5,
});

// Requête filtrée avec tri et pagination
final results = await BaaS.instance
    .collection('courses')
    .whereEqualTo('level', 'Terminale')
    .whereGreaterThanOrEqualTo('coefficient', 4)
    .orderBy('coefficient', descending: true)
    .limit(20)
    .get();

for (final doc in results) {
  print('Cours : ${doc.get('title')} (ID: ${doc.id})');
}
```

#### 📁 Upload de Fichiers (Storage) :
```dart
final fileInfo = await BaaS.instance.storage.uploadBytes(
  path: 'avatars/user_123.jpg',
  bytes: imageBytes,
  filename: 'avatar.jpg',
  isPublic: true,
);
print('URL : ${fileInfo.url}');
```

---

## 5. 🌐 Résumé d'Intégration JavaScript / TypeScript (`@camschool/baas-js`)

### 1. Installation & Import
```bash
npm install ./camschool_baas_js
```

```typescript
import { createClient } from '@camschool/baas-js';

const baas = createClient({
  baseUrl: 'https://votre-domaine.cm',
  projectId: 'mon_projet',
  apiKey: 'baas_pub_xxxxxxxxxxxxxxxx',
});
```

### 2. Exemples d'Utilisation en JS / React / Vue / Node.js

#### 🔐 Connexion & Écouteur d'État :
```typescript
await baas.auth.signInWithEmail('etudiant@camschool.cm', 'SecretPassword!');

// Écoute réactive de la session
baas.auth.onAuthStateChange((user) => {
  console.log('Utilisateur actuel :', user?.displayName);
});
```

#### 🗄️ Requêtes NoSQL & Écritures par Lots :
```typescript
// Requête avancée
const courses = await baas
  .collection('courses')
  .where('coefficient', '>=', 4)
  .orderBy('coefficient', 'desc')
  .limit(10)
  .get();

// Batch write atomique
const batch = baas.database.batch();
batch.set(baas.collection('stats').doc('today'), { active_users: 250 });
batch.update(baas.collection('courses').doc('math-101'), { published: true });
await batch.commit();
```

---

## 6. 📄 Où consulter les documentations détaillées ?

Les fichiers de documentation complète sont disponibles aux chemins suivants :
* **Doc Flutter** : `packages\camschool_baas_flutter\doc.md`
* **Doc JavaScript / TypeScript** : `packages\camschool_baas_js\doc.md`