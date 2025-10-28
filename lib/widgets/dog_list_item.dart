import 'package:flutter/material.dart';
import 'package:namer_app/models/dog_profile.dart';

class DogListItem extends StatelessWidget {
  final DogProfile dog;
  final VoidCallback onTap;

  const DogListItem({required this.dog, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(dog.name),
        subtitle: Text(dog.breed ?? 'Unknown breed'),
        onTap: onTap,
      ),
    );
  }
}
