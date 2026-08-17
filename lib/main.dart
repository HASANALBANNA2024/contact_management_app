import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'screens/contact_form_screen.dart'; // রাউটের জন্য ফর্ম স্ক্রিনের ইমপোর্ট
import 'screens/splash_screen.dart'; // স্প্ল্যাশ স্ক্রিনের ইমপোর্ট
import 'state/contact_state.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc()..add(LoadContactsEvent()),
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Contact Management App',
            debugShowCheckedModeBanner: false,
            themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            // অ্যাপ ওপেন হলেই সবার আগে ৩ সেকেন্ডের জন্য স্প্ল্যাশ স্ক্রিন দেখাবে
            home: const SplashScreen(),

            // ড্রয়ার থেকে সরাসরি 'Add Contact'-এ যাওয়ার জন্য রাউট সেটআপ
            routes: {'/add': (context) => const ContactFormScreen()},
          );
        },
      ),
    );
  }
}
