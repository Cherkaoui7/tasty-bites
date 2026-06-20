import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final notifications = [
      {
        'title': 'Order Delivered!',
        'message': 'Your order #10452 has been delivered. Enjoy your meal!',
        'time': '2 hours ago',
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
      },
      {
        'title': '20% Off Weekend Promo 🍔',
        'message': 'Use code WEEKEND20 to get 20% off all burgers this weekend.',
        'time': 'Yesterday',
        'icon': Icons.local_offer_outlined,
        'color': theme.colorScheme.primary,
      },
      {
        'title': 'New Restaurant Added',
        'message': 'We just added "Sushi Master" to our list. Check it out now!',
        'time': '3 days ago',
        'icon': Icons.storefront_outlined,
        'color': Colors.orange,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 32),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (notif['color'] as Color).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  notif['icon'] as IconData,
                  color: notif['color'] as Color,
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
                        Expanded(
                          child: Text(
                            notif['title'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                        Text(
                          notif['time'] as String,
                          style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notif['message'] as String,
                      style: TextStyle(color: theme.colorScheme.onSurface, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
