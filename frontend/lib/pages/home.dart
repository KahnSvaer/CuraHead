import 'package:flutter/material.dart';

import '../widgets/therapist_search_card_button.dart';
import '../widgets/search_bar.dart';

import '../controllers/navigation_controller.dart';

import 'disease.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _WelcomeBar(), // Include the WelcomeBar at the top
        Expanded(
          child: Container(
              color: const Color(0xfff4f6ff),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _DiseaseWidget(),
                  // const SizedBox(height: 12,),
                  const _TherapistWidget(), // Add the TherapistWidget here
                ],
              )),
        ),
      ],
    );
  }
}

class _WelcomeBar extends StatelessWidget {
  const _WelcomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0, // Profile icon size
                backgroundColor: Colors.white, // CircleAvatar background color
                child: Icon(Icons.person,
                    color: Colors.blue, size: 30), // Default person icon
              ),
              const SizedBox(width: 10), // Space between profile and text
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align the text to the left
                children: const [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '[Profile Name]',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15), // Space between profile and search bar
          const SearchWidget(),
        ],
      ),
    );
  }
}

class _DiseaseGrid extends StatelessWidget {
  const _DiseaseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      // 3 buttons per row
      mainAxisSpacing: 12.0,
      // Vertical space between rows
      crossAxisSpacing: 12.0,
      // Horizontal space between buttons
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildButton(context, Icons.medical_information, 'Depression'),
        _buildButton(context, Icons.mood, 'Anxiety'),
        _buildButton(context, Icons.sentiment_very_dissatisfied, 'PTSD'),
        _buildButton(context, Icons.health_and_safety, 'Substance Abuse'),
        _buildButton(context, Icons.psychology, 'ADHD'),
        _buildButton(context, Icons.emoji_people, 'Specific Phobias'),
      ],
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label) {

    final Color textColor = Colors.black;
    final double textFontSize = 10;

    final double iconSize = 50;

    return TextButton(
      onPressed: () {
        NavigationController.navigateToPage(
            context, DiseasePage(diseaseName: label));
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: Colors.white, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded edges
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
          ),
          SizedBox(height: 3), // Space between icon and text
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: textFontSize,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiseaseWidget extends StatelessWidget {
  const _DiseaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                print("See All Pressed");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey, // Text color
                backgroundColor: Colors.transparent, // Button background color
              ),
              child: Text(
                'Show All',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green, // Text color for "See All"
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 0), // Add a smaller spacing here
        const Expanded(child: _DiseaseGrid()),
      ],
    ));
  }
}

class _TherapistWidget extends StatelessWidget {
  const _TherapistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading for the Therapist section
        const Text(
          'Top Therapists',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12), // Space between heading and therapist list
        TherapistCard(
          name: "John Doe",
          rating: 5,
          imageUrl: '',
        ),
        const SizedBox(height: 12), // Space between heading and therapist list
        TherapistCard(
          name: "John Doe",
          rating: 5,
          imageUrl: '',
        )
      ],
    );
  }
}
