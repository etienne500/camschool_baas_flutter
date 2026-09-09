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
      email: map['email']?.toString(),
      phoneNumber: (map['phone_number'] ?? map['phone'])?.toString(),
      displayName: (map['display_name'] ?? map['name'])?.toString(),
      avatarUrl: (map['avatar_url'] ?? map['photo_url'])?.toString(),
      isAnonymous: map['is_anonymous'] == true,
      metadata: map['metadata'] is Map ? Map<String, dynamic>.from(map['metadata'] as Map) : {},
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
    if (rawData is Map) {
      docData = Map<String, dynamic>.from(rawData);
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
      collection: collection ?? map['collection']?.toString() ?? '',
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
    final urlStr = (map['url'] ?? map['public_url'] ?? map['download_url'] ?? map['signed_url'] ?? '').toString();
    final sizeVal = map['size'] ?? map['size_bytes'] ?? map['file_size'];
    final sizeInt = sizeVal is num ? sizeVal.toInt() : int.tryParse(sizeVal?.toString() ?? '0') ?? 0;

    return BaasFileMetadata(
      id: (map['id'] ?? '').toString(),
      path: map['path']?.toString() ?? '',
      filename: (map['filename'] ?? map['original_name'] ?? map['name'] ?? '')?.toString() ?? '',
      url: urlStr,
      size: sizeInt,
      mimeType: (map['mime_type'] ?? map['mimetype'] ?? map['content_type'])?.toString(),
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'filename': filename,
      'url': url,
      'size': size,
      'mime_type': mimeType,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}