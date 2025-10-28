import 'package:flutter/material.dart';
import 'package:namer_app/models/dog_profile.dart';
import 'package:namer_app/screens/dog_Form.dart';
import 'package:namer_app/services/dog_service.dart';
import 'package:namer_app/widgets/dog_filter_tile.dart';
import 'package:namer_app/widgets/dog_list_item.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/business/user_provider.dart';

class DogAdminstration extends StatefulWidget {
  @override
  _DogAdminstrationState createState() => _DogAdminstrationState();
}

class _DogAdminstrationState extends State<DogAdminstration> {
  final DogService _dogService = DogService();
  List<DogProfile> _dogs = [];
  List<String> _breedOptions = [];

  final Map<String, String> _filters = {
    'name': '',
    'breed': '',
    'gender': '',
    'age': '',
    'location': '',
  };

  @override
  void initState() {
    super.initState();
    _loadDogs();
    _loadBreeds();
  }

  void _loadDogs() async {
    final dogs = await _dogService.fetchDogsWithFilter(filters: _filters);
    setState(() {
      _dogs = dogs;
    });
  }

  void _loadBreeds() async {
    final breeds = await _dogService.fetchBreeds();
    setState(() {
      _breedOptions = breeds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Administration')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DogFilterTile(
              filters: _filters,
              breedOptions: _breedOptions,
              onFilterChanged: _loadDogs,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Results', style: Theme.of(context).textTheme.titleMedium),
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return userProvider.isAdmin
                        ? ElevatedButton.icon(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DogForm(),
                                ),
                              );
                              _loadDogs(); // Refresh the list after adding a new dog
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Add Dog'),
                          )
                        : const SizedBox.shrink(); // Empty widget if not admin
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),
            Expanded(
              child: _dogs.isEmpty
                  ? Center(child: Text('No dogs found.'))
                  : ListView.builder(
                      itemCount: _dogs.length,
                      itemBuilder: (context, index) {
                        return DogListItem(
                          dog: _dogs[index],
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DogForm(dog: _dogs[index]),
                              ),
                            );
                            _loadDogs(); // Refresh the list after
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
