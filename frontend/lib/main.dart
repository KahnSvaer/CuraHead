import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          BottomNavigationBarRow(), // Bottom navigation row
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
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home button
          NavItemButton(
            icon: Icons.home_outlined,
            label: 'Home',
            iconSize: iconImageSize, // Customize size if needed
            iconColor: iconImageColor,
            textColor: textColor,
            onTap: () {
              print('Navigate to Home Page');
            },
          ),
          // Chat button
          NavItemButton(
            icon: Icons.chat_outlined,
            label: 'Chats',
            iconSize: iconImageSize,
            iconColor: iconImageColor,
            textColor: textColor,
            onTap: () {
              print('Navigate to Chat Page');
            },
          ),
          // Exam button (using school icon)
          NavItemButton(
            icon: Icons.school_outlined,
            label: 'Assessment',
            iconSize: iconImageSize,
            iconColor: iconImageColor,
            textColor: textColor,
            onTap: () {
              print('Navigate to Exam Page');
            },
          ),
          // Settings button
          NavItemButton(
            icon: Icons.settings_outlined,
            label: 'Settings',
            iconSize: iconImageSize,
            iconColor: iconImageColor,
            textColor: textColor,
            onTap: () {
              print('Navigate to Settings Page');
            },
          ),
        ],
      ),
    );
  }
}

class NavItemButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  final double textSize;
  final Color textColor;
  final Color iconColor;
  final Color pressedColor;
  final VoidCallback onTap;

  const NavItemButton({
    super.key,
    required this.icon,
    required this.label,
    this.iconSize = 28.0, // Default icon size
    this.textSize = 12.0, // Default text size
    this.iconColor = Colors.white, // Default icon color
    this.textColor = Colors.white, // Default text color
    this.pressedColor = Colors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            color: Colors.blue,
            onPressed: onTap,
          ),

          SizedBox(height: 4), // Small gap between icon and label
          Text(
            label,
            style: TextStyle(fontSize: textSize, color: textColor),
          ),
        ],
    );
  }
}
