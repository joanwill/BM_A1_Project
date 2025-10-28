import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/controllers/login_controller.dart';
import 'package:provider/provider.dart';

class MyLogin extends StatefulWidget {
  final LoginController? controller;
  const MyLogin({super.key, this.controller});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late final LoginController _controller;

  String? _errorMessage;

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final result = await _controller.loginGetIdAdmin(username, password);

    if (!mounted) return;

    if (result != null) {
      final userId = result['id'];
      final isAdmin = result['isAdmin'];
      Provider.of<UserProvider>(context, listen: false).setUserId(userId);
      Provider.of<UserProvider>(context, listen: false).setIsAdmin(isAdmin);
      context.pushReplacement('/home/$username');
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? LoginController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: const Text('Login'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Colors.green],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pets, size: 48, color: Colors.green),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome Back 👋',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      Semantics(
                        button: true,
                        label: 'Log in',
                        child: ElevatedButton.icon(
                          onPressed: _handleLogin,
                          icon: const Icon(Icons.login),
                          label: const Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF1B5E20,
                            ), // Dark green
                            foregroundColor:
                                Colors.white, // Ensures text/icon are white
                            minimumSize: const Size.fromHeight(48),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () => context.push('/register'),
                        child: const Text('Don’t have an account? Register'),
                      ),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
