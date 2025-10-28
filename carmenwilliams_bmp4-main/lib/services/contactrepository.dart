import 'package:supabase_flutter/supabase_flutter.dart';

class ContactRepository {
  final SupabaseClient _client;

  ContactRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  Future<void> sendContactData({
    required String salutation,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String content,
  }) async {
    try {
      await _client.from('contacts').insert({
        'salutation': salutation,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'content': content,
      });
    } on PostgrestException catch (e) {
      // Handle Supabase-specific errors
      throw Exception('Supabase error: ${e.message}');
    } catch (e) {
      // Handle other errors
      throw Exception('Unexpected error: $e');
    }
  }
}
