import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/contact_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final bool isFavoriteScreen;

  const ContactTile({
    super.key,
    required this.contact,
    required this.isFavoriteScreen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: colorScheme.primary,
                child: Text(
                  contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '',
                  style: TextStyle(
                    color: isDarkMode ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      contact.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color:
                            theme.textTheme.bodyLarge?.color ??
                            (isDarkMode ? Colors.white : Colors.black87),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.email,
                      style: TextStyle(
                        color:
                            theme.textTheme.bodyMedium?.color ??
                            Colors.grey.shade600,
                        fontSize: 11,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.phone,
                      style: TextStyle(
                        color:
                            theme.textTheme.bodyMedium?.color ??
                            Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 4.0),
                child: isFavoriteScreen
                    ? IconButton(
                        icon: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26,
                        ),
                        onPressed: () {
                          context.read<ContactBloc>().add(
                            ToggleFavoriteEvent(contact),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${contact.name} removed from favorites',
                              ),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: isDarkMode
                            ? Colors.white30
                            : Colors.grey.shade400,
                        size: 14,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
