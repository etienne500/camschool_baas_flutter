import 'dart:async';
import 'client.dart';
import 'models.dart';

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
