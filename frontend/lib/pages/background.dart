import 'package:flutter/material.dart';

import '../appstate.dart';

import 'home.dart';
import 'chat.dart';
import 'assessment.dart';
import 'settings.dart';
import 'therapist_intro.dart';

import '../widgets/custom_bottom_navigator.dart';

class BackGroundPage extends StatefulWidget {
  const BackGroundPage({super.key});

  @override
  BackGroundPageState createState() => BackGroundPageState();
}

class BackGroundPageState extends State<BackGroundPage> {
  final int selectedIndex = AppState().selectedPageIndexNotifier.value;
  // List of pages to navigate to
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    // Initialize the _pages list here
    _pages.addAll([
      HomePage(onTherapistSelected: _navigateToTherapistPage),
      const ChatPage(),
      const AssessmentPage(),
      const SettingsPage(),
    ]);
  }

  // Method to navigate to the TherapistIntroPage
  void _navigateToTherapistPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TherapistIntroPage(), // Pass any necessary parameters here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10.0),
        child: Container(color: Colors.blue),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: AppState().selectedPageIndexNotifier, // Listen for changes
        builder: (context, selectedIndex, _) {
          return _pages[selectedIndex]; // Update the displayed page
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      resizeToAvoidBottomInset: false,
    );
  }
}
