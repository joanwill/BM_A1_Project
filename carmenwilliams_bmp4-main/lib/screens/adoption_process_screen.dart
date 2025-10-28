import 'package:flutter/material.dart';
import 'contact.dart';

class AdoptionProcessScreen extends StatelessWidget {
  const AdoptionProcessScreen({super.key});

  static const Color customGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Process'),
        backgroundColor: customGreen,
        foregroundColor: Colors.white, // Ensures text and icon are white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Icon Image
            Center(
              child: Image.asset('assets/images/process_icon.png', height: 100),
            ),
            const SizedBox(height: 20),

            // Intro Text
            const Text(
              'Interested in one of our dogs?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you are interested in adopting one of our dogs, please first fill out the questionnaire and send it to us using the online form on this page.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const Text(
              'If there are multiple applicants, we will choose in the best interest of the dog, not based on order of application.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            const Text(
              'Our dogs are neutered, microchipped, vaccinated, and receive veterinary care. If you are ready to pay the adoption fee of CHF 850.- (may vary externally), and agree to a home visit, you can begin the process.',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            // Step-by-step process
            const Text(
              'Adoption Steps:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
            ),
            const SizedBox(height: 12),

            _stepTile(
              context,
              1,
              'Go to the contact form',
              Icons.edit_note,
              isLink: true,
            ),
            _stepTile(context, 2, 'Send the form to us', Icons.send),
            _stepTile(context, 3, 'Home check will be arranged', Icons.home),
            _stepTile(
              context,
              4,
              'Dog transportation arranged',
              Icons.directions_bus,
            ),
            _stepTile(context, 5, 'Follow-up visit', Icons.thumb_up_alt),

            const SizedBox(height: 30),

            // Giveaway Section
            const Text(
              'Give-Away Bags:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: customGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Every adopter will receive a GIVE-AWAY-BAG upon picking up their dog.'
              '',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            // Final CTA
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: customGreen,
                  foregroundColor:
                      Colors.white, // Ensures text and icon are white
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.contact_page),
                label: const Text('Contact Us'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ContactPage()),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Thank you for your trust!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepTile(
    BuildContext context,
    int number,
    String text,
    IconData icon, {
    bool isLink = false,
  }) {
    return InkWell(
      onTap: isLink
          ? () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ContactPage()),
            )
          : null,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: customGreen,
            child: Text('$number', style: const TextStyle(color: Colors.white)),
          ),
          title: Text(text),
          trailing: Icon(icon, color: customGreen),
        ),
      ),
    );
  }
}
