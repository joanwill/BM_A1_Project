import 'package:flutter/material.dart';

class DogProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String profileUrl;
  final String birthDate;
  final String age;
  final String breed;
  final String gender;
  final String weight;
  final String height;
  final String location;
  final bool isSelected;
  final VoidCallback? onTap;

  const DogProfileCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.profileUrl,
    required this.birthDate,
    required this.age,
    required this.breed,
    required this.gender,
    required this.weight,
    required this.height,
    required this.location,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Dog profile for \$name, \$age years old \$breed located in \$location',
      child: Card(
        elevation: 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      semanticLabel: 'Photo of \$name',
                      errorBuilder: (_, __, ___) => const Icon(Icons.pets),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text('Breed: $breed'),
                        Text('Gender: $gender'),
                        Text('Birthdate: $birthDate'),
                        Text('Age: $age'),
                        Text('Weight: $weight'),
                        Text('Height: $height'),
                        Text('Location: $location'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Favourite icon overlay
            Positioned(
              right: 4,
              top: 4,
              child: Semantics(
                button: true,
                label: isSelected
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                child: IconButton(
                  icon: Icon(
                    isSelected ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
