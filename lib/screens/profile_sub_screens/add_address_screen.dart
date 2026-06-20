import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/address.dart';
import '../../providers/address_provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _address = '';
  IconData _icon = Icons.location_on_outlined;

  final List<Map<String, dynamic>> _iconOptions = [
    {'name': 'Home', 'icon': Icons.home_outlined},
    {'name': 'Work', 'icon': Icons.work_outline},
    {'name': 'Other', 'icon': Icons.location_on_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Label', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'e.g. Home, Work, Beach House',
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a label' : null,
              onSaved: (value) => _title = value!,
            ),
            const SizedBox(height: 20),
            const Text('Address', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter full address...',
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter the address' : null,
              onSaved: (value) => _address = value!,
            ),
            const SizedBox(height: 20),
            const Text('Icon', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: _iconOptions.map((option) {
                final isSelected = _icon == option['icon'];
                return ChoiceChip(
                  label: Text(option['name'] as String),
                  avatar: Icon(option['icon'] as IconData, size: 18, color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary),
                  selected: isSelected,
                  selectedColor: theme.colorScheme.primary,
                  labelStyle: TextStyle(color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _icon = option['icon'] as IconData);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AddressProvider>().addAddress(
                      Address(
                        id: DateTime.now().toString(),
                        title: _title,
                        address: _address,
                        icon: _icon,
                      ),
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address saved!')));
                  }
                },
                child: const Text('Save Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
