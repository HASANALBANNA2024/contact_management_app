import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white54 : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.grey.shade600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About App',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/mobile.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Contact Book',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text('v1.0.0', style: TextStyle(fontSize: 14, color: subTextColor)),
            const SizedBox(height: 32),

            _buildAboutCard(
              context,
              title: 'Description',
              content:
                  'This is a local Contact Management Application built using Flutter. It helps you save, update, search, and delete your personal contacts securely on your device.',
              textColor: textColor,
            ),
            const SizedBox(height: 16),

            _buildAboutCard(
              context,
              title: 'Features Included',
              content:
                  '• Full Local CRUD Operations\n'
                  '• Offline SQLite Database (sqflite)\n'
                  '• BLoC State Management\n'
                  '• Real-time Contact Search\n'
                  '• Favorite / Unfavorite Option\n'
                  '• Dynamic Light / Dark Theme Mode',
              textColor: textColor,
            ),
            const SizedBox(height: 40),

            Text(
              'Developed as a Flutter Assignment',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard(
    BuildContext context, {
    required String title,
    required String content,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
          ),
        ],
      ),
    );
  }
}
