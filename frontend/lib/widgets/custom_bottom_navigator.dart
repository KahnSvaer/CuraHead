import 'package:flutter/material.dart';

import '../StateManagement/appstate.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppState().toShowNavNotifier, // Listen for toShowNav changes
      builder: (context, toShow, _) {
        return BottomAppBar(
          height: 60,
          padding: EdgeInsets.zero,
          color: Colors.blue, // Background color of the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space items evenly
            children: [
              _buildIconContainer(Icons.home_outlined, 'Home', toShow),
              _buildIconContainer(Icons.search_off_outlined, 'Therapists', toShow),
              _buildIconContainer(Icons.school_outlined, 'Assessment', toShow),
              _buildIconContainer(Icons.person_outline_rounded, 'Profile', toShow),
            ],
          ),
        );
      },
    );
  }

  // Function to get index based on label
  int _labelToIndex(String label) {
    switch (label) {
      case 'Home':
        return 0;
      case 'Therapists':
        return 1;
      case 'Assessment':
        return 2;
      case 'Profile':
        return 3;
      default:
        return 0;
    }
  }

  // Function to build individual icon container
  Widget _buildIconContainer(IconData icon, String label, bool toShow) {
    int index = _labelToIndex(label);
    return ValueListenableBuilder<int>(
      valueListenable: AppState().selectedPageIndexNotifier, // Listen for selected index changes
      builder: (context, selectedIndex, _) {
        bool isPressedIndex = _pressedIndex == index;
        bool isSelectedIndex = selectedIndex == index;

        // Determine the color based on selection and toShow state
        Color containerColor = (isSelectedIndex && toShow) // Selected and toShow is true
            ? Colors.white30
            : (isPressedIndex) // Pressed but not showing
            ? Colors.white12
            : Colors.transparent; // Default color

        return Expanded(
          child: GestureDetector(
            onTap: () {
              AppState().selectedPageIndex = index;
              AppState().toShowNavTrue();
              _popToRoot(context);
            },
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
                  // const SizedBox(height: 2),
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
      },
    );
  }

  void _popToRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}