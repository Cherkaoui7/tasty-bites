import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../models/order.dart';
import '../../providers/user_provider.dart';
import '../../providers/order_provider.dart';

class AdminUserListTile extends StatelessWidget {
  final User user;
  final bool isPending;

  const AdminUserListTile({super.key, required this.user, required this.isPending});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          child: Text(user.name[0].toUpperCase(), style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            const SizedBox(height: 8),
            Text(
              'Status: ${user.status.name.toUpperCase()}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: user.status == UserStatus.approved ? Colors.green : (user.status == UserStatus.rejected ? Colors.red : Colors.orange),
              ),
            ),
          ],
        ),
        trailing: isPending
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => context.read<UserProvider>().updateUserStatus(user.id, UserStatus.approved),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => context.read<UserProvider>().updateUserStatus(user.id, UserStatus.rejected),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}

class AdminOrderCard extends StatelessWidget {
  final Order order;
  final bool isPending;

  const AdminOrderCard({super.key, required this.order, required this.isPending});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order #${order.id}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('\$${order.total.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Date: ${order.date}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            const Text('Update Status:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _StatusButton(
                    text: 'Preparing',
                    isActive: order.status == OrderStatus.preparing,
                    onTap: isPending ? () => orderProvider.updateOrderStatus(order.id, OrderStatus.preparing) : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatusButton(
                    text: 'Delivering',
                    isActive: order.status == OrderStatus.delivering,
                    onTap: () => orderProvider.updateOrderStatus(order.id, OrderStatus.delivering),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatusButton(
                    text: 'Confirmed',
                    isActive: order.status == OrderStatus.confirmed,
                    onTap: () => orderProvider.updateOrderStatus(order.id, OrderStatus.confirmed),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const _StatusButton({required this.text, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : theme.colorScheme.surface,
          border: Border.all(color: isActive ? theme.colorScheme.primary : Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
