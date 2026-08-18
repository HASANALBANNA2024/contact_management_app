import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/contact_model.dart';
import '../state/contact_state.dart';
import '../widgets/delete_dialog.dart';
import 'contact_form_screen.dart';
import 'home_screen.dart';

class ContactDetailsScreen extends StatelessWidget {
  final ContactModel contact;
  const ContactDetailsScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleColor = isDark ? Colors.white54 : Colors.black87;
    final subtitleColor = isDark ? Colors.white54 : Colors.grey.shade600;

    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        final currentContact = state.contacts.firstWhere(
          (c) => c.id == contact.id,
          orElse: () => contact,
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            titleSpacing:
                0, // 🎯 ব্যাক বাটনের পর থেকেই যেন টেক্সট পুরো জায়গা পায়
            title: const Text(
              'Contact Details',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              maxLines: 1,
              overflow: TextOverflow
                  .ellipsis, // কোনো কারণে বড় হলে ডট ডট দেখাবে, চিপে যাবে না
            ),
            actions: [
              Theme(
                data: Theme.of(
                  context,
                ).copyWith(actionIconTheme: const ActionIconThemeData()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ❤️ ফেভারিট বাটন
                    IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        currentContact.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: currentContact.isFavorite
                            ? Colors.redAccent
                            : Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        final updatedContact = currentContact.copyWith(
                          isFavorite: !currentContact.isFavorite,
                        );
                        context.read<ContactBloc>().add(
                          UpdateContactEvent(updatedContact),
                        );
                      },
                    ),

                    // 📝 এডিট বাটন
                    IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ContactFormScreen(contact: currentContact),
                          ),
                        );
                      },
                    ),

                    // 🗑️ ডিলিট বাটন
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(
                        8.0,
                        8.0,
                        16.0,
                        8.0,
                      ), // 🎯 ডান পাশে স্ট্যান্ডার্ড গ্যাপ রাখার জন্য
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (dialogContext) => DeleteDialog(
                            contactName: currentContact.name,
                            onDeleteConfirmed: () {
                              context.read<ContactBloc>().add(
                                DeleteContactEvent(currentContact.id!),
                              );

                              Navigator.pop(dialogContext);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(
                                    viewMode: ContactViewMode.all,
                                  ),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      currentContact.name.isNotEmpty
                          ? currentContact.name[0].toUpperCase()
                          : '',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  currentContact.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 24.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        icon: Icons.phone,
                        value: currentContact.phone,
                        label: 'Mobile',
                        titleColor: titleColor,
                        subtitleColor: subtitleColor,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(height: 1, thickness: 0.5),
                      ),
                      _buildInfoRow(
                        icon: Icons.email,
                        value: currentContact.email.isNotEmpty
                            ? currentContact.email
                            : 'No email added',
                        label: 'Email',
                        titleColor: titleColor,
                        subtitleColor: subtitleColor,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(height: 1, thickness: 0.5),
                      ),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        value: currentContact.address.isNotEmpty
                            ? currentContact.address
                            : 'No address added',
                        label: 'Address',
                        titleColor: titleColor,
                        subtitleColor: subtitleColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String value,
    required String label,
    required Color titleColor,
    required Color subtitleColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 28),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 3),
              Text(label, style: TextStyle(color: subtitleColor, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}
