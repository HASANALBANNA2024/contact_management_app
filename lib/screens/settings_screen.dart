import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../state/contact_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _item(
                title: 'Theme',
                trailingText: state.isDarkTheme ? 'Dark' : 'Light',
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.brightness_6_outlined),
                  title: const Text('Change Theme'),
                  subtitle: Text(
                    state.isDarkTheme ? 'Light / Dark' : 'Light / Dark',
                  ),
                  trailing: Switch(
                    value: state.isDarkTheme,
                    activeColor: Colors.deepPurple,
                    onChanged: (val) {
                      context.read<ContactBloc>().add(ToggleThemeEvent(val));
                    },
                  ),
                ),
              ),
              _item(title: 'About App', hasNavigation: true),
              _item(title: 'Version', trailingText: '1.0.0'),
            ],
          );
        },
      ),
    );
  }

  Widget _item({
    required String title,
    String? trailingText,
    bool hasNavigation = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: trailingText != null
            ? Text(trailingText, style: TextStyle(color: Colors.grey.shade600))
            : (hasNavigation
                  ? const Icon(Icons.chevron_right, color: Colors.grey)
                  : null),
      ),
    );
  }
}
