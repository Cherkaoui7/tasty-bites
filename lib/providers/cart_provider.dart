import 'package:flutter/foundation.dart';
import '../models/dish.dart';

class CartItem {
  final Dish dish;
  int quantity;
  CartItem({required this.dish, this.quantity = 1});

  double get total => dish.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  List<CartItem> get itemList => _items.values.toList();

  int get totalCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.total);

  double get deliveryFee => _items.isEmpty ? 0 : 2.50;

  double get grandTotal => subtotal + deliveryFee;

  int quantityFor(String dishId) => _items[dishId]?.quantity ?? 0;

  void add(Dish dish) {
    if (_items.containsKey(dish.id)) {
      _items[dish.id]!.quantity++;
    } else {
      _items[dish.id] = CartItem(dish: dish);
    }
    notifyListeners();
  }

  void remove(Dish dish) {
    if (!_items.containsKey(dish.id)) return;
    final item = _items[dish.id]!;
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(dish.id);
    }
    notifyListeners();
  }

  void removeAll(Dish dish) {
    _items.remove(dish.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
