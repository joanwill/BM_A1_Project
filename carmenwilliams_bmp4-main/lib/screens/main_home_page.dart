import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/screens/about_us.dart';
import 'package:namer_app/screens/adoption_process_screen.dart';
import 'package:namer_app/screens/dog_list_screen.dart';
import 'package:namer_app/screens/favorites_screen.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/user_dog_manager_screen.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/common/constants.dart';
import 'package:namer_app/business/theme_provider.dart';

class MainHomePage extends StatelessWidget {
  final String userName;

  const MainHomePage({super.key, required this.userName});

  Drawer buildNavigationDrawer(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId ?? nullGuid;
    final isAdmin = Provider.of<UserProvider>(context).isAdmin;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: const Color(0xFF1B5E20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('All Dogs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDogManagerScreen(userId: userId),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Adoption Process'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdoptionProcessScreen(),
                ),
              );
            },
          ),
          if (userId != nullGuid)
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('My Favourites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouritesScreen(userId: userId),
                  ),
                );
              },
            ),
          if (userId != nullGuid && isAdmin)
            ExpansionTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Administraion'),
              children: [
                ListTile(
                  leading: const Icon(Icons.build),
                  title: const Text('Dog Workbench'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DogAdminstration(),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildIntroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: const [
          Text(
            'Welcome to Fur Real Friend - Adoption',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Discover the most adorable dogs and choose your best friend. Our platform helps you connect, learn, and love.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildFeatureSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: const [
          _FeatureCard(
            icon: Icons.volunteer_activism,
            title: 'Rescue with Purpose',
            description:
                'We save dogs from shelters abroad and place them in loving homes.',
          ),
          _FeatureCard(
            icon: Icons.health_and_safety,
            title: 'Health Comes First',
            description:
                'All dogs receive medical care, vaccinations, and are neutered or spayed.',
          ),
          _FeatureCard(
            icon: Icons.cake,
            title: 'Joyful Companions',
            description:
                'Bringing joy and wagging tails to families through successful adoptions.',
          ),
        ],
      ),
    );
  }

  Widget buildImageGallery() {
    final List<String> galleryImages = [
      'assets/images/gallery1.png',
      'assets/images/gallery2.png',
      'assets/images/gallery3.png',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double imageWidth = maxWidth > 900
              ? 320
              : maxWidth > 600
              ? 280
              : 240;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: galleryImages.map((path) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      path,
                      width: imageWidth,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId ?? nullGuid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            const Icon(Icons.pets),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'The way to happiness - Welcome $userName',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDogManagerScreen(userId: userId),
                ),
              );
            },
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              tooltip: 'Toggle Theme',
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
          if (userProvider.userId == null)
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'Login',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                );
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).clearUser();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Logged out')));
              },
            ),
        ],
      ),
      drawer: buildNavigationDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.asset(
                'assets/images/dog-adoption-form.png',
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),
            buildIntroSection(),
            const SizedBox(height: 30),
            buildFeatureSection(),
            const SizedBox(height: 30),
            buildImageGallery(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: const Color(0xFF1B5E20)),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
