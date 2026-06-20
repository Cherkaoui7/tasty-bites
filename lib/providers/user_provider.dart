import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

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
      return _users.firstWhere((u) => u.email == email && u.password == password);
    } catch (e) {
      return null;
    }
  }
}
