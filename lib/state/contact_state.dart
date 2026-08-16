import '../models/contact_model.dart';

class ContactState {
  final List<ContactModel> contacts;
  final bool isDarkTheme;
  final bool isLoading;
  final String errorMessage;

  ContactState({
    required this.contacts,
    required this.isDarkTheme,
    required this.isLoading,
    required this.errorMessage,
  });

  factory ContactState.initial() {
    return ContactState(
      contacts: [],
      isDarkTheme: false,
      isLoading: false,
      errorMessage: '',
    );
  }

  ContactState copyWith({
    List<ContactModel>? contacts,
    bool? isDarkTheme,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}