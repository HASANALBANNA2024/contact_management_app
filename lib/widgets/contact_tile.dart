import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/contact_model.dart';
import '../screens/contact_details_screen.dart';

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
    return Container(
      // দুই পাশের মার্জিন ১৬ থেকে কমিয়ে ১২ করা হলো যাতে কার্ডটি চওড়ায় বড় হয়
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          // দুই পাশের ভেতরের প্যাডিং ১৬ থেকে কমিয়ে ১০ করা হলো যাতে লেখার জন্য সর্বোচ্চ জায়গা পাওয়া যায়
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

          leading: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.deepPurple,
            child: Text(
              contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          title: Text(
            contact.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              // ইমেইল টেক্সট ফুল দেখানোর জন্য সাইজ ছোট করা হলো
              Text(
                contact.email,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11, // সাইজ ছোট করায় বড় ইমেইলও পুরোটা সুন্দরভাবে এঁটে যাবে
                ),
                softWrap: true, // প্রয়োজন হলে ভেঙে পরের লাইনে যাবে, কিন্তু ফুল দেখাবে
              ),
              const SizedBox(height: 2),
              Text(
                contact.phone,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),

          trailing: IconButton(
            // স্টারের ভেতরের প্যাডিং জিরো করা হলো যাতে এটি ডানে চেপে থাকে এবং টেক্সটের জায়গা না নষ্ট করে
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              contact.isFavorite ? Icons.star : Icons.star_border,
              color: contact.isFavorite ? Colors.amber : Colors.grey.shade400,
              size: 26,
            ),
            onPressed: () {
              context.read<ContactBloc>().add(ToggleFavoriteEvent(contact));
            },
          ),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ContactDetailsScreen(contact: contact),
              ),
            );
          },
        ),
      ),
    );
  }
}