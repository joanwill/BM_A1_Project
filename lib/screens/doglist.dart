import 'package:flutter/material.dart';
import '../models/dog_profile.dart';
import '../services/dog_service.dart';
import '../helpers/dog_profile_card.dart';

class DogListScreen extends StatefulWidget {
  const DogListScreen({super.key});

  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  final DogService _dogService = DogService();
  int _page = 0;
  final int _pageSize = 3;
  List<DogProfile> _dogs = [];
  Set<DogProfile> _selectedDogs = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDogs();
  }

  Future<void> _fetchDogs() async {
    setState(() {
      _isLoading = true;
    });
    final dogs = await _dogService.fetchDogsPaginated(
      _page * _pageSize,
      _pageSize,
    );
    setState(() {
      _dogs = dogs;
      _isLoading = false;
    });
  }

  void _toggleSelection(DogProfile dog) {
    setState(() {
      if (_selectedDogs.contains(dog)) {
        _selectedDogs.remove(dog);
      } else {
        _selectedDogs.add(dog);
      }
    });
  }

  void _nextPage() {
    setState(() {
      _page++;
    });
    _fetchDogs();
  }

  void _previousPage() {
    if (_page > 0) {
      setState(() {
        _page--;
      });
      _fetchDogs();
    }
  }

  void _submitSelectedDogs() {
    // Example: print selected dog names
    final selectedNames = _selectedDogs.map((d) => d.name).join(', ');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Selected Dogs'),
        content: Text(
          selectedNames.isNotEmpty ? selectedNames : 'No dogs selected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dog Profiles')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _dogs.length,
                    itemBuilder: (context, index) {
                      final dog = _dogs[index];
                      return DogProfileCard(
                        name: dog.name,
                        imageUrl: dog.imageUrl,
                        profileUrl: dog.profileUrl,
                        birthDate: dog.birthDate,
                        age: dog.age,
                        breed: dog.breed,
                        gender: dog.gender,
                        weight: dog.weight,
                        height: dog.height,
                        location: dog.location,
                        isSelected: _selectedDogs.contains(dog),
                        onTap: () => _toggleSelection(dog),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _page > 0 ? _previousPage : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _dogs.length == _pageSize ? _nextPage : null,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: _selectedDogs.isNotEmpty
                        ? _submitSelectedDogs
                        : null,
                    child: Text('Submit Selected Dogs'),
                  ),
                ),
              ],
            ),
    );
  }
}
