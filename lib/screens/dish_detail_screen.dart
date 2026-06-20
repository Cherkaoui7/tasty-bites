import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dish.dart';
import '../providers/cart_provider.dart';
import '../providers/favourite_provider.dart';

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
                          color: theme.colorScheme.primary.withValues(alpha: 0.08),
                          child: Center(
                            child: Text(dish.emoji,
                                style: const TextStyle(fontSize: 120)),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: CircleAvatar(
                            backgroundColor: theme.colorScheme.surface,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: theme.colorScheme.onSurface),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Consumer<FavouriteProvider>(
                            builder: (context, fav, child) {
                              final isFav = fav.isFavourite(dish);
                              return CircleAvatar(
                                backgroundColor: theme.colorScheme.surface,
                                child: IconButton(
                                  icon: Icon(
                                    isFav ? Icons.favorite : Icons.favorite_border,
                                    color: isFav ? Colors.red : theme.colorScheme.onSurface,
                                  ),
                                  onPressed: () => fav.toggleFavourite(dish),
                                ),
                              );
                            },
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
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6), height: 1.5)),
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
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
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
        color: color.withValues(alpha: 0.1),
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
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            size: 20, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
