import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/dog_profile.dart';
import '../services/dog_service.dart';

class DogProvider with ChangeNotifier {
  final DogService _dogService = DogService();
  List<DogProfile> _dogs = [];

  List<DogProfile> get dogs => _dogs;

  Future<void> loadDogs() async {
    try {
      _dogs = await _dogService.fetchDogs();
      notifyListeners();
      log('Loaded ${_dogs.length} dogs');
    } catch (e, stackTrace) {
      log('Failed to load dogs: $e', stackTrace: stackTrace);
    }
  }

  Future<void> addDog(DogProfile dog) async {
    try {
      log('Start Dog added: ${dog.name}');
      await _dogService.insertDog(dog);
      log('Dog added: ${dog.name}');
      await loadDogs();
    } catch (e, stackTrace) {
      log('Failed to add dog: $e', stackTrace: stackTrace);
    }
  }

  Future<void> updateDog(DogProfile dog) async {
    try {
      await _dogService.updateDog(dog);
      log('Dog updated: ${dog.name}');
      await loadDogs();
    } catch (e, stackTrace) {
      log('Failed to update dog: $e', stackTrace: stackTrace);
    }
  }
}
