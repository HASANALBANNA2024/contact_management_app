import '../models/contact_model.dart';

abstract class ContactEvent {}

/// All data load
class LoadContactsEvent extends ContactEvent {}

/// New contact add
class AddContactEvent extends ContactEvent {
  final ContactModel contact;
  AddContactEvent(this.contact);
}

/// Contact update and edit
class UpdateContactEvent extends ContactEvent {
  final ContactModel contact;
  UpdateContactEvent(this.contact);
}

/// Contact delete edit
class DeleteContactEvent extends ContactEvent {
  final int id;
  DeleteContactEvent(this.id);
}

/// Favorite toggle
class ToggleFavoriteEvent extends ContactEvent {
  final ContactModel contact;
  ToggleFavoriteEvent(this.contact);
}

/// Search event
class SearchContactsEvent extends ContactEvent {
  final String query;
  SearchContactsEvent(this.query);
}

/// Theme change event (Clean & Parameter-less)
class ToggleThemeEvent extends ContactEvent {}
