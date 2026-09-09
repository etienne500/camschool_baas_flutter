import 'dart:async';
import 'package:flutter/material.dart';
import '../client.dart';
import '../payments.dart';

/// Modal de Paiement Clé-en-main pour Flutter (MTN MoMo, Orange Money, Carte Bancaire)
class BaasPaymentModal extends StatefulWidget {
  final double amount;
  final String currency;
  final String? description;
  final String? customerName;
  final String? customerEmail;
  final String? initialPhone;
  final String? callbackUrl;
  final Map<String, dynamic>? metadata;
  final Function(BaasTransaction transaction)? onSuccess;
  final Function(String error)? onError;
  final VoidCallback? onCancelled;

  const BaasPaymentModal({
    super.key,
    required this.amount,
    this.currency = 'XAF',
    this.description,
    this.customerName,
    this.customerEmail,
    this.initialPhone,
    this.callbackUrl,
    this.metadata,
    this.onSuccess,
    this.onError,
    this.onCancelled,
  });

  /// Ouvrir le modal de paiement en 1 ligne de code
  static Future<BaasTransaction?> show(
    BuildContext context, {
    required double amount,
    String currency = 'XAF',
    String? description,
    String? customerName,
    String? customerEmail,
    String? initialPhone,
    String? callbackUrl,
    Map<String, dynamic>? metadata,
    Function(BaasTransaction transaction)? onSuccess,
    Function(String error)? onError,
    VoidCallback? onCancelled,
  }) {
    return showModalBottomSheet<BaasTransaction>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BaasPaymentModal(
        amount: amount,
        currency: currency,
        description: description,
        customerName: customerName,
        customerEmail: customerEmail,
        initialPhone: initialPhone,
        callbackUrl: callbackUrl,
        metadata: metadata,
        onSuccess: onSuccess,
        onError: onError,
        onCancelled: onCancelled,
      ),
    );
  }

  @override
  State<BaasPaymentModal> createState() => _BaasPaymentModalState();
}

class _BaasPaymentModalState extends State<BaasPaymentModal> {
  String _selectedMethod = 'MTN_MOMO';
  late TextEditingController _phoneController;
  bool _isLoading = false;
  bool _isAwaitingUssd = false;
  String? _ussdPromptMessage;
  String? _currentTxReference;
  StreamSubscription? _pollingSubscription;

  final Map<String, Map<String, dynamic>> _methods = {
    'MTN_MOMO': {
      'name': 'MTN Mobile Money',
      'color': Color(0xFFFFCC00),
      'textColor': Colors.black87,
      'badge': 'MTN MoMo',
      'ussd': '*126#',
      'icon': Icons.phone_android_rounded,
    },
    'ORANGE_MONEY': {
      'name': 'Orange Money',
      'color': Color(0xFFFF6600),
      'textColor': Colors.white,
      'badge': 'Orange Money',
      'ussd': '#150*50#',
      'icon': Icons.smartphone_rounded,
    },
    'CARD': {
      'name': 'Carte VISA / Mastercard',
      'color': Color(0xFF1A1F71),
      'textColor': Colors.white,
      'badge': 'Carte Bancaire',
      'ussd': 'Paiement Web Sécurisé',
      'icon': Icons.credit_card_rounded,
    },
  };

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhone ?? '');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pollingSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startPayment() async {
    final phone = _phoneController.text.trim();
    if (_selectedMethod != 'CARD' && (phone.length < 9)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un numéro de téléphone valide (9 chiffres)')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final res = await BaaS.instance.payments.initiatePayin(
        amount: widget.amount,
        paymentMethod: _selectedMethod,
        phone: phone,
        customerName: widget.customerName,
        customerEmail: widget.customerEmail,
        description: widget.description,
        currency: widget.currency,
        callbackUrl: widget.callbackUrl,
        metadata: widget.metadata,
      );

      _currentTxReference = res.reference;

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _isAwaitingUssd = true;
        _ussdPromptMessage = res.ussdPrompt;
      });

      // Start automatic live polling for completion
      _pollingSubscription = BaaS.instance.payments
          .pollTransactionStatus(res.reference)
          .listen((tx) {
        if (tx.isSuccessful) {
          _pollingSubscription?.cancel();
          if (mounted) {
            widget.onSuccess?.call(tx);
            Navigator.of(context).pop(tx);
          }
        } else if (tx.isFailed) {
          _pollingSubscription?.cancel();
          if (mounted) {
            setState(() {
              _isAwaitingUssd = false;
            });
            widget.onError?.call('Le paiement a été rejeté ou a expiré.');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Échec ou annulation du paiement.')),
            );
          }
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        widget.onError?.call(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final feeAmount = (widget.amount * 0.07).round();
    
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Header with Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paiement Sécurisé',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    Text(
                      '${widget.amount.toStringAsFixed(0)} ${widget.currency}',
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lock, color: Colors.greenAccent, size: 14),
                      SizedBox(width: 4),
                      Text('BaaS Pay 256-bit', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.description != null) ...[
              const SizedBox(height: 6),
              Text(widget.description!, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],

            const SizedBox(height: 20),

            // Method Selector
            const Text(
              'Choisir le mode de paiement :',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 10),
            Row(
              children: _methods.entries.map((entry) {
                final isSelected = _selectedMethod == entry.key;
                final data = entry.value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMethod = entry.key),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? data['color'] : const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.white12,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            data['icon'] as IconData,
                            color: isSelected ? data['textColor'] : Colors.white70,
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['badge'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? data['textColor'] : Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // Phone input (if mobile money)
            if (_selectedMethod != 'CARD') ...[
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone (${_methods[_selectedMethod]?['badge']})',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixText: '+237 ',
                  prefixStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white12),
                  ),
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blueAccent, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Vous serez redirigé vers l\'interface bancaire sécurisée pour finaliser la transaction.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 14),

            // Fee notice
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Frais de traitement BaaS (7%) :', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  Text('$feeAmount ${widget.currency}', style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Awaiting USSD prompt view
            if (_isAwaitingUssd) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFD700)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 3),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Validation sur votre téléphone en cours...',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _ussdPromptMessage ?? 'Veuillez confirmer la notification USSD ou composer le code.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Réf: ${_currentTxReference ?? ''}',
                      style: const TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading || _isAwaitingUssd ? null : _startPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isLoading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.black87))
                    : Text(
                        'Payer ${widget.amount.toStringAsFixed(0)} ${widget.currency}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
