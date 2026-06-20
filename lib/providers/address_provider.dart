import 'package:flutter/material.dart';
import '../models/address.dart';

class AddressProvider extends ChangeNotifier {
  final List<Address> _addresses = [
    const Address(id: 'a1', title: 'Home', address: '123 Main Street, Apt 4B, New York, NY 10001', isDefault: true, icon: Icons.home_outlined),
    const Address(id: 'a2', title: 'Work', address: '456 Business Blvd, Suite 200, New York, NY 10005', isDefault: false, icon: Icons.work_outline),
  ];

  List<Address> get addresses => _addresses;

  void setDefault(String id) {
    for (int i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i].copyWith(isDefault: _addresses[i].id == id);
    }
    notifyListeners();
  }

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }
}
