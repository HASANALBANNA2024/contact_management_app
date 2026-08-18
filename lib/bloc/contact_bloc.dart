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

  /// Load contact handler
  Future<void> _onLoadContacts(
    LoadContactsEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      _allContacts = await DbHelper.instance.getAllContacts();
      emit(state.copyWith(contacts: List.from(_allContacts), isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  /// Add handler
  Future<void> _onAddContact(
    AddContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await DbHelper.instance.insertContact(event.contact);
      _allContacts = await DbHelper.instance.getAllContacts();
      emit(state.copyWith(contacts: List.from(_allContacts)));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to add contact'));
    }
  }

  /// Update handler
  Future<void> _onUpdateContact(
    UpdateContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await DbHelper.instance.updateContact(event.contact);
      _allContacts = await DbHelper.instance.getAllContacts();

      // কারেন্ট লিস্টেও আপডেট করে দেওয়া হলো
      final updatedList = state.contacts
          .map((c) => c.id == event.contact.id ? event.contact : c)
          .toList();
      emit(state.copyWith(contacts: updatedList));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update contact'));
    }
  }

  /// Delete handler
  Future<void> _onDeleteContact(
    DeleteContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await DbHelper.instance.deleteContact(event.id);
      _allContacts.removeWhere((c) => c.id == event.id);
      final updatedList = state.contacts
          .where((c) => c.id != event.id)
          .toList();
      emit(state.copyWith(contacts: updatedList));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete contact'));
    }
  }

  /// 🎯 Favorite Toggle (ইনস্ট্যান্ট স্টেট চেঞ্জ - লিস্ট উধাও হবে না!)
  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      final updatedContact = event.contact.copyWith(
        isFavorite: !event.contact.isFavorite,
      );

      // ১. ডাটাবেজ ব্যাকগ্রাউন্ডে আপডেট হবে
      await DbHelper.instance.updateContact(updatedContact);

      // ২. মাস্টার লিস্ট বা মেমোরি লিস্ট আপডেট
      _allContacts = _allContacts
          .map((c) => c.id == event.contact.id ? updatedContact : c)
          .toList();

      // ৩. কারেন্ট স্ক্রিনে যে লিস্টটা দেখা যাচ্ছে (সার্চ করা থাকলে সার্চসহ) সেটা আপডেট
      final updatedStateList = state.contacts
          .map((c) => c.id == event.contact.id ? updatedContact : c)
          .toList();

      // নতুন স্টেট ইমিট করায় শুধু আইকনটি রি-রেন্ডার হবে
      emit(state.copyWith(contacts: updatedStateList));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update favorite'));
    }
  }

  /// Search handler
  void _onSearchContacts(
    SearchContactsEvent event,
    Emitter<ContactState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(state.copyWith(contacts: List.from(_allContacts)));
    } else {
      final filtered = _allContacts
          .where(
            (contact) =>
                contact.name.toLowerCase().contains(event.query.toLowerCase()),
          )
          .toList();
      emit(state.copyWith(contacts: filtered));
    }
  }

  /// Theme handler
  void _onToggleTheme(ToggleThemeEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(isDarkTheme: event.isDark));
  }
}
