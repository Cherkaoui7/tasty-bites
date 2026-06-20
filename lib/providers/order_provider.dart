import 'package:flutter/foundation.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [
    const Order(id: '#10452', date: 'Today, 12:45 PM', total: 24.50, status: 'Delivered'),
    const Order(id: '#10451', date: 'Yesterday, 7:30 PM', total: 18.00, status: 'Delivered'),
  ];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(double total) {
    final newOrder = Order(
      id: '#${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      date: 'Just now',
      total: total,
    );
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
