import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color customGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: customGreen,
        foregroundColor: Colors.white, // Ensures text and icon are white
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header
            Column(
              children: const [
                Icon(Icons.pets, size: 90, color: customGreen),
                SizedBox(height: 12),
                Text(
                  'The Way to Happiness',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: customGreen,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An organization dedicated to dogs in need.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Mission
            const _InfoCard(
              title: 'Our Mission',
              icon: Icons.favorite,
              content:
                  'We rescue dogs from foreign shelters, provide medical care, and place them in loving homes. '
                  'All dogs are vaccinated, microchipped, and spayed/neutered before adoption.',
            ),
            const SizedBox(height: 20),

            // Team
            const _InfoCard(
              title: 'Our Team',
              icon: Icons.group,
              content:
                  'Our passionate team of volunteers in Switzerland collaborates with international partners to rescue and rehome dogs. '
                  'We include veterinarians, transporters, and dedicated adopters.',
            ),
            const SizedBox(height: 20),

            // Team Photo
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/teamphoto.png',
                fit: BoxFit
                    .cover, // Ensures the image fills the space proportionally
                alignment: Alignment.center, // Centers the image
              ),
            ),

            const SizedBox(height: 20),

            // Contact
            const _ContactCard(),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  static const Color customGreen = Color(0xFF1B5E20);

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: customGreen.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 36, color: customGreen),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: customGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(content, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  static const Color customGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: customGreen.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, color: customGreen),
                SizedBox(width: 10),
                Text('contact@myweb.ch'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: customGreen),
                SizedBox(width: 10),
                Text('+41 23455'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
