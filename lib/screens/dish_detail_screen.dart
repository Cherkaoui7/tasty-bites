import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dish.dart';
import '../providers/cart_provider.dart';

class DishDetailScreen extends StatefulWidget {
  final Dish dish;
  const DishDetailScreen({super.key, required this.dish});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final dish = widget.dish;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 280,
                          width: double.infinity,
                          color: theme.colorScheme.primary.withOpacity(0.08),
                          child: Center(
                            child: Text(dish.emoji,
                                style: const TextStyle(fontSize: 120)),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.black87),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(dish.name,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text('\$${dish.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: theme.colorScheme.primary)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _InfoChip(
                                  icon: Icons.star_rounded,
                                  label: '${dish.rating}',
                                  color: Colors.amber),
                              const SizedBox(width: 10),
                              _InfoChip(
                                  icon: Icons.access_time,
                                  label: '${dish.prepMinutes} min',
                                  color: theme.colorScheme.primary),
                              const SizedBox(width: 10),
                              _InfoChip(
                                  icon: Icons.local_fire_department,
                                  label: dish.category,
                                  color: Colors.deepOrange),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text('Description',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          Text(dish.description,
                              style: const TextStyle(
                                  color: Colors.black54, height: 1.5)),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text('Quantity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              const Spacer(),
                              _QtyButton(
                                  icon: Icons.remove,
                                  onTap: () => setState(() {
                                        if (_qty > 1) _qty--;
                                      })),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                child: Text('$_qty',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              ),
                              _QtyButton(
                                  icon: Icons.add,
                                  onTap: () => setState(() => _qty++)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add to cart bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: SizedBox(
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
                    final cart = context.read<CartProvider>();
                    for (var i = 0; i < _qty; i++) {
                      cart.add(dish);
                    }
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('$_qty × ${dish.name} added to cart'),
                    ));
                  },
                  child: Text(
                      'Add to Cart  •  \$${(dish.price * _qty).toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoChip(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            size: 20, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
