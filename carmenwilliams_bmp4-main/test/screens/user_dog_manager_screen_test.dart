import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/controllers/dog_controller.dart';
import 'package:namer_app/models/dog_profile.dart';

class FakeDogController implements DogController {
  List<String> assigned = [];
  List<DogProfile> dogs;
  List<String> breedsReturn;
  FakeDogController({this.dogs = const [], this.breedsReturn = const []});

  @override
  Future<void> assignDog(String userId, String dogId) async {
    assigned.add(dogId);
  }

  @override
  Future<List<DogProfile>> getAllDogs() async => dogs;

  @override
  Future<List<String>> getBreeds() async => breedsReturn;

  @override
  Future<List<DogProfile>> getUserDogs(String userId) async => dogs;

  @override
  Future<void> removeDog(String userId, String dogId) async {
    assigned.remove(dogId);
  }
}

void main() {
  test('assignDog stores dog id', () async {
    final controller = FakeDogController();
    await controller.assignDog('1', 'dog1');
    expect(controller.assigned, contains('dog1'));
  });
}
