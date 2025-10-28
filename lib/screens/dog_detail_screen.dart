import 'package:flutter/material.dart';
import 'package:namer_app/models/dog_profile.dart';

class DogDetailScreen extends StatelessWidget {
  final DogProfile dog;

  DogDetailScreen({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dog.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: dog details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Breed: ${dog.breed ?? "Unknown"}'),
                      Text('Age: ${dog.age ?? "Unknown"}'),
                      Text('Gender: ${dog.gender ?? "Unknown"}'),
                      Text('Weight: ${dog.weight ?? "Unknown"}'),
                      Text('Height: ${dog.height ?? "Unknown"}'),
                      Text('Location: ${dog.location ?? "Unknown"}'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Right side: image aligned to bottom
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          dog.imageUrl,
                          fit: BoxFit.cover,
                          semanticLabel: 'Photo of \${dog.name}',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
