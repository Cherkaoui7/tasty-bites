import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';
import '../../models/order.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final orders = orderProvider.orders;

    if (orders.isEmpty) {
      return const Center(child: Text('No orders yet.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
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
                        onTap: () => orderProvider.updateOrderStatus(order.id, OrderStatus.preparing),
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
      },
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _StatusButton({required this.text, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          border: Border.all(color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
