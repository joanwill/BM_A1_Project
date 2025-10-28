//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/business/dog_provider.dart' show DogProvider;
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/business/theme_provider.dart';
import 'package:namer_app/screens/dog_human_match_app.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://arzqjbwksrzbbgekzgpe.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyenFqYndrc3J6YmJnZWt6Z3BlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5ODI4MjUsImV4cCI6MjA2NTU1ODgyNX0.duLI8rSPiFsYRtzTrTGJUMJrktNp9rIDzE2BtWkloRs',
  );
  // await Supabase.initialize(
  //   url: 'https://hcxgahxwswlctumniwpz.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhjeGdhaHh3c3dsY3R1bW5pd3B6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk0MTQxNDgsImV4cCI6MjA2NDk5MDE0OH0.wb4P6D-9fA4Ekr8A7JhbfMYbFqY3DDIr3NSFboOqAoE',
  //  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DogProvider()..loadDogs()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Add more providers here if needed
      ],
      child: DogHumanMatchApp(), // ✅ This includes all routes/screens
    ),
  );
}
