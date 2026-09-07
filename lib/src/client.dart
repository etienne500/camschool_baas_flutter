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
