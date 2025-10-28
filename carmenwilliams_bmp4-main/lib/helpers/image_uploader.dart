import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';

class ImageUploader {
  final SupabaseClient supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the gallery and uploads it to Supabase Storage.
  /// Returns the public URL of the uploaded image, or null if the process fails.
  Future<String?> uploadImageToSupabase() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final file = File(pickedFile.path);
      final fileName = path.basename(file.path);
      final fileBytes = await file.readAsBytes();
      final mimeType = lookupMimeType(file.path);

      // Upload to Supabase Storage bucket named 'dog-images'
      final response = await supabase.storage
          .from('dog-images')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: FileOptions(contentType: mimeType),
          );

      if (response.isEmpty) return null;

      // Get the public URL
      final publicUrl = supabase.storage
          .from('dog-images')
          .getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
