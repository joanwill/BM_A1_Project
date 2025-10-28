import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../controllers/register_controller.dart';
import '../services/dog_service.dart';
import '../business/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _codeController = TextEditingController();

  late final RegisterController _controller;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = RegisterController(DogService());
  }

  Future<void> _handleRegister() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final code = _codeController.text.trim();

    final passwordError = _controller.validatePasswords(
      password,
      confirmPassword,
    );
    if (passwordError != null) {
      setState(() => _errorMessage = passwordError);
      return;
    }

    final result = await _controller.registerUser(
      username: username,
      password: password,
      tierCode: code,
    );

    if (result != null && result['error'] == null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserId(result['id']);
      userProvider.setIsAdmin(result['isAdmin']);
      context.go('/home/$username');
    } else {
      setState(
        () => _errorMessage =
            result?['error'] ?? 'Registration failed. Try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleRegister,
              child: const Text('Register'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
