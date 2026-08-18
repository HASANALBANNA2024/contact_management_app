import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // থিমের ওপর ভিত্তি করে টেক্সটের কালার সেট করার জন্য
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
            // 🎯 আইকনের পরিবর্তে আপনার দেওয়া ইমেজ অ্যাসেটটি এখানে যুক্ত করা হলো
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/mobile.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                  // যদি ইমেজটি ট্রান্সপারেন্ট পিএনজি হয় এবং থিমের সাথে কালার ম্যাচ করাতে চান,
                  // তবে নিচের লাইনটি আনকমেন্ট করতে পারেন:
                  // color: Colors.deepPurple,
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

            // অ্যাপের বিবরণ কার্ড
            _buildAboutCard(
              context,
              title: 'Description',
              content:
                  'This is a local Contact Management Application built using Flutter. It helps you save, update, search, and delete your personal contacts securely on your device.',
              textColor: textColor,
            ),
            const SizedBox(height: 16),

            // ব্যবহৃত টেকনোলজি বা ফিচারের কার্ড
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

            // কপিরাইট বা ক্রেডিট টেক্সট
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
        border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
