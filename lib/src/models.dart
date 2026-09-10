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

/// BaaS SMS Send Detail
class BaasSmsDetail {
  final String to;
  final String status;
  final String? messageId;
  final double cost;
  final String? error;

  BaasSmsDetail({
    required this.to,
    required this.status,
    this.messageId,
    this.cost = 25.0,
    this.error,
  });

  factory BaasSmsDetail.fromMap(Map<String, dynamic> map) {
    final costVal = map['cost'] ?? 25.0;
    return BaasSmsDetail(
      to: (map['to'] ?? '').toString(),
      status: (map['status'] ?? 'sent').toString(),
      messageId: map['message_id']?.toString(),
      cost: costVal is num ? costVal.toDouble() : double.tryParse(costVal.toString()) ?? 25.0,
      error: map['error']?.toString(),
    );
  }
}

/// BaaS SMS Response
class BaasSmsResponse {
  final bool success;
  final int count;
  final int sentCount;
  final int failedCount;
  final double pricePerSms;
  final double totalCost;
  final String currency;
  final List<BaasSmsDetail> details;

  BaasSmsResponse({
    required this.success,
    this.count = 1,
    this.sentCount = 1,
    this.failedCount = 0,
    this.pricePerSms = 25.0,
    this.totalCost = 25.0,
    this.currency = 'XAF',
    this.details = const [],
  });

  factory BaasSmsResponse.fromMap(Map<String, dynamic> map) {
    final rawDetails = map['details'] as List? ?? [];
    final detailsList = rawDetails.map((d) => BaasSmsDetail.fromMap(Map<String, dynamic>.from(d as Map))).toList();

    final priceVal = map['price_per_sms'] ?? 25.0;
    final totalCostVal = map['total_cost'] ?? 25.0;

    return BaasSmsResponse(
      success: map['success'] == true,
      count: (map['count'] is num) ? (map['count'] as num).toInt() : int.tryParse(map['count']?.toString() ?? '1') ?? 1,
      sentCount: (map['sent_count'] is num) ? (map['sent_count'] as num).toInt() : int.tryParse(map['sent_count']?.toString() ?? '1') ?? 1,
      failedCount: (map['failed_count'] is num) ? (map['failed_count'] as num).toInt() : int.tryParse(map['failed_count']?.toString() ?? '0') ?? 0,
      pricePerSms: priceVal is num ? priceVal.toDouble() : double.tryParse(priceVal.toString()) ?? 25.0,
      totalCost: totalCostVal is num ? totalCostVal.toDouble() : double.tryParse(totalCostVal.toString()) ?? 25.0,
      currency: (map['currency'] ?? 'XAF').toString(),
      details: detailsList,
    );
  }
}

/// BaaS Email Send Detail
class BaasEmailDetail {
  final String to;
  final String status;
  final String? error;

  BaasEmailDetail({
    required this.to,
    required this.status,
    this.error,
  });

  factory BaasEmailDetail.fromMap(Map<String, dynamic> map) {
    return BaasEmailDetail(
      to: (map['to'] ?? '').toString(),
      status: (map['status'] ?? 'sent').toString(),
      error: map['error']?.toString(),
    );
  }
}

/// BaaS Email Response
class BaasEmailResponse {
  final bool success;
  final int count;
  final int sentCount;
  final int failedCount;
  final String subject;
  final List<BaasEmailDetail> details;

  BaasEmailResponse({
    required this.success,
    this.count = 1,
    this.sentCount = 1,
    this.failedCount = 0,
    required this.subject,
    this.details = const [],
  });

  factory BaasEmailResponse.fromMap(Map<String, dynamic> map) {
    final rawDetails = map['details'] as List? ?? [];
    final detailsList = rawDetails.map((d) => BaasEmailDetail.fromMap(Map<String, dynamic>.from(d as Map))).toList();

    return BaasEmailResponse(
      success: map['success'] == true,
      count: (map['count'] is num) ? (map['count'] as num).toInt() : int.tryParse(map['count']?.toString() ?? '1') ?? 1,
      sentCount: (map['sent_count'] is num) ? (map['sent_count'] as num).toInt() : int.tryParse(map['sent_count']?.toString() ?? '1') ?? 1,
      failedCount: (map['failed_count'] is num) ? (map['failed_count'] as num).toInt() : int.tryParse(map['failed_count']?.toString() ?? '0') ?? 0,
      subject: (map['subject'] ?? '').toString(),
      details: detailsList,
    );
  }
}