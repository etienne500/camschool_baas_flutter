import 'client.dart';
import 'models.dart';

/// Database Manager (Firestore-like NoSQL with ultra-fast deep multi-table joins & aggregations)
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

    final docData = res['data'] is Map ? Map<String, dynamic>.from(res['data'] as Map) : <String, dynamic>{};
    final docId = (docData['document_id'] ?? docData['id'] ?? '').toString();
    return doc(docId);
  }
}

/// Query Class for filtering, sorting, deep multi-table joins and statistical aggregations
class BaasQuery {
  final BaaS _client;
  final String _collectionName;
  final List<Map<String, dynamic>> _filters = [];
  Map<String, dynamic>? _complexWhere;
  final List<BaasJoin> _joins = [];
  final List<String> _expandPaths = [];
  final List<String> _selectFields = [];
  String? _orderByField;
  String _orderDirection = 'asc';
  int? _limitCount;
  int? _page;

  BaasQuery(this._client, this._collectionName);

  /// Add a standard filter condition (==, !=, >, >=, <, <=, in, not_in, contains, starts_with, etc.)
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
  BaasQuery whereNotIn(String field, List<dynamic> values) => where(field, 'not_in', values);
  BaasQuery whereContains(String field, dynamic value) => where(field, 'contains', value);
  BaasQuery whereStartsWith(String field, String value) => where(field, 'starts_with', value);
  BaasQuery whereEndsWith(String field, String value) => where(field, 'ends_with', value);
  BaasQuery whereLike(String field, String pattern) => where(field, 'like', pattern);

  /// Add a deep recursive multi-table join (supports depth 10+)
  BaasQuery join(BaasJoin joinSpec) {
    final query = _clone();
    query._joins.add(joinSpec);
    return query;
  }

  /// Expand/Populate relations using dot-notation paths (e.g. 'author.company.country.region.continent')
  BaasQuery expand(String path) {
    final query = _clone();
    query._expandPaths.add(path);
    return query;
  }

  /// Expand multiple paths at once
  BaasQuery expandList(List<String> paths) {
    final query = _clone();
    query._expandPaths.addAll(paths);
    return query;
  }

  /// Alias for expand()
  BaasQuery populate(String path) => expand(path);

  /// Select specific fields to return from matching documents
  BaasQuery select(List<String> fields) {
    final query = _clone();
    query._selectFields.addAll(fields);
    return query;
  }

  /// Add an OR condition across multiple branches
  BaasQuery whereOr(List<dynamic> conditions) {
    final query = _clone();
    query._complexWhere ??= {};
    query._complexWhere!['$or'] ??= [];
    (query._complexWhere!['$or'] as List).addAll(conditions);
    return query;
  }

  /// Add an AND condition across multiple branches
  BaasQuery whereAnd(List<dynamic> conditions) {
    final query = _clone();
    query._complexWhere ??= {};
    query._complexWhere!['$and'] ??= [];
    (query._complexWhere!['$and'] as List).addAll(conditions);
    return query;
  }

  /// Pass a complex MongoDB/Firestore-like query tree ($and, $or, $nor, $not, regex, nested fields)
  BaasQuery whereComplex(Map<String, dynamic> tree) {
    final query = _clone();
    query._complexWhere ??= {};
    query._complexWhere!.addAll(tree);
    return query;
  }

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
    if (_complexWhere != null) {
      copy._complexWhere = Map<String, dynamic>.from(_complexWhere!);
    }
    copy._joins.addAll(_joins);
    copy._expandPaths.addAll(_expandPaths);
    copy._selectFields.addAll(_selectFields);
    copy._orderByField = _orderByField;
    copy._orderDirection = _orderDirection;
    copy._limitCount = _limitCount;
    copy._page = _page;
    return copy;
  }

  /// Execute the query and get matching documents with hydrated multi-table joins
  Future<List<BaasDocumentSnapshot>> get() async {
    final payload = <String, dynamic>{
      'order_dir': _orderDirection,
      if (_filters.isNotEmpty) 'filters': _filters,
      if (_complexWhere != null) 'where': _complexWhere,
      if (_joins.isNotEmpty) 'join': _joins.map((j) => j.toMap()).toList(),
      if (_expandPaths.isNotEmpty) 'expand': _expandPaths.join(','),
      if (_selectFields.isNotEmpty) 'select': _selectFields.join(','),
      if (_orderByField != null) 'order_by': _orderByField,
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
              item is Map ? Map<String, dynamic>.from(item) : <String, dynamic>{},
              collection: _collectionName,
            ))
        .toList();
  }

  /// Compute statistical aggregations ($sum, $avg, $min, $max, $count, $groupBy)
  Future<BaasAggregationResult> aggregate(
    Map<String, dynamic> aggregations, {
    String? groupBy,
  }) async {
    final payload = <String, dynamic>{
      'aggregate': aggregations,
      if (groupBy != null) 'groupBy': groupBy,
      if (_filters.isNotEmpty) 'filters': _filters,
      if (_complexWhere != null) 'where': _complexWhere,
    };

    final res = await _client.request(
      'POST',
      'collections/$_collectionName/aggregate',
      body: payload,
    );

    final rawData = res['data'] is Map ? Map<String, dynamic>.from(res['data'] as Map) : <String, dynamic>{};
    return BaasAggregationResult.fromMap(rawData);
  }

  /// Count matching documents
  Future<int> count() async {
    final agg = await aggregate({'total': 'count:id'});
    return agg.count > 0 ? agg.count : (agg.get('total') is num ? (agg.get('total') as num).toInt() : 0);
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

  /// Get the current snapshot of this document with optional multi-table join expansions
  Future<BaasDocumentSnapshot> get({String? expand, List<BaasJoin>? joins}) async {
    if (documentId == null || documentId!.isEmpty) {
      throw ArgumentError('Document ID is required to fetch a document snapshot.');
    }

    final queryParams = <String>[];
    if (expand != null && expand.isNotEmpty) {
      queryParams.add('expand=${Uri.encodeComponent(expand)}');
    }

    final queryStr = queryParams.isNotEmpty ? '?${queryParams.join('&')}' : '';

    final res = await _client.request(
      'GET',
      'collections/$collectionName/documents/$documentId$queryStr',
    );

    final rawData = res['data'] is Map ? Map<String, dynamic>.from(res['data'] as Map) : <String, dynamic>{};
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