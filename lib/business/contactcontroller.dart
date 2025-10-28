import 'package:namer_app/services/contactrepository.dart';

class ContactController {
  final ContactRepository repository = ContactRepository();

  /// Sends the contact data to the repository.
  ///
  /// Returns `true` when the data was successfully sent and `false`
  /// otherwise. Errors are caught so the UI can react accordingly.
  Future<bool> submitContactForm({
    required String salutation,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String content,
  }) async {
    try {
      await repository.sendContactData(
        salutation: salutation,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        content: content,
      );
      print('Contact info  sent successfully!');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
