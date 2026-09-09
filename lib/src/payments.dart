import 'dart:async';
import 'client.dart';

/// Statut d'une transaction BaaS
enum BaasTransactionStatus { pending, processing, success, failed, cancelled }

/// Moyen de paiement supporté
class BaasPaymentMethod {
  final String code;
  final String name;
  final String description;
  final String category;
  final String currency;
  final double payinFeePercent;
  final double payoutFeePercent;
  final double minAmount;
  final double maxAmount;
  final bool isActive;
  final bool allowPayin;
  final bool allowPayout;
  final String? iconUrl;

  BaasPaymentMethod({
    required this.code,
    required this.name,
    required this.description,
    required this.category,
    required this.currency,
    required this.payinFeePercent,
    required this.payoutFeePercent,
    required this.minAmount,
    required this.maxAmount,
    required this.isActive,
    required this.allowPayin,
    required this.allowPayout,
    this.iconUrl,
  });

  factory BaasPaymentMethod.fromMap(Map<String, dynamic> map) {
    return BaasPaymentMethod(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'mobile_money',
      currency: map['currency'] ?? 'XAF',
      payinFeePercent: (map['payin_fee_percent'] as num?)?.toDouble() ?? 7.0,
      payoutFeePercent: (map['payout_fee_percent'] as num?)?.toDouble() ?? 0.0,
      minAmount: (map['min_amount'] as num?)?.toDouble() ?? 100.0,
      maxAmount: (map['max_amount'] as num?)?.toDouble() ?? 5000000.0,
      isActive: map['is_active'] == true || map['is_active'] == 1,
      allowPayin: map['allow_payin'] == true || map['allow_payin'] == 1,
      allowPayout: map['allow_payout'] == true || map['allow_payout'] == 1,
      iconUrl: map['icon_url'],
    );
  }
}

/// Transaction de Paiement ou Retrait BaaS
class BaasTransaction {
  final dynamic id;
  final String reference;
  final String? externalReference;
  final String type; // payin, payout
  final String paymentMethod;
  final double grossAmount;
  final double feeRate;
  final double feeAmount;
  final double netAmount;
  final String currency;
  final String status;
  final String? phone;
  final String? customerName;
  final String? customerEmail;
  final String? description;
  final String? paymentUrl;
  final DateTime? paidAt;
  final DateTime createdAt;

  BaasTransaction({
    required this.id,
    required this.reference,
    this.externalReference,
    required this.type,
    required this.paymentMethod,
    required this.grossAmount,
    required this.feeRate,
    required this.feeAmount,
    required this.netAmount,
    required this.currency,
    required this.status,
    this.phone,
    this.customerName,
    this.customerEmail,
    this.description,
    this.paymentUrl,
    this.paidAt,
    required this.createdAt,
  });

  bool get isSuccessful => status == 'success' || status == 'completed';
  bool get isPending => status == 'pending' || status == 'processing';
  bool get isFailed => status == 'failed' || status == 'cancelled';

  factory BaasTransaction.fromMap(Map<String, dynamic> map) {
    return BaasTransaction(
      id: map['id'],
      reference: map['reference'] ?? '',
      externalReference: map['external_reference'],
      type: map['type'] ?? 'payin',
      paymentMethod: map['payment_method'] ?? 'MTN_MOMO',
      grossAmount: (map['gross_amount'] as num?)?.toDouble() ?? 0.0,
      feeRate: (map['fee_rate'] as num?)?.toDouble() ?? 7.0,
      feeAmount: (map['fee_amount'] as num?)?.toDouble() ?? 0.0,
      netAmount: (map['net_amount'] as num?)?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'XAF',
      status: map['status'] ?? 'pending',
      phone: map['phone'],
      customerName: map['customer_name'],
      customerEmail: map['customer_email'],
      description: map['description'],
      paymentUrl: map['payment_url'],
      paidAt: map['paid_at'] != null ? DateTime.tryParse(map['paid_at'].toString()) : null,
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now() : DateTime.now(),
    );
  }
}

/// Résultat d'une initiation PayIn
class BaasPayinResult {
  final bool success;
  final dynamic transactionId;
  final String reference;
  final String status;
  final double grossAmount;
  final double feeRate;
  final double feeAmount;
  final double netAmount;
  final String currency;
  final String paymentMethod;
  final String? paymentUrl;
  final String? ussdPrompt;
  final String message;

  BaasPayinResult({
    required this.success,
    required this.transactionId,
    required this.reference,
    required this.status,
    required this.grossAmount,
    required this.feeRate,
    required this.feeAmount,
    required this.netAmount,
    required this.currency,
    required this.paymentMethod,
    this.paymentUrl,
    this.ussdPrompt,
    required this.message,
  });

  factory BaasPayinResult.fromMap(Map<String, dynamic> map) {
    return BaasPayinResult(
      success: map['success'] == true,
      transactionId: map['transaction_id'],
      reference: map['reference'] ?? '',
      status: map['status'] ?? 'pending',
      grossAmount: (map['gross_amount'] as num?)?.toDouble() ?? 0.0,
      feeRate: (map['fee_rate'] as num?)?.toDouble() ?? 7.0,
      feeAmount: (map['fee_amount'] as num?)?.toDouble() ?? 0.0,
      netAmount: (map['net_amount'] as num?)?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'XAF',
      paymentMethod: map['payment_method'] ?? 'MTN_MOMO',
      paymentUrl: map['payment_url'],
      ussdPrompt: map['ussd_prompt'],
      message: map['message'] ?? 'Paiement initié',
    );
  }
}

