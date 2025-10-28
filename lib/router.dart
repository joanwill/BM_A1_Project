//import 'package:english_words/english_words.dart';

import 'package:go_router/go_router.dart';
import 'package:namer_app/screens/main_home_page.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/register_screen.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const MyLogin()),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainHomePage(userName: ''),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/home/:username',
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return MainHomePage(userName: username);
        },
      ),
    ],
  );
}
