import 'package:flutter/material.dart';

import '../appstate.dart';

import 'home.dart';
import 'chat.dart';
import 'assessment.dart';
import 'profile.dart';

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
      const HomePage(),
      const ChatPage(),
      const AssessmentPage(),
      const ProfilePage(),
    ]);
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
