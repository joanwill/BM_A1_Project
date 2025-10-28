import 'package:flutter/material.dart';
import 'package:namer_app/router.dart'; // Assuming your router is defined here
import 'package:provider/provider.dart';
import 'package:namer_app/business/theme_provider.dart';

class DogHumanMatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Match Your Pet to You',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: themeProvider.themeMode, // Can be .light, .dark, or .system
      routerConfig: router(),
    );
  }
}
