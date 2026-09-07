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
