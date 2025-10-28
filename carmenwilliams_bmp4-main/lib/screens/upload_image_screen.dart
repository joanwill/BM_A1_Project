import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'dart:io';

class ImageUploader {
  final SupabaseClient supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadImageToSupabase() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final file = File(pickedFile.path);
      final fileName = path.basename(file.path);
      final fileBytes = await file.readAsBytes();
      final mimeType = lookupMimeType(file.path);

      final response = await supabase.storage
          .from('dog-images')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: FileOptions(contentType: mimeType),
          );

      if (response.isEmpty) return null;

      final publicUrl = supabase.storage
          .from('dog-images')
          .getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      print('Error uploading image: \$e');
      return null;
    }
  }
}

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  String? _imageUrl;
  bool _isUploading = false;
  final ImageUploader _uploader = ImageUploader();

  void _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    final url = await _uploader.uploadImageToSupabase();

    setState(() {
      _imageUrl = url;
      _isUploading = false;
    });

    if (url != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Image upload failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Dog Image')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: Text(_isUploading ? 'Uploading...' : 'Upload Image'),
            ),
            SizedBox(height: 20),
            if (_imageUrl != null) ...[
              Text('Uploaded Image URL:'),
              SelectableText(_imageUrl!),
              SizedBox(height: 10),
              Image.network(_imageUrl!),
            ],
          ],
        ),
      ),
    );
  }
}
