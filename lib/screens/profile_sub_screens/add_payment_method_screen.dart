import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/payment_method.dart';
import '../../providers/payment_provider.dart';
import '../../components/tasty_text_field.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  String _selectedType = 'Card'; // 'Card' or 'PayPal'
  final _formKey = GlobalKey<FormState>();

  String _cardNumber = '';
  String _expiry = '';
  String _paypalEmail = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Payment Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _TypeCard(
                    title: 'Credit Card',
                    icon: Icons.credit_card,
                    isSelected: _selectedType == 'Card',
                    onTap: () => setState(() => _selectedType = 'Card'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _TypeCard(
                    title: 'PayPal',
                    icon: Icons.paypal,
                    isSelected: _selectedType == 'PayPal',
                    onTap: () => setState(() => _selectedType = 'PayPal'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_selectedType == 'Card') ...[
              const Text('Card Number', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 8),
              TastyTextField(
                hint: '0000 0000 0000 0000',
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => _cardNumber = val!,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Expiry Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 8),
                        TastyTextField(
                          hint: 'MM/YY',
                          keyboardType: TextInputType.datetime,
                          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                          onSaved: (val) => _expiry = val!,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CVV', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 8),
                        TastyTextField(
                          hint: '123',
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                          onSaved: (val) {}, // We don't save CVV
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ] else ...[
              const Text('PayPal Email', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 8),
              TastyTextField(
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val == null || !val.contains('@') ? 'Invalid email' : null,
                onSaved: (val) => _paypalEmail = val!,
              ),
            ],
            const SizedBox(height: 40),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _saveMethod,
                child: const Text('Save Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveMethod() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = context.read<PaymentProvider>();
      
      if (_selectedType == 'Card') {
        final last4 = _cardNumber.length >= 4 ? _cardNumber.substring(_cardNumber.length - 4) : _cardNumber;
        provider.addMethod(PaymentMethod(
          id: DateTime.now().toString(),
          title: 'Card ending in $last4',
          subtitle: 'Expires $_expiry',
          icon: Icons.credit_card,
        ));
      } else {
        provider.addMethod(PaymentMethod(
          id: DateTime.now().toString(),
          title: 'PayPal',
          subtitle: _paypalEmail,
          icon: Icons.paypal,
        ));
      }
      
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment method saved!')));
    }
  }
}

class _TypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeCard({required this.title, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
