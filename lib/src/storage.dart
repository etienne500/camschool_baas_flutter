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
