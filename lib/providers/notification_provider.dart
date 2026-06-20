import 'package:flutter/material.dart';
import '../models/notification_item.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationItem> _notifications = [
    const NotificationItem(id: 'n1', title: 'Order Delivered!', message: 'Your order #10452 has been delivered. Enjoy your meal!', time: '2 hours ago', icon: Icons.check_circle_outline, color: Colors.green),
    const NotificationItem(id: 'n2', title: '20% Off Weekend Promo 🍔', message: 'Use code WEEKEND20 to get 20% off all burgers this weekend.', time: 'Yesterday', icon: Icons.local_offer_outlined, color: Colors.deepOrange),
    const NotificationItem(id: 'n3', title: 'New Restaurant Added', message: 'We just added "Sushi Master" to our list. Check it out now!', time: '3 days ago', icon: Icons.storefront_outlined, color: Colors.orange),
  ];

  List<NotificationItem> get notifications => _notifications;
  
  void clear() {
    _notifications.clear();
    notifyListeners();
  }
}
