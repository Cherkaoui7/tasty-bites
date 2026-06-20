import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailPromos = false;
  bool _locationServices = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _buildSectionHeader('Preferences'),
          SwitchListTile(
            title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Order updates and alerts', style: TextStyle(fontSize: 12)),
            activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.5),
            activeThumbColor: theme.colorScheme.primary,
            value: _pushNotifications,
            onChanged: (val) => setState(() => _pushNotifications = val),
          ),
          SwitchListTile(
            title: const Text('Promotional Emails', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Weekly offers and discounts', style: TextStyle(fontSize: 12)),
            activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.5),
            activeThumbColor: theme.colorScheme.primary,
            value: _emailPromos,
            onChanged: (val) => setState(() => _emailPromos = val),
          ),
          SwitchListTile(
            title: const Text('Location Services', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('For accurate delivery estimates', style: TextStyle(fontSize: 12)),
            activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.5),
            activeThumbColor: theme.colorScheme.primary,
            value: _locationServices,
            onChanged: (val) => setState(() => _locationServices = val),
          ),
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Switch app theme', style: TextStyle(fontSize: 12)),
            activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.5),
            activeThumbColor: theme.colorScheme.primary,
            value: themeProvider.isDarkMode,
            onChanged: (val) {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(),
          ),
          _buildSectionHeader('Account Management'),
          ListTile(
            title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.38)),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.38)),
            onTap: () {},
          ),
          ListTile(
            title: Text('Delete Account', style: TextStyle(fontWeight: FontWeight.w500, color: theme.colorScheme.error)),
            trailing: Icon(Icons.chevron_right, color: theme.colorScheme.error),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
