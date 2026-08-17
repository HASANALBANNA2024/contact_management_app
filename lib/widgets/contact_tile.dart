import 'package:contact_management_app/bloc/contact_bloc.dart';
import 'package:contact_management_app/bloc/contact_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_model.dart';
import '../screens/contact_details_screen.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final bool isFavoriteScreen;

  const ContactTile({
    super.key,
    required this.contact,
    this.isFavoriteScreen = false,
  });
  String _getInitials(String name) {
    List<String> names = name.trim().split(' ');
    if (names.length >= 2 && names[0].isNotEmpty && names[1].isNotEmpty) {
      return (names[0][0] + names[1][0]).toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute
                (builder: (_)=> ContactDetailsScreen(contact: contact) ));
        },
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.deepPurple.shade100,
          child: Text(
            _getInitials(contact.name),
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isFavoriteScreen && contact.email.isNotEmpty)
              Text(
                contact.email,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            Text(
              contact.phone,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
        trailing: isFavoriteScreen
            ? IconButton(
                icon: const Icon(Icons.star, color: Colors.amber),
                onPressed: () {
                  context.read<ContactBloc>().add(ToggleFavoriteEvent(contact));
                },
              )
            : Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ),
    );
  }
}
