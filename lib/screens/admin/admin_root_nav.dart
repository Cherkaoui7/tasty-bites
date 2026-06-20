import 'package:flutter/material.dart';
import 'admin_users_screen.dart';
import 'admin_orders_screen.dart';
import '../login_screen.dart';

class AdminRootNav extends StatefulWidget {
  const AdminRootNav({super.key});

  @override
  State<AdminRootNav> createState() => _AdminRootNavState();
}

class _AdminRootNavState extends State<AdminRootNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AdminUsersScreen(),
    AdminOrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Users',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
