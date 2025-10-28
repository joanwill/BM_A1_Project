import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dog_profile.dart';

class DogService {
  final _client = Supabase.instance.client;

  Future<List<DogProfile>> fetchDogs() async {
    final response = await _client.from('dogs').select();
    return (response as List)
        .map((e) => DogProfile.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<DogProfile>> fetchDogsWithFilter({
    Map<String, String>? filters,
  }) async {
    var query = _client.from('dogs').select();

    filters?.forEach((key, value) {
      if (value.isNotEmpty) {
        query = query.ilike(key, '%$value%');
      }
    });

    final response = await query.order('name', ascending: true);
    return (response as List).map((json) => DogProfile.fromJson(json)).toList();
  }

  Future<void> insertDog(DogProfile dog) async {
    await _client.from('dogs').insert(dog.toMap());
  }

  Future<void> updateDog(DogProfile dog) async {
    await _client.from('dogs').update(dog.toMap()).eq('id', dog.id);
  }

  Future<List<DogProfile>> fetchDogsPaginated(int from, int limit) async {
    final response = await _client
        .from('dogs')
        .select()
        .range(from, from + limit - 1);
    return (response as List)
        .map((e) => DogProfile.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> fetchBreeds() async {
    final response = await _client
        .from('breeds')
        .select('name')
        .order('name', ascending: true);

    return (response as List).map((e) => e['name'] as String).toList();
  }

  /// 🔐 Authenticate user by username and password
  Future<bool> authenticateUser(String username, String password) async {
    final response = await _client
        .from('users')
        .select('id') // Lightweight field
        .ilike('username', username)
        .eq('password', password)
        .limit(1);

    return response != null && response is List && response.isNotEmpty;
  }

  Future<String?> authenticateUserGetId(
    String username,
    String password,
  ) async {
    final response = await _client
        .from('users')
        .select('id')
        .ilike('username', username)
        .eq('password', password)
        .limit(1);

    if (response != null && response is List && response.isNotEmpty) {
      return response[0]['id'] as String?;
    }

    return null;
  }

  Future<Map<String, dynamic>?> authenticateUserGetIdAdmin(
    String username,
    String password,
  ) async {
    final response = await _client
        .from('users')
        .select('id, isAdmin')
        .ilike('username', username)
        .eq('password', password)
        .limit(1);

    if (response != null && response is List && response.isNotEmpty) {
      final user = response[0] as Map<String, dynamic>;
      return {
        'id': user['id'] as String?,
        'isAdmin': user['isAdmin'] as bool? ?? false,
      };
    }

    return null;
  }

  /// Assign a dog to a user
  Future<void> assignDogToUser(String userId, String dogId) async {
    print('Assigning dog to user... $userId  $dogId ');
    print('Current user: ${_client.auth.currentUser}');
    final response = await _client
        .from('user_dogs')
        .insert({'user_id': userId, 'dog_id': dogId})
        .timeout(Duration(seconds: 10));

    //print('Insert response: ${response.data}');
    if (response?.error != null) {
      print('Insert error: ${response.error!.message}');
      throw Exception('Insert failed: ${response.error!.message}');
    }
  }

  /// Remove a dog from a user
  Future<void> removeDogFromUser(String userId, String dogId) async {
    await _client
        .from('user_dogs')
        .delete()
        .eq('user_id', userId)
        .eq('dog_id', dogId);
  }

  Future<List<DogProfile>> fetchDogsByUserId(String userId) async {
    final response = await _client
        .from('user_dogs')
        .select('dog_id, dogs(*)')
        .eq('user_id', userId);

    if (response is List) {
      return response
          .map((e) => DogProfile.fromMap(e['dogs'] as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  Future<Map<String, dynamic>?> registerUser({
    required String username,
    required String password,
    required String tierCode,
  }) async {
    // Determine tier from code
    String tier;
    switch (tierCode) {
      case 'TIER3CODE':
        tier = 'Admin';
      default:
        tier = 'Basic';
    }

    final isAdmin = tier == 'Admin';

    try {
      // Check if username already exists
      final existingUser = await _client
          .from('users')
          .select('id')
          .eq('username', username)
          .maybeSingle();

      if (existingUser != null) {
        return {'error': 'Username already exists'};
      }

      // Proceed with registration
      final response = await _client
          .from('users')
          .insert({
            'username': username,
            'password': password, // ⚠️ Consider hashing
            'isAdmin': isAdmin,
          })
          .select()
          .single();

      if (response != null && response['id'] != null) {
        return {'id': response['id'], 'tier': tier, 'isAdmin': isAdmin};
      }
    } catch (e) {
      return {'error': 'Registration failed: ${e.toString()}'};
    }

    return {'error': 'Unknown error occurred during registration'};
  }
}
