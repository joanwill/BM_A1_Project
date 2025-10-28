import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/business/contactcontroller.dart';
import 'package:namer_app/services/contactrepository.dart';

class FakeContactRepository implements ContactRepository {
  @override
  Future<void> sendContactData({
    required String salutation,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String content,
  }) async {}
}

class FakeContactController implements ContactController {
  @override
  ContactRepository repository;
  bool submitted = false;

  FakeContactController() : repository = FakeContactRepository();

  @override
  Future<bool> submitContactForm({
    required String salutation,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String content,
  }) async {
    submitted = true;
    return true;
  }
}

void main() {
  test('submitContactForm sets submitted flag', () async {
    final controller = FakeContactController();
    await controller.submitContactForm(
      salutation: 'Mr.',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      phoneNumber: '1234567890',
      content: 'Hello',
    );
    expect(controller.submitted, isTrue);
  });
}
