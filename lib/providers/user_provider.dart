import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/auth_utils.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  User? _currentUser;

  List<User> get users => _users;
  User? get currentUser => _currentUser;
  
  int get pendingUsersCount => _users.where((u) => u.status == UserStatus.pending).length;

  UserProvider() {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList('users') ?? [];
    _users = usersJson.map((e) => User.fromJson(json.decode(e) as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = _users.map((u) => json.encode(u.toJson())).toList();
    await prefs.setStringList('users', usersJson);
  }

  Future<void> addUser(User user) async {
    _users.add(user);
    await _saveUsers();
    notifyListeners();
  }

  Future<void> updateUserStatus(String id, UserStatus status) async {
    final index = _users.indexWhere((u) => u.id == id);
    if (index != -1) {
      _users[index] = _users[index].copyWith(status: status);
      await _saveUsers();
      notifyListeners();
    }
  }

  User? loginUser(String email, String password) {
    try {
      if (email == 'admin@tastybites.com' && password == 'admin') {
        const adminUser = User(id: 'admin', name: 'Admin', email: 'admin@tastybites.com', password: '', status: UserStatus.approved);
        _currentUser = adminUser;
        notifyListeners();
        return adminUser;
      }

      final hashed = AuthUtils.hashPassword(password);
      final user = _users.firstWhere((u) => u.email == email && u.password == hashed);
      _currentUser = user;
      notifyListeners();
      return user;
    } catch (e) {
      return null;
    }
  }

  void logoutUser() {
    _currentUser = null;
    notifyListeners();
  }
}
