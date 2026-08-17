import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../state/contact_state.dart';
import '../widgets/app_drawer.dart';
import '../widgets/contact_tile.dart';
import 'contact_form_screen.dart';

enum ContactViewMode { all, favorites }

class HomeScreen extends StatefulWidget {
  final ContactViewMode viewMode;
  const HomeScreen({super.key, this.viewMode = ContactViewMode.all});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isFav = widget.viewMode == ContactViewMode.favorites;

    return Scaffold(
      appBar: _isSearching
          ? AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
            context.read<ContactBloc>().add(SearchContactsEvent(''));
          },
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autocorrect: false,
          enableSuggestions: false,
          decoration: const InputDecoration(
            hintText: 'Search contacts...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (query) {
            context.read<ContactBloc>().add(SearchContactsEvent(query));
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<ContactBloc>().add(SearchContactsEvent(''));
              },
            ),
        ],
      )
          : AppBar(
        title: Text(isFav ? 'Favorites' : 'My Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(currentRoute: isFav ? 'favorites' : 'all'),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          }
          final currentContacts = isFav
              ? state.contacts.where((c) => c.isFavorite).toList()
              : state.contacts;
          if (currentContacts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        isFav
                            ? Icons.star_outline
                            : Icons.contact_page_outlined,
                        size: 80,
                        color: Colors.deepPurple.shade200,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      isFav ? 'No favorites yet' : 'No contacts yet',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isFav
                          ? 'Mark important contacts as favorite.'
                          : 'Add your first contact by tapping\nthe + button below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          /// list display
          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 80),
            itemCount: currentContacts.length,
            itemBuilder: (context, index) {
              return ContactTile(
                contact: currentContacts[index],
                isFavoriteScreen: isFav,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactFormScreen()),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}