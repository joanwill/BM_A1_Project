import 'package:flutter/material.dart';
import 'package:namer_app/extensions/string_extension.dart';

class DogFilterTile extends StatelessWidget {
  final Map<String, String> filters;
  final List<String> breedOptions;
  final VoidCallback onFilterChanged;

  const DogFilterTile({
    required this.filters,
    required this.breedOptions,
    required this.onFilterChanged,
    super.key,
  });

  Widget _buildFilterField(BuildContext context, String label, String key) {
    if (key == 'gender') {
      return _buildDropdownField(context, label, key, ['Male', 'Female']);
    } else if (key == 'breed') {
      return _buildDropdownField(context, label, key, breedOptions);
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 24,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              filters[key] = value;
              onFilterChanged();
            },
          ),
        ),
      );
    }
  }

  Widget _buildDropdownField(
    BuildContext context,
    String label,
    String key,
    List<String> options,
  ) {
    final List<String> dropdownOptions = [''] + options;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 24,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          value: filters[key]!.isEmpty ? null : filters[key],
          items: dropdownOptions.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option.isEmpty ? 'Any' : option),
            );
          }).toList(),
          onChanged: (value) {
            filters[key] = value ?? '';
            onFilterChanged();
          },
          isExpanded: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Filter Dogs', style: Theme.of(context).textTheme.titleLarge),
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      initiallyExpanded: false,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters.keys
              .map((key) => _buildFilterField(context, key.capitalize(), key))
              .toList(),
        ),
      ],
    );
  }
}
