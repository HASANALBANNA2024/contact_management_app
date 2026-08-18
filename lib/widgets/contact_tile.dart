import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              // 🔴 বাম পাশে গোল অবতার
              CircleAvatar(
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
              const SizedBox(width: 12),

              // 🔴 মাঝখানে নাম, ইমেইল এবং ফোন নম্বর
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.email,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.phone,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // 🎯 ডান পাশ থেকে ফেভারিট বাটন সরিয়ে চমৎকার রাইট অ্যারো আইকন বসানো হলো
              Padding(
                padding: const EdgeInsets.only(right: 6.0, left: 8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 14, // রাইট অ্যারো আইকনের স্ট্যান্ডার্ড সাইজ
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
