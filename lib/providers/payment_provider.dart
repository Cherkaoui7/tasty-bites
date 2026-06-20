import 'package:flutter/material.dart';
import '../models/payment_method.dart';

class PaymentProvider extends ChangeNotifier {
  final List<PaymentMethod> _methods = [
    const PaymentMethod(id: 'p1', title: 'Apple Pay', subtitle: 'Connected', icon: Icons.apple, isDefault: true),
    const PaymentMethod(id: 'p2', title: 'Visa ending in 4242', subtitle: 'Expires 12/28', icon: Icons.credit_card, isDefault: false),
    const PaymentMethod(id: 'p3', title: 'Mastercard ending in 8899', subtitle: 'Expires 08/26', icon: Icons.credit_card, isDefault: false),
  ];

  List<PaymentMethod> get methods => _methods;

  void setDefault(String id) {
    for (int i = 0; i < _methods.length; i++) {
      _methods[i] = _methods[i].copyWith(isDefault: _methods[i].id == id);
    }
    notifyListeners();
  }

  void addMethod(PaymentMethod method) {
    _methods.add(method);
    notifyListeners();
  }
}
