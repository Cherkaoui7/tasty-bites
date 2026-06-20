import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/dish.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Dish> _favourites = kDishes.where((d) => d.isPopular).toList();

  List<Dish> get favourites => _favourites;

  bool isFavourite(Dish dish) {
    return _favourites.contains(dish);
  }

  void toggleFavourite(Dish dish) {
    if (_favourites.contains(dish)) {
      _favourites.remove(dish);
    } else {
      _favourites.add(dish);
    }
    notifyListeners();
  }
}
