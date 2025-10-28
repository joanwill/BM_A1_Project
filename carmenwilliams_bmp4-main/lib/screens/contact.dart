import 'package:flutter/material.dart';
import 'package:namer_app/business/contactcontroller.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/common/constants.dart';
import 'package:provider/provider.dart';
import '../controllers/dog_controller.dart';

class ContactPage extends StatefulWidget {
  final ContactController? controller;
  const ContactPage({super.key, this.controller});
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  String? _salutation;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _content = '';
  final TextEditingController _contentController = TextEditingController();
  final DogController _dogController = DogController();
  late final ContactController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ContactController();
    final userId = Provider.of<UserProvider>(context, listen: false).userId;
    if (userId != null && userId != nullGuid) {
      _dogController.getUserDogs(userId).then((dogs) {
        final names = dogs.map((d) => d.name).join(', ');
        if (!mounted) return;
        setState(() {
          _content = names;
          _contentController.text = names;
        });
      });
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fields marked with * are required.\nWe look forward to hearing from you.',
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Title*'),
                value: _salutation,
                items: ['Ms.', 'Mr.']
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _salutation = value),
                validator: (value) =>
                    value == null ? 'Please select a Title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name*'),
                onChanged: (value) => _firstName = value,
                validator: (value) =>
                    value!.isEmpty ? 'First name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name*'),
                onChanged: (value) => _lastName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Last name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email*'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  // Simple email regex pattern
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number*'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => _phoneNumber = value,
                validator: (value) =>
                    value!.isEmpty ? 'Phone number is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content*'),
                maxLines: 4,
                onChanged: (value) => _content = value,
                validator: (value) =>
                    value!.isEmpty ? 'Content is required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await controller.submitContactForm(
                      salutation: _salutation!,
                      firstName: _firstName,
                      lastName: _lastName,
                      email: _email,
                      phoneNumber: _phoneNumber,
                      content: _content,
                    );
                    if (!mounted) return;
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form submitted successfully!')),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error submitting form')),
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
