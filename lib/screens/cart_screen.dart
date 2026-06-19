import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cart = context.watch<CartProvider>();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Text('My Cart',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const Spacer(),
                if (cart.itemList.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => cart.clear(),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Clear'),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent),
                  ),
              ],
            ),
          ),
          if (cart.itemList.isEmpty)
            const Expanded(child: _EmptyCart())
          else ...[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                itemCount: cart.itemList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final item = cart.itemList[i];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(item.dish.emoji,
                                style: const TextStyle(fontSize: 32)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.dish.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('\$${item.dish.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _RoundIcon(
                                icon: Icons.remove,
                                onTap: () => cart.remove(item.dish)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text('${item.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ),
                            _RoundIcon(
                                icon: Icons.add,
                                onTap: () => cart.add(item.dish)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _CheckoutPanel(cart: cart),
          ],
        ],
      ),
    );
  }
}

class _CheckoutPanel extends StatelessWidget {
  final CartProvider cart;
  const _CheckoutPanel({required this.cart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Column(
        children: [
          _row('Subtotal', cart.subtotal),
          const SizedBox(height: 8),
          _row('Delivery fee', cart.deliveryFee),
          const Divider(height: 24),
          _row('Total', cart.grandTotal, bold: true),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: const Text('Order placed! 🎉'),
                    content: Text(
                        'Your order of \$${cart.grandTotal.toStringAsFixed(2)} is on its way.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          cart.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Great!'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Checkout',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    final style = TextStyle(
      fontSize: bold ? 18 : 14,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      color: bold ? Colors.black : Colors.black54,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${value.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon,
            size: 18, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('🛒', style: TextStyle(fontSize: 72)),
        SizedBox(height: 16),
        Text('Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('Add some delicious dishes to get started',
            style: TextStyle(color: Colors.black54)),
      ],
    );
  }
}
