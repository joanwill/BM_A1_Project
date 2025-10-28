import '../models/dog_profile.dart';
import '../services/dog_service.dart';

class DogController {
  final DogService _dogService;

  DogController({DogService? dogService})
    : _dogService = dogService ?? DogService();

  Future<List<DogProfile>> getAllDogs() => _dogService.fetchDogs();

  Future<List<DogProfile>> getUserDogs(String userId) =>
      _dogService.fetchDogsByUserId(userId);

  Future<void> assignDog(String userId, String dogId) =>
      _dogService.assignDogToUser(userId, dogId);

  Future<void> removeDog(String userId, String dogId) =>
      _dogService.removeDogFromUser(userId, dogId);

  /// Expose list of available breeds for UI filters
  Future<List<String>> getBreeds() => _dogService.fetchBreeds();
}
