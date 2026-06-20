import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
    _simulateTracking(order.id);
  }

  void _simulateTracking(String id) {
    Future.delayed(const Duration(seconds: 10), () {
      _updateStatus(id, OrderStatus.delivering);
      Future.delayed(const Duration(seconds: 15), () {
        _updateStatus(id, OrderStatus.confirmed);
      });
    });
  }

  void _updateStatus(String id, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }
}
