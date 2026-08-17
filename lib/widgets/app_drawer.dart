import 'package:flutter/material.dart';
import '../screens/about_app_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 24, left: 24),
            color: Colors.deepPurple,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.groups, color: Colors.white, size: 48),
                SizedBox(height: 12),
                Text(
                  'My Contacts',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Manage your friends easily',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _drawerItem(
            icon: Icons.person,
            title: 'My Contacts',
            isSelected: currentRoute == 'all',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'all') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const HomeScreen(viewMode: ContactViewMode.all),
                  ),
                );
              }
            },
          ),
          _drawerItem(
            icon: Icons.star,
            title: 'Favorites',
            isSelected: currentRoute == 'favorites',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'favorites') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const HomeScreen(viewMode: ContactViewMode.favorites),
                  ),
                );
              }
            },
          ),
          _drawerItem(
            icon: Icons.person_add_alt,
            title: 'Add Contact',
            isSelected: false,
            onTap: () {
              Navigator.pop(context);
              /// FAB button Home Screen
              Navigator.pushNamed(context, '/add');
            },
          ),
          const Divider(),
          _drawerItem(
            icon: Icons.info_outline,
            title: 'About App',
            isSelected: false,
            onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutAppScreen()),
            );},
          ),
          _drawerItem(
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
          _drawerItem(
            icon: Icons.logout,
            title: 'Logout',
            isSelected: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.deepPurple : Colors.grey.shade600,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.deepPurple : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.deepPurple.shade50,
      onTap: onTap,
    );
  }
}
