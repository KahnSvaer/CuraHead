import 'package:flutter/material.dart';

import '../widgets/therapist_search_card_button.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _DiseaseWidget(),
                  const SizedBox(height: 12,),
                  const _TherapistWidget(), // Add the TherapistWidget here
                ],
              )),
        ),
      ],
    );
  }
}

// Custom Widgets Used
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
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '[Profile Name]',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15), // Space between profile and search bar
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Therapist',
                alignLabelWithHint: true,
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search,
                      color: Colors.grey), // Search icon as a button
                  onPressed: () {
                    print("Searching");
                  },
                ), // Search icon on the right
              ),
            ),
          ),
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
        _buildOutlinedButton(context, Icons.medical_information, 'ADHD'),
        _buildOutlinedButton(context, Icons.mood, 'Anxiety'),
        _buildOutlinedButton(
            context, Icons.sentiment_very_dissatisfied, 'Depression'),
        _buildOutlinedButton(context, Icons.health_and_safety, 'PTSD'),
        _buildOutlinedButton(context, Icons.psychology, 'OCD'),
        _buildOutlinedButton(context, Icons.emoji_people, 'Bipolar'),
      ],
    );
  }

  Widget _buildOutlinedButton(BuildContext context, IconData icon, String label) {
    final Color outlineColor = Colors.black;
    final double outlineWidth = 1;

    final Color textColor = Colors.black;
    final double textFontSize = 10;

    final double iconSize = 50;

    final Color buttonColor = Colors.white;

    return OutlinedButton(
      onPressed: () {
        print('$label pressed');
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: outlineColor, width: outlineWidth), // Border color and width
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded edges
        ),
        backgroundColor: buttonColor,
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
                  'Diseases', // Directly using Text for "Diseases"
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
          'Therapists',
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
          imageUrl: 'https://via.placeholder.com/100.png?text=John+Doe',
        ),
        const SizedBox(height: 12), // Space between heading and therapist list
        TherapistCard(
            name: "John Doe",
            rating: 5,
            imageUrl: 'https://via.placeholder.com/100.png?text=John+Doe',
        )
      ],
    );
  }

}


