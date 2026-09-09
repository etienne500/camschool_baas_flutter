import 'package:flutter/material.dart';
import '../client.dart';
import '../payments.dart';

/// Modal de Retrait Clé-en-main pour Flutter (MTN MoMo, Orange Money - 0% Frais)
class BaasPayoutModal extends StatefulWidget {
  final double? maxAmount;
  final String currency;
  final String? beneficiaryName;
  final String? initialPhone;
  final String? callbackUrl;
  final Map<String, dynamic>? metadata;
  final Function(BaasPayoutResult result)? onSuccess;
  final Function(String error)? onError;

  const BaasPayoutModal({
    super.key,
    this.maxAmount,
    this.currency = 'XAF',
    this.beneficiaryName,
    this.initialPhone,
    this.callbackUrl,
    this.metadata,
    this.onSuccess,
    this.onError,
  });

  /// Ouvrir le modal de retrait en 1 ligne de code
  static Future<BaasPayoutResult?> show(
    BuildContext context, {
    double? maxAmount,
    String currency = 'XAF',
    String? beneficiaryName,
    String? initialPhone,
    String? callbackUrl,
    Map<String, dynamic>? metadata,
    Function(BaasPayoutResult result)? onSuccess,
    Function(String error)? onError,
  }) {
    return showModalBottomSheet<BaasPayoutResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BaasPayoutModal(
        maxAmount: maxAmount,
        currency: currency,
        beneficiaryName: beneficiaryName,
        initialPhone: initialPhone,
        callbackUrl: callbackUrl,
        metadata: metadata,
        onSuccess: onSuccess,
        onError: onError,
      ),
    );
  }

  @override
  State<BaasPayoutModal> createState() => _BaasPayoutModalState();
}

class _BaasPayoutModalState extends State<BaasPayoutModal> {
  String _selectedMethod = 'MTN_MOMO';
  late TextEditingController _amountController;
  late TextEditingController _phoneController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _phoneController = TextEditingController(text: widget.initialPhone ?? '');
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitPayout() async {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (amount <= 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le montant minimum de retrait est de 100 XAF.')),
      );
      return;
    }

    if (widget.maxAmount != null && amount > widget.maxAmount!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Solde insuffisant. Maximum retirable: ${widget.maxAmount} ${widget.currency}')),
      );
      return;
    }

    final phone = _phoneController.text.trim();
    if (phone.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un numéro de téléphone valide.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final res = await BaaS.instance.payments.initiatePayout(
        amount: amount,
        paymentMethod: _selectedMethod,
        phone: phone,
        beneficiaryName: widget.beneficiaryName,
        currency: widget.currency,
        callbackUrl: widget.callbackUrl,
        metadata: widget.metadata,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      widget.onSuccess?.call(res);
      Navigator.of(context).pop(res);
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        widget.onError?.call(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur retrait: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Demande de Retrait', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('Virement Mobile Money direct (0% frais)', style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(Icons.account_balance_wallet_rounded, color: Colors.greenAccent, size: 28),
              ],
            ),

            const SizedBox(height: 20),

            // Operator selector
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('MTN MoMo'),
                    selected: _selectedMethod == 'MTN_MOMO',
                    selectedColor: const Color(0xFFFFCC00),
                    onSelected: (val) => setState(() => _selectedMethod = 'MTN_MOMO'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Orange Money'),
                    selected: _selectedMethod == 'ORANGE_MONEY',
                    selectedColor: const Color(0xFFFF6600),
                    onSelected: (val) => setState(() => _selectedMethod = 'ORANGE_MONEY'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Montant à retirer (${widget.currency})',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 12),

            // Phone Input
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Numéro de réception (+237)',
                labelStyle: const TextStyle(color: Colors.white70),
                prefixText: '+237 ',
                prefixStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitPayout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isLoading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.black87))
                    : const Text(
                        'Confirmer le Retrait (0% Frais)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
