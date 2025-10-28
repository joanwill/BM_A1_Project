import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/controllers/login_controller.dart';

class FakeLoginController implements LoginController {
  @override
  Future<bool> login(String username, String password) async => true;

  @override
  Future<String?> loginGetId(String username, String password) async =>
      'abc123';

  @override
  Future<Map<String, dynamic>?> loginGetIdAdmin(
    String username,
    String password,
  ) async => {'id': 'abc123', 'isAdmin': false};
}

void main() {
  test('loginGetIdAdmin returns expected map', () async {
    final controller = FakeLoginController();
    final result = await controller.loginGetIdAdmin('user', 'pass');
    expect(result, {'id': 'abc123', 'isAdmin': false});
  });
}
