import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final addresses = [
      {'title': 'Home', 'address': '123 Main Street, Apt 4B, New York, NY 10001', 'isDefault': true, 'icon': Icons.home_outlined},
      {'title': 'Work', 'address': '456 Business Blvd, Suite 200, New York, NY 10005', 'isDefault': false, 'icon': Icons.work_outline},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: theme.colorScheme.primary,
        icon: Icon(Icons.add, color: theme.colorScheme.onPrimary),
        label: Text('Add New Address', style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: addresses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final address = addresses[index];
          final isDefault = address['isDefault'] as bool;
          
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: isDefault ? Border.all(color: theme.colorScheme.primary, width: 1.5) : null,
              boxShadow: [
                if (!isDefault)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    address['icon'] as IconData,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            address['title'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          if (isDefault)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Default',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        address['address'] as String,
                        style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6), height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
