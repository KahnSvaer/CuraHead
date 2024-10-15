import 'package:flutter/material.dart';

import '../StateManagement/appstate.dart';
import 'home.dart';
import 'chat.dart';
import 'assessment.dart';
import 'profile.dart';
import '../widgets/custom_bottom_navigator.dart';

class BackGroundPage extends StatelessWidget {
  const BackGroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pages to navigate between
    final List<Widget> _pages = [
      const HomePage(),
      const ChatPage(),
      const AssessmentPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10.0),
        child: Container(color: Colors.blue),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: AppState().selectedPageIndexNotifier,
        builder: (context, selectedPageIndex, _) {
          return _pages[selectedPageIndex]; // Display page based on current index
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      resizeToAvoidBottomInset: false,
    );
  }
}
