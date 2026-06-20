import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.users;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              child: Text(user.name[0], style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
            title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.email),
                const SizedBox(height: 8),
                Text(
                  'Status: ${user.status.name.toUpperCase()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: user.status == UserStatus.approved ? Colors.green : (user.status == UserStatus.rejected ? Colors.red : Colors.orange),
                  ),
                ),
              ],
            ),
            trailing: user.status == UserStatus.pending
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          userProvider.updateUserStatus(user.id, UserStatus.approved);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          userProvider.updateUserStatus(user.id, UserStatus.rejected);
                        },
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }
}
