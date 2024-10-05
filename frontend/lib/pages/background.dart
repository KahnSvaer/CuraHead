import 'package:flutter/material.dart';

import 'home.dart';
import 'chat.dart';
import 'assessment.dart';
import 'settings.dart';

import 'therapist_intro.dart';

class BackGroundPage extends StatefulWidget {
  const BackGroundPage({super.key});

  @override
  BackGroundPageState createState() => BackGroundPageState();
}

class BackGroundPageState extends State<BackGroundPage> {
  int _selectedIndex = 4; //TODO: put equal 0 later

  // List of pages to navigate to
  final List<Widget> _pages = [
    const HomePage(),
    const ChatPage(),
    const AssessmentPage(),
    const SettingsPage(),
    const TherapistIntroPage() //Page Tester TODO: Delete Later
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            // Set the height of the AppBar
            child: Container(color: Colors.blue)),
        body: _pages[_selectedIndex], // Display the selected page
        bottomNavigationBar: _CustomBottomAppBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        resizeToAvoidBottomInset: false,
    );
  }
}


class _CustomBottomAppBar extends StatefulWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const _CustomBottomAppBar({
    required this.onItemTapped,
    required this.selectedIndex,
    super.key,
  });

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<_CustomBottomAppBar> {
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      padding: EdgeInsets.zero,
      color: Colors.blue, // Background color of the BottomAppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space items evenly
        children: [
          _buildIconContainer(Icons.home_outlined, 'Home'),
          _buildIconContainer(Icons.chat_outlined, 'Chats'),
          _buildIconContainer(Icons.school_outlined, 'Assessment'),
          _buildIconContainer(Icons.settings_outlined, 'Settings'),
        ],
      ),
    );
  }

  // Function to get index based on label
  int _labelToIndex(String label) {
    switch (label) {
      case 'Home':
        return 0;
      case 'Chats':
        return 1;
      case 'Assessment':
        return 2;
      case 'Settings':
        return 3;
      default:
        return 0;
    }
  }

  // Function to build individual icon container
  Widget _buildIconContainer(IconData icon, String label) {
    int index = _labelToIndex(label);
    bool isPressedIndex = _pressedIndex == index;
    bool isSelectedIndex = widget.selectedIndex == index;
    Color containerColor = isSelectedIndex
        ? Colors.white30
        : isPressedIndex
        ? Colors.white12
        : Colors.transparent;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onItemTapped(index),
        onTapDown: (_) {
          setState(() {
            _pressedIndex = index;
          });
        },
        onTapUp: (_) {
          setState(() {
            _pressedIndex = null;
          });
        },
        onTapCancel: () {
          setState(() {
            _pressedIndex = null;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: containerColor, // Change color on selection
            borderRadius: BorderRadius.circular(13), // Rounded edges
          ),
          alignment: Alignment.center, // Center the icon in the container
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
