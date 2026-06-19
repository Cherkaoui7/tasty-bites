import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../widgets/dish_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedName = kCategories[_selectedCategory].name;
    final dishes = selectedName == 'All'
        ? kDishes
        : kDishes.where((d) => d.category == selectedName).toList();
    final popular = kDishes.where((d) => d.isPopular).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Deliver to',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: theme.colorScheme.primary, size: 18),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: const Text('123 Flavour Street',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.primary
                            .withValues(alpha: 0.12),
                        child: Icon(Icons.notifications_none,
                            color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('What would you\nlike to eat today?',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  // Search bar (visual)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.black45),
                        hintText: 'Search for dishes...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Promo banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Get 30% OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 4),
                              Text('on your first order today',
                                  style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                        Text('🎉', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Categories',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          // Category chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: kCategories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final selected = i == _selectedCategory;
                  final cat = kCategories[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: selected
                            ? theme.colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Text(cat.emoji),
                          const SizedBox(width: 6),
                          Text(cat.name,
                              style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          // Dish grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => DishCard(dish: dishes[i]),
                childCount: dishes.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
