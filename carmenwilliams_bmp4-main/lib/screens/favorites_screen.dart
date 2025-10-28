import 'package:flutter/material.dart';
import 'base_dog_screen.dart';
import '../models/dog_profile.dart';

class FavouritesScreen extends BaseDogScreen {
  const FavouritesScreen({super.key, required super.userId, super.controller});

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends BaseDogScreenState<FavouritesScreen> {
  Future<void> _confirmAndRemove(String dogId, String dogName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove favourite?'),
        content: Text('Remove $dogName from favourites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await removeDogFromUser(dogId);
      setState(() {});
    }
  }

  @override
  void onDogCardTapped(String dogId, bool isAssigned, String dogName) async {
    _confirmAndRemove(dogId, dogName);
  }

  @override
  Widget build(BuildContext context) {
    return buildScreenScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Favourites'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),

      body: FutureBuilder<List<DogProfile>>(
        future: userDogsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final dogs = snapshot.data!;
          if (dogs.isEmpty) {
            return const Center(child: Text('You have no favourites yet.'));
          }

          final displayDogs = applyFilters(dogs);
          return ListView.builder(
            itemCount: displayDogs.length,
            itemBuilder: (context, index) {
              final dog = displayDogs[index];
              return Stack(
                children: [
                  buildDogProfileCard(dog),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => _confirmAndRemove(dog.id, dog.name),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
