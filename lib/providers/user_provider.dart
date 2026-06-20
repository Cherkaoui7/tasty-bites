import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final List<User> _users = [
    User(id: '1', name: 'Alice Smith', email: 'alice@example.com'),
    User(id: '2', name: 'Bob Jones', email: 'bob@example.com'),
    User(id: '3', name: 'Charlie Brown', email: 'charlie@example.com'),
  ];

  List<User> get users => _users;

  void updateUserStatus(String id, UserStatus status) {
    final index = _users.indexWhere((u) => u.id == id);
    if (index != -1) {
      _users[index] = _users[index].copyWith(status: status);
      notifyListeners();
    }
  }
}
