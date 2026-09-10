import 'client.dart';
import 'models.dart';

/// SMS Module for CamSchool BaaS (Billing: 25 FCFA / SMS)
class BaasSms {
  final BaaS _client;

  BaasSms(this._client);

  /// Send single or multiple SMS messages.
  /// Billing: 25 FCFA / SMS.
  ///
  /// [to] can be a single phone number (e.g. '+237655797860') or a List of phone numbers.
  /// [message] is the text content.
  /// [senderId] is an optional alphanumeric sender ID (max 11 chars).
  Future<BaasSmsResponse> send({
    required dynamic to,
    required String message,
    String? senderId,
    Map<String, dynamic>? options,
  }) async {
    final body = {
      'to': to,
      'message': message,
      if (senderId != null) 'sender_id': senderId,
      if (options != null) 'options': options,
    };

    final res = await _client.request('POST', 'sms/send', body: body);
    final data = res is Map && res.containsKey('data') && res['data'] is Map
        ? res['data'] as Map<String, dynamic>
        : (res is Map ? Map<String, dynamic>.from(res) : <String, dynamic>{});

    return BaasSmsResponse.fromMap(data);
  }

  /// Send bulk SMS messages to a list of phone numbers.
  Future<BaasSmsResponse> sendBulk({
    required List<String> recipients,
    required String message,
    String? senderId,
    Map<String, dynamic>? options,
  }) async {
    return send(
      to: recipients,
      message: message,
      senderId: senderId,
      options: options,
    );
  }

  /// Fetch SMS history logs for this project
  Future<Map<String, dynamic>> getLogs({int limit = 20, int page = 1}) async {
    final res = await _client.request('GET', 'sms/logs', queryParams: {
      'limit': limit,
      'page': page,
    });
    return res is Map<String, dynamic> ? res : {'data': res};
  }
}

/// Email Module for CamSchool BaaS
class BaasMail {
  final BaaS _client;

  BaasMail(this._client);

  /// Send a transactional or notification email.
  Future<BaasEmailResponse> send({
    required dynamic to,
    required String subject,
    String? body,
    String? html,
    String? fromName,
    String? fromEmail,
    String? replyTo,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    final payload = {
      'to': to,
      'subject': subject,
      if (body != null) 'body': body,
      if (html != null) 'html': html,
      if (fromName != null) 'from_name': fromName,
      if (fromEmail != null) 'from_email': fromEmail,
      if (replyTo != null) 'reply_to': replyTo,
      if (cc != null) 'cc': cc,
      if (bcc != null) 'bcc': bcc,
    };

    final res = await _client.request('POST', 'mail/send', body: payload);
    final data = res is Map && res.containsKey('data') && res['data'] is Map
        ? res['data'] as Map<String, dynamic>
        : (res is Map ? Map<String, dynamic>.from(res) : <String, dynamic>{});

    return BaasEmailResponse.fromMap(data);
  }

  /// Fetch Email history logs for this project
  Future<Map<String, dynamic>> getLogs({int limit = 20, int page = 1}) async {
    final res = await _client.request('GET', 'mail/logs', queryParams: {
      'limit': limit,
      'page': page,
    });
    return res is Map<String, dynamic> ? res : {'data': res};
  }
}

/// Unified Messaging Module (SMS & Emails)
class BaasMessaging {
  final BaasSms sms;
  final BaasMail mail;

  BaasMessaging(BaaS client)
      : sms = BaasSms(client),
        mail = BaasMail(client);

  Future<BaasSmsResponse> sendSms({
    required dynamic to,
    required String message,
    String? senderId,
  }) =>
      sms.send(to: to, message: message, senderId: senderId);

  Future<BaasEmailResponse> sendEmail({
    required dynamic to,
    required String subject,
    String? body,
    String? html,
    String? fromName,
    String? replyTo,
  }) =>
      mail.send(
        to: to,
        subject: subject,
        body: body,
        html: html,
        fromName: fromName,
        replyTo: replyTo,
      );
}
