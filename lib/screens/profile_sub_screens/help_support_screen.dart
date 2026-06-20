import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final faqs = [
      {
        'q': 'How do I track my order?',
        'a': 'You can track your order in real-time by navigating to "My Orders" and tapping on your active order. A map will display the courier\'s location.'
      },
      {
        'q': 'What is the refund policy?',
        'a': 'If your order arrives damaged or is incorrect, you can request a full refund within 2 hours of delivery through the order details page.'
      },
      {
        'q': 'Can I cancel my order?',
        'a': 'Orders can only be cancelled before the restaurant accepts them (usually within 2-3 minutes of placing). Once accepted, cancellation is no longer possible.'
      },
      {
        'q': 'How do I change my delivery address?',
        'a': 'You can change your default delivery address in the "Delivery Address" section of your profile, or select a new one during checkout.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Start Live Chat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          ...faqs.map((faq) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
              ),
              child: ExpansionTile(
                title: Text(
                  faq['q']!,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                iconColor: theme.colorScheme.primary,
                collapsedIconColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq['a']!,
                    style: TextStyle(color: theme.colorScheme.onSurface, height: 1.5),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
