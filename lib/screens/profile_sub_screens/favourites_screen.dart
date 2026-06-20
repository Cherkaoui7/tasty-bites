import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favourite_provider.dart';
import '../../widgets/dish_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favourites = context.watch<FavouriteProvider>().favourites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: favourites.isEmpty
          ? Center(
              child: Text(
                'No favourites yet!',
                style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                return DishCard(dish: favourites[index]);
              },
            ),
    );
  }
}
