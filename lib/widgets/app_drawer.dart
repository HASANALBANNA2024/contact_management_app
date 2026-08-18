import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/about_app_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  final Function(ContactViewMode)? onModeChanged;

  const AppDrawer({super.key, required this.currentRoute, this.onModeChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 24, left: 24),
            color: isDarkMode ? colorScheme.surface : colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.groups,
                  color: isDarkMode ? colorScheme.primary : Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'My Contacts',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Manage your friends easily',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          /// My Contacts (All)
          _drawerItem(
            context: context,
            icon: Icons.person,
            title: 'My Contacts',
            isSelected: currentRoute == 'all',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'all' && onModeChanged != null) {
                onModeChanged!(ContactViewMode.all);
              }
            },
          ),

          /// Favorite Item
          _drawerItem(
            context: context,
            icon: Icons.star,
            title: 'Favorites',
            isSelected: currentRoute == 'favorites',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'favorites' && onModeChanged != null) {
                onModeChanged!(ContactViewMode.favorites);
              }
            },
          ),

          /// add contact item
          _drawerItem(
            context: context,
            icon: Icons.person_add_alt,
            title: 'Add Contact',
            isSelected: false,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add');
            },
          ),
          const Divider(),

          /// About app
          _drawerItem(
            context: context,
            icon: Icons.info_outline,
            title: 'About App',
            isSelected: false,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutAppScreen()),
              );
            },
          ),

          /// Settings
          _drawerItem(
            context: context,
            icon: Icons.settings,
            title: 'Settings',
            isSelected: currentRoute == 'settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),

          /// Logout
          _drawerItem(
            context: context,
            icon: Icons.logout,
            title: 'Logout',
            isSelected: false,
            onTap: () async {
              Navigator.of(context).popUntil((route) => route.isFirst);
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              exit(0);
            },
          ),
        ],
      ),
    );
  }

  /// Drawer item widget
  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? colorScheme.primary
            : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? colorScheme.primary
              : (isDarkMode ? Colors.white : theme.textTheme.bodyLarge?.color),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: isSelected
          ? colorScheme.primary.withValues(alpha: 0.12)
          : null,
      onTap: onTap,
    );
  }
}
