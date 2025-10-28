import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SafeImage extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;

  const SafeImage({
    required this.imagePath,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _assetExists(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == true) {
          return Image.asset(
            imagePath,
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
        } else {
          return Image.asset(
            'assets/images/placeholder.png',
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  Future<bool> _assetExists(String path) async {
    try {
      final asset = await rootBundle.load(path);
      return asset != null;
    } catch (_) {
      return false;
    }
  }
}
