import '../models/contact_model.dart';

abstract class ContactEvent {}

///all data load
class LoadContactsEvent extends ContactEvent {}

/// new contact add
class AddContactEvent extends ContactEvent {
  final ContactModel contact;
  AddContactEvent(this.contact);
}

/// contact update and edit
class UpdateContactEvent extends ContactEvent {
  final ContactModel contact;
  UpdateContactEvent(this.contact);
}

/// contact delete edit
class DeleteContactEvent extends ContactEvent {
  final int id;
  DeleteContactEvent(this.id);
}

/// favorite toggle
class ToggleFavoriteEvent extends ContactEvent {
  final ContactModel contact;
  ToggleFavoriteEvent(this.contact);
}

/// search event
class SearchContactsEvent extends ContactEvent {
  final String query;
  SearchContactsEvent(this.query);
}

/// theme change event
class ToggleThemeEvent extends ContactEvent {
  final bool isDark;
  ToggleThemeEvent(this.isDark);
}