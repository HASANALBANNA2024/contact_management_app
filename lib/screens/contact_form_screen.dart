import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../models/contact_model.dart';

class ContactFormScreen extends StatefulWidget {
  final ContactModel? contact;
  const ContactFormScreen({super.key, this.contact});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  bool get isEdit => widget.contact != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _addressController = TextEditingController(
      text: widget.contact?.address ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newContact = ContactModel(
        id: widget.contact?.id,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        isFavorite: widget.contact?.isFavorite ?? false,
      );

      if (isEdit) {
        context.read<ContactBloc>().add(UpdateContactEvent(newContact));
      } else {
        context.read<ContactBloc>().add(AddContactEvent(newContact));
      }
      Navigator.pop(
        context,
      ); // কোনো এক্সট্রা রিলোড ছাড়া শুধু ফর্ম স্ক্রিন বন্ধ হবে
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Contact' : 'Add Contact'),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _submit),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.deepPurple.shade50,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.deepPurple,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildField(
                      controller: _nameController,
                      hint: 'Name',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _phoneController,
                      hint: 'Phone Number',
                      icon: Icons.phone_outlined,
                      isPhone: true,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _emailController,
                      hint: 'Email',
                      icon: Icons.mail_outline,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _addressController,
                      hint: 'Address',
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submit,
                child: Text(
                  isEdit ? 'Update Contact' : 'Save Contact',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPhone = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey.shade600),
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : Colors.grey.shade50,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        alignLabelWithHint: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      validator: (v) =>
          v == null || v.trim().isEmpty ? 'Please enter $hint' : null,
    );
  }
}