/// Résultat d'une initiation PayOut (Retrait)
class BaasPayoutResult {
  final bool success;
  final dynamic payoutId;
  final String reference;
  final String status;
  final double grossAmount;
  final double feeRate;
  final double feeAmount;
  final double netAmount;
  final String currency;
  final String paymentMethod;
  final String? phone;
  final String message;

  BaasPayoutResult({
    required this.success,
    required this.payoutId,
    required this.reference,
    required this.status,
    required this.grossAmount,
    required this.feeRate,
    required this.feeAmount,
    required this.netAmount,
    required this.currency,
    required this.paymentMethod,
    this.phone,
    required this.message,
  });

  factory BaasPayoutResult.fromMap(Map<String, dynamic> map) {
    return BaasPayoutResult(
      success: map['success'] == true,
      payoutId: map['payout_id'],
      reference: map['reference'] ?? '',
      status: map['status'] ?? 'processing',
      grossAmount: (map['gross_amount'] as num?)?.toDouble() ?? 0.0,
      feeRate: (map['fee_rate'] as num?)?.toDouble() ?? 0.0,
      feeAmount: (map['fee_amount'] as num?)?.toDouble() ?? 0.0,
      netAmount: (map['net_amount'] as num?)?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'XAF',
      paymentMethod: map['payment_method'] ?? 'MTN_MOMO',
      phone: map['phone'],
      message: map['message'] ?? 'Retrait en cours de traitement',
    );
  }
}

/// Module de Paiements & Retraits CamSchool BaaS
class BaasPayments {
  final BaaS _client;

  BaasPayments(this._client);

  /// Récupérer les moyens de paiement actifs et les pourcentages de frais (7% PayIn / 0% PayOut par défaut)
  Future<List<BaasPaymentMethod>> getPaymentMethods() async {
    final res = await _client.request('GET', 'payments/methods');
    final rawList = res['data'] is List ? res['data'] as List : [];
    return rawList.map((item) => BaasPaymentMethod.fromMap(item)).toList();
  }

  /// Initier un Paiement / Encaissement (PayIn) - Commission 7% (configurable)
  Future<BaasPayinResult> initiatePayin({
    required double amount,
    required String paymentMethod, // 'MTN_MOMO', 'ORANGE_MONEY', 'CARD', 'EU_MOBILE'
    String? phone,
    String? customerName,
    String? customerEmail,
    String? description,
    String? currency = 'XAF',
    String? callbackUrl,
    String? returnUrl,
    Map<String, dynamic>? metadata,
  }) async {
    final payload = {
      'amount': amount,
      'payment_method': paymentMethod,
      'phone': phone,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'description': description,
      'currency': currency,
      'callback_url': callbackUrl,
      'return_url': returnUrl,
      'metadata': metadata,
    };

    final res = await _client.request('POST', 'payments/payin', body: payload);
    final data = res['data'] is Map<String, dynamic> ? res['data'] : res;
    return BaasPayinResult.fromMap(data);
  }

  /// Initier un Retrait / Décaissement (PayOut) - Commission 0% (Gratuit)
  Future<BaasPayoutResult> initiatePayout({
    required double amount,
    required String paymentMethod, // 'MTN_MOMO', 'ORANGE_MONEY', 'EU_MOBILE'
    required String phone,
    String? beneficiaryName,
    String? description,
    String? currency = 'XAF',
    String? callbackUrl,
    Map<String, dynamic>? metadata,
  }) async {
    final payload = {
      'amount': amount,
      'payment_method': paymentMethod,
      'phone': phone,
      'beneficiary_name': beneficiaryName,
      'description': description,
      'currency': currency,
      'callback_url': callbackUrl,
      'metadata': metadata,
    };

    final res = await _client.request('POST', 'payments/payout', body: payload);
    final data = res['data'] is Map<String, dynamic> ? res['data'] : res;
    return BaasPayoutResult.fromMap(data);
  }

  /// Vérifier le statut en temps réel d'une transaction (Paiement ou Retrait)
  Future<BaasTransaction> getTransactionStatus(String transactionIdOrReference) async {
    final res = await _client.request('GET', 'payments/status/$transactionIdOrReference');
    final data = res['data'] is Map<String, dynamic> ? res['data'] : res;
    return BaasTransaction.fromMap(data);
  }

  /// Lister l'historique des transactions
  Future<List<BaasTransaction>> listTransactions({
    String? type, // 'payin' ou 'payout'
    String? status, // 'success', 'pending', 'failed'
    String? paymentMethod,
    int limit = 20,
  }) async {
    final queryParams = <String, dynamic>{
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      'limit': limit,
    };

    final res = await _client.request('GET', 'payments/transactions', queryParams: queryParams);
    final rawList = res['data'] is List ? res['data'] as List : [];
    return rawList.map((item) => BaasTransaction.fromMap(item)).toList();
  }

  /// Polling automatique d'une transaction jusqu'à validation finale
  Stream<BaasTransaction> pollTransactionStatus(
    String transactionIdOrRef, {
    Duration interval = const Duration(seconds: 3),
    Duration timeout = const Duration(minutes: 5),
  }) async* {
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < timeout) {
      final tx = await getTransactionStatus(transactionIdOrRef);
      yield tx;
      if (!tx.isPending) {
        break;
      }
      await Future.delayed(interval);
    }
  }
}
