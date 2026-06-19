import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/dish.dart';
import '../screens/dish_detail_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = kDishes
        .where((d) =>
            d.name.toLowerCase().contains(_query.toLowerCase()) ||
            d.category.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Text('Full Menu',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${filtered.length} items',
                    style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black45),
                  hintText: 'Search the menu...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) =>
                  _MenuTile(dish: filtered[i], theme: theme),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final Dish dish;
  final ThemeData theme;
  const _MenuTile({required this.dish, required this.theme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => DishDetailScreen(dish: dish)),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(dish.emoji, style: const TextStyle(fontSize: 36)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dish.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(dish.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black54, fontSize: 12)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('\$${dish.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.primary)),
                      const SizedBox(width: 10),
                      const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 16),
                      Text('${dish.rating}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
