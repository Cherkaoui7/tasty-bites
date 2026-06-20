import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/order_provider.dart';
import '../../models/user.dart';
import '../../models/order.dart';
import 'admin_components.dart';

class AdminPendingScreen extends StatelessWidget {
  const AdminPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Pending Users'),
              Tab(text: 'Pending Orders'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _PendingUsersTab(),
                _PendingOrdersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingUsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = context.watch<UserProvider>().users.where((u) => u.status == UserStatus.pending).toList();
    if (users.isEmpty) return const Center(child: Text('No pending users.'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (ctx, i) => AdminUserListTile(user: users[i], isPending: true),
    );
  }
}

class _PendingOrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders.where((o) => o.status == OrderStatus.preparing).toList();
    if (orders.isEmpty) return const Center(child: Text('No pending orders.'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (ctx, i) => AdminOrderCard(order: orders[i], isPending: true),
    );
  }
}
