import 'package:contact_management_app/state/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
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
            // home: const HomeScreen(showFavoritesOnly: false),
          );
        },
      ),
    );
  }
}