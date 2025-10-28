import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/models/dog_profile.dart';
import '../business/dog_provider.dart'; // Your Provider
import '../controllers/dog_controller.dart';
import 'package:provider/provider.dart';

class DogForm extends StatefulWidget {
  final DogProfile? dog; // If null, it's an insert; otherwise, it's an update

  const DogForm({super.key, this.dog});

  @override
  State<DogForm> createState() => _DogFormState();
}

class _DogFormState extends State<DogForm> {
  final _formKey = GlobalKey<FormState>();
  final DogController _dogController = DogController();
  List<String> _breedOptions = [];
  final List<String> _genderOptions = ['Male', 'Female'];
  late TextEditingController nameController;
  late TextEditingController imageUrlController;
  late TextEditingController profileUrlController;
  late TextEditingController breedController;
  late TextEditingController genderController;
  late TextEditingController birthDateController;
  late TextEditingController ageController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    final dog = widget.dog;
    nameController = TextEditingController(text: dog?.name ?? '');
    imageUrlController = TextEditingController(text: dog?.imageUrl ?? '');
    profileUrlController = TextEditingController(text: dog?.profileUrl ?? '');
    breedController = TextEditingController(text: dog?.breed ?? '');
    genderController = TextEditingController(text: dog?.gender ?? '');
    birthDateController = TextEditingController(text: dog?.birthDate ?? '');
    ageController = TextEditingController(text: dog?.age ?? '');
    weightController = TextEditingController(text: dog?.weight ?? '');
    heightController = TextEditingController(text: dog?.height ?? '');
    locationController = TextEditingController(text: dog?.location ?? '');
    _loadBreeds();
  }

  void _loadBreeds() async {
    final breeds = await _dogController.getBreeds();
    setState(() {
      _breedOptions = breeds;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    profileUrlController.dispose();
    breedController.dispose();
    genderController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final dog = DogProfile(
        id: widget.dog?.id ?? '', // Empty for insert
        name: nameController.text,
        imageUrl: imageUrlController.text,
        profileUrl: profileUrlController.text,
        breed: breedController.text,
        gender: genderController.text,
        birthDate: birthDateController.text,
        age: ageController.text,
        weight: weightController.text,
        height: heightController.text,
        location: locationController.text,
        createdAt: widget.dog?.createdAt,
      );

      final provider = Provider.of<DogProvider>(context, listen: false);
      if (widget.dog == null) {
        await provider.addDog(dog);
      } else {
        await provider.updateDog(dog);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.dog == null
                  ? '${dog.name} added successfully!'
                  : '${dog.name} updated successfully!',
            ),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool required = false,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(labelText: label),
      validator: required && !readOnly
          ? (value) => value == null || value.isEmpty ? 'Required' : null
          : null,
    );
  }

  Widget _buildDropdownField(
    String label,
    TextEditingController controller,
    List<String> options, {
    bool required = false,
    bool readOnly = false,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: controller.text.isEmpty ? null : controller.text,
      items: options
          .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
          .toList(),
      onChanged: readOnly
          ? null
          : (value) {
              setState(() {
                controller.text = value ?? '';
              });
            },
      validator: required && !readOnly
          ? (value) => value == null || value.isEmpty ? 'Required' : null
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<UserProvider>(context).isAdmin;
    final isUpdate = widget.dog != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAdmin ? (isUpdate ? 'Update Dog' : 'Add Dog') : 'Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                'Name',
                nameController,
                required: true,
                readOnly: !isAdmin,
              ),
              _buildTextField(
                'Image URL',
                imageUrlController,
                required: true,
                readOnly: !isAdmin,
              ),
              _buildTextField(
                'Profile URL',
                profileUrlController,
                required: true,
                readOnly: !isAdmin,
              ),
              _buildDropdownField(
                'Breed',
                breedController,
                _breedOptions,
                readOnly: !isAdmin,
              ),
              _buildDropdownField(
                'Gender',
                genderController,
                _genderOptions,
                readOnly: !isAdmin,
              ),
              _buildTextField(
                'Birth Date',
                birthDateController,
                readOnly: !isAdmin,
              ),
              _buildTextField('Age', ageController, readOnly: !isAdmin),
              _buildTextField('Weight', weightController, readOnly: !isAdmin),
              _buildTextField('Height', heightController, readOnly: !isAdmin),
              _buildTextField(
                'Location',
                locationController,
                readOnly: !isAdmin,
              ),

              const SizedBox(height: 20),
              if (isAdmin)
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(isUpdate ? 'Update' : 'Add'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
