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
