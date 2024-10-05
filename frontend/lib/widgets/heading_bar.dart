import 'package:flutter/material.dart';

class CustomHeadingBar extends StatelessWidget {
  final String title;
  final double heightPercentage;

  const CustomHeadingBar({
    super.key,
    required this.title,
    this.heightPercentage = 0.08, // Default to 8% of screen height
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double barHeight = screenHeight * heightPercentage;

    return Container(
      color: Colors.blue,
      height: barHeight, // Use calculated percentage height
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Go back to the previous screen
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 10), // Space between icon and text
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}