import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curahead App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WelcomeBar(),
      body: Column(
        children: [
          Expanded(child: Container()), // Empty space for main content
          const BottomNavigationBarRow(), // Bottom navigation row
        ],
      ), // Empty body
    );
  }
}

class WelcomeBar extends AppBar {
  WelcomeBar({super.key})
      : super(
          backgroundColor: Colors.blue, // Set AppBar color to blue
          elevation: 0, // Remove AppBar shadow
          toolbarHeight:
              150, // Increase height of AppBar to fit profile and search bar
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0, // Profile icon size
                    backgroundColor:
                        Colors.white, // CircleAvatar background color
                    child: Icon(Icons.person,
                        color: Colors.blue, size: 30), // Default person icon
                  ),
                  SizedBox(width: 10), // Space between profile and text
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align the text to the left
                    children: [
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
                  )
                ],
              ),
              SizedBox(height: 20), // Space between profile and search bar
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Therapist',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search,
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

class BottomNavigationBarRow extends StatelessWidget {
  final double iconImageSize = 40;
  final Color iconImageColor = Colors.white;
  final Color textColor = Colors.white;

  const BottomNavigationBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home button
          buildNavButton(
            context,
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              print('Navigate to Home Page');
            },
          ),
          // Chat button
          buildNavButton(
            context,
            icon: Icons.chat_outlined,
            label: 'Chats',
            onTap: () {
              print('Navigate to Chat Page');
            },
          ),
          // Exam button
          buildNavButton(
            context,
            icon: Icons.school_outlined,
            label: 'Assessment',
            onTap: () {
              print('Navigate to Exam Page');
            },
          ),
          // Settings button
          buildNavButton(
            context,
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () {
              print('Navigate to Settings Page');
            },
          ),
        ],
      ),
    );
  }

  // Helper function to create a filled button
  Widget buildNavButton(BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent, // Button background color
        foregroundColor: Colors.white, // Icon and text color
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconImageSize, // Icon size
            color: iconImageColor, // Icon color
          ),
          const SizedBox(height: 2), // Gap between icon and text
          Text(
            label,
            style: TextStyle(
              fontSize: 12, // Text size
              color: textColor, // Text color
            ),
          ),
        ],
      ),
    );
  }
}

