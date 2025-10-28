import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/controllers/register_controller.dart';
import '../mocks/mock_dog_service.dart';

void main() {
  late RegisterController controller;
  late MockDogService mockService;

  setUp(() {
    mockService = MockDogService();
    controller = RegisterController(mockService);
  });

  group('Password Validation', () {
    test('returns null when passwords match', () {
      expect(controller.validatePasswords('abc', 'abc'), null);
    });

    test('returns error when passwords do not match', () {
      expect(
        controller.validatePasswords('abc', 'xyz'),
        'Passwords do not match',
      );
    });
  });

  group('Tier Resolution', () {
    test('returns Basic for TIER1CODE', () {
      expect(controller.resolveTier('TIER1CODE'), 'Basic');
    });

    test('returns basic for invalid code', () {
      expect(controller.resolveTier('INVALID'), 'Basic');
    });
  });

  group('User Registration', () {
    test('returns null for invalid tier code', () async {
      final result = await controller.registerUser(
        username: 'test',
        password: '123',
        tierCode: 'INVALID',
      );
      expect(result, null);
    });

    // test('calls DogService.registerUser with correct values', () async {
    //   when(mockService.registerUser(
    //     username: any<String>(named: 'username'),
    //     password: any<String>(named: 'password'),
    //     tierCode: any<String>(named: 'tierCode'),
    //   )).thenAnswer((_) async => {'id': '123', 'tier': 'Basic', 'isAdmin': false});

    //   final result = await controller.registerUser(
    //     username: 'test',
    //     password: '123',
    //     tierCode: 'TIER1CODE',
    //   );

    //   expect(result, isNotNull);
    //   expect(result!['tier'], 'Basic');
    //   verify(mockService.registerUser(
    //     username: 'test',
    //     password: '123',
    //     tierCode: 'TIER1CODE',
    //   )).called(1);
    // }
    // );
  });
}
