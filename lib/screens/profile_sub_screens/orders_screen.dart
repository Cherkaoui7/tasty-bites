import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';
import '../../models/order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orderProvider = context.watch<OrderProvider>();
    final orders = orderProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'You haven\'t placed any orders yet.',
                style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = orders[index];
                
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${order.id}',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Text(
                            '\$${order.total.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: theme.colorScheme.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.date,
                        style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      _OrderTracker(status: order.status),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _OrderTracker extends StatelessWidget {
  final OrderStatus status;

  const _OrderTracker({required this.status});

  @override
  Widget build(BuildContext context) {
    final isDeliveringOrMore = status == OrderStatus.delivering || status == OrderStatus.confirmed;
    final isConfirmed = status == OrderStatus.confirmed;

    return Column(
      children: [
        Row(
          children: [
            _TrackerStep(icon: Icons.soup_kitchen, isActive: true, isCompleted: isDeliveringOrMore),
            _TrackerLine(isActive: isDeliveringOrMore),
            _TrackerStep(icon: Icons.directions_bike, isActive: isDeliveringOrMore, isCompleted: isConfirmed),
            _TrackerLine(isActive: isConfirmed),
            _TrackerStep(icon: Icons.check_circle, isActive: isConfirmed, isCompleted: false),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _TrackerLabel(text: 'Preparing', isActive: true),
            _TrackerLabel(text: 'Delivering', isActive: isDeliveringOrMore),
            _TrackerLabel(text: 'Confirmed', isActive: isConfirmed),
          ],
        )
      ],
    );
  }
}

class _TrackerStep extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final bool isCompleted;

  const _TrackerStep({required this.icon, required this.isActive, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.2);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCompleted ? theme.colorScheme.primary : (isActive ? theme.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, size: 16, color: isCompleted ? theme.colorScheme.onPrimary : color),
    );
  }
}

class _TrackerLine extends StatelessWidget {
  final bool isActive;
  const _TrackerLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.2),
      ),
    );
  }
}

class _TrackerLabel extends StatelessWidget {
  final String text;
  final bool isActive;

  const _TrackerLabel({required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }
}
