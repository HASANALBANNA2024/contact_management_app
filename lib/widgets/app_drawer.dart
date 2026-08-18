import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/about_app_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  // 🎯 হোম স্ক্রিনের মোড চেঞ্জ করার জন্য একটা কাস্টম কলব্যাক ফাংশন নিলাম
  final Function(ContactViewMode)? onModeChanged;

  const AppDrawer({
    super.key,
    required this.currentRoute,
    this.onModeChanged, // 🎯 এটাকে কনস্ট্রাক্টরে যুক্ত করলাম
  });

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

          // 🎯 My Contacts (All) বাটন
          _drawerItem(
            icon: Icons.person,
            title: 'My Contacts',
            isSelected: currentRoute == 'all',
            onTap: () {
              Navigator.pop(context); // ড্রেয়ার বন্ধ হবে
              // 🎯 স্ক্রিন রিপ্লেস না করে সরাসরি হোম স্ক্রিনকে বলবো মোড চেঞ্জ করতে
              if (currentRoute != 'all' && onModeChanged != null) {
                onModeChanged!(ContactViewMode.all);
              }
            },
          ),

          // 🎯 Favorites বাটন
          _drawerItem(
            icon: Icons.star,
            title: 'Favorites',
            isSelected: currentRoute == 'favorites',
            onTap: () {
              Navigator.pop(context); // ড্রেয়ার বন্ধ হবে
              // 🎯 স্ক্রিন রিপ্লেস না করে সরাসরি হোম স্ক্রিনকে বলবো মোড চেঞ্জ করতে
              if (currentRoute != 'favorites' && onModeChanged != null) {
                onModeChanged!(ContactViewMode.favorites);
              }
            },
          ),

          _drawerItem(
            icon: Icons.person_add_alt,
            title: 'Add Contact',
            isSelected: false,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add');
            },
          ),
          const Divider(),
          _drawerItem(
            icon: Icons.info_outline,
            title: 'About App',
            isSelected: false,
            onTap: () {
              Navigator.pop(
                context,
              ); // ড্রেয়ার বন্ধ করে তারপর পুশ করা স্ট্যান্ডার্ড
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutAppScreen()),
              );
            },
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
