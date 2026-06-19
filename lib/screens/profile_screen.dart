import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = <(IconData, String)>[
      (Icons.receipt_long, 'My Orders'),
      (Icons.favorite_border, 'Favourites'),
      (Icons.location_on_outlined, 'Delivery Address'),
      (Icons.payment, 'Payment Methods'),
      (Icons.notifications_none, 'Notifications'),
      (Icons.help_outline, 'Help & Support'),
      (Icons.settings_outlined, 'Settings'),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor:
                      theme.colorScheme.primary.withOpacity(0.12),
                  child: const Text('😀', style: TextStyle(fontSize: 44)),
                ),
                const SizedBox(height: 12),
                const Text('Alex Johnson',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                const Text('alex.johnson@email.com',
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                for (final item in items)
                  ListTile(
                    leading: Icon(item.$1,
                        color: theme.colorScheme.primary),
                    title: Text(item.$2),
                    trailing: const Icon(Icons.chevron_right,
                        color: Colors.black38),
                    onTap: () {},
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text('Log Out',
                  style: TextStyle(color: Colors.redAccent)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
