import 'package:namer_app/services/dog_service.dart';

class LoginController {
  final DogService _repository = DogService();

  Future<bool> login(String username, String password) async {
    return await _repository.authenticateUser(username, password);
  }

  Future<String?> loginGetId(String username, String password) async {
    return await _repository.authenticateUserGetId(username, password);
  }

  Future<Map<String, dynamic>?> loginGetIdAdmin(
    String username,
    String password,
  ) async {
    return await _repository.authenticateUserGetIdAdmin(username, password);
  }
}
