import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/db_helper.dart';
import '../models/contact_model.dart';
import '../state/contact_state.dart';
import 'contact_event.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  List<ContactModel> _allContacts = [];

  ContactBloc() : super(ContactState.initial()) {
    on<LoadContactsEvent>(_onLoadContacts);
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<SearchContactsEvent>(_onSearchContacts);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  /// load contact handler
  Future<void> _onLoadContacts(LoadContactsEvent event, Emitter<ContactState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      _allContacts = await DbHelper.instance.getAllContacts();
      emit(state.copyWith(contacts: _allContacts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  /// add handler
  Future<void> _onAddContact(AddContactEvent event, Emitter<ContactState> emit) async {
    try {
      await DbHelper.instance.insertContact(event.contact);
      add(LoadContactsEvent());
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to add contact'));
    }
  }

  /// update handler
  Future<void> _onUpdateContact(UpdateContactEvent event, Emitter<ContactState> emit) async {
    try {
      await DbHelper.instance.updateContact(event.contact);
      add(LoadContactsEvent());
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update contact'));
    }
  }

  /// Delete handler
  Future<void> _onDeleteContact(DeleteContactEvent event, Emitter<ContactState> emit) async {
    try {
      await DbHelper.instance.deleteContact(event.id);
      add(LoadContactsEvent());
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete contact'));
    }
  }

  ///favorite toggle
  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<ContactState> emit) async {
    try {
      final updated = event.contact.copyWith(isFavorite: !event.contact.isFavorite);
      await DbHelper.instance.updateContact(updated);
      add(LoadContactsEvent());
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update favorite'));
    }
  }

  /// search handler
  void _onSearchContacts(SearchContactsEvent event, Emitter<ContactState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(contacts: _allContacts));
    } else {
      final filtered = _allContacts
          .where((contact) => contact.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(contacts: filtered));
    }
  }

  /// theme handler
  void _onToggleTheme(ToggleThemeEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(isDarkTheme: event.isDark));
  }
}