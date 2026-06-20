import 'package:flutter/material.dart';

import 'profile_sub_screens/address_screen.dart';
import 'profile_sub_screens/favourites_screen.dart';
import 'profile_sub_screens/help_support_screen.dart';
import 'profile_sub_screens/notifications_screen.dart';
import 'profile_sub_screens/orders_screen.dart';
import 'profile_sub_screens/payment_methods_screen.dart';
import 'profile_sub_screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = <(IconData, String, WidgetBuilder)>[
      (Icons.receipt_long, 'My Orders', (_) => const OrdersScreen()),
      (Icons.favorite_border, 'Favourites', (_) => const FavouritesScreen()),
      (Icons.location_on_outlined, 'Delivery Address', (_) => const AddressScreen()),
      (Icons.payment, 'Payment Methods', (_) => const PaymentMethodsScreen()),
      (Icons.notifications_none, 'Notifications', (_) => const NotificationsScreen()),
      (Icons.help_outline, 'Help & Support', (_) => const HelpSupportScreen()),
      (Icons.settings_outlined, 'Settings', (_) => const SettingsScreen()),
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
                      theme.colorScheme.primary.withValues(alpha: 0.12),
                  child: const Text('😀', style: TextStyle(fontSize: 44)),
                ),
                const SizedBox(height: 12),
                const Text('Alex Johnson',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('alex.johnson@email.com',
                    style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Material(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final item in items)
                  ListTile(
                    leading: Icon(item.$1,
                        color: theme.colorScheme.primary),
                    title: Text(item.$2),
                    trailing: Icon(Icons.chevron_right,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.38)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: item.$3),
                      );
                    },
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
