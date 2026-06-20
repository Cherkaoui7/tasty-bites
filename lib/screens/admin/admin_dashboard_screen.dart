import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/order_provider.dart';


class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final orderProvider = context.watch<OrderProvider>();

    final totalUsers = userProvider.users.length;
    final pendingUsers = userProvider.pendingUsersCount;
    
    final totalOrders = orderProvider.orders.length;
    final pendingOrders = orderProvider.pendingOrdersCount;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _StatCard(title: 'Total Users', value: totalUsers.toString(), icon: Icons.people)),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(title: 'Total Orders', value: totalOrders.toString(), icon: Icons.receipt)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _StatCard(title: 'Pending Users', value: pendingUsers.toString(), icon: Icons.person_add_alt, color: Colors.orange)),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(title: 'Pending Orders', value: pendingOrders.toString(), icon: Icons.hourglass_empty, color: Colors.orange)),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatCard({required this.title, required this.value, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: themeColor),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
