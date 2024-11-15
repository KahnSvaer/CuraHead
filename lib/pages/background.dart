import 'package:curahead_app/pages/splash_screen_loader.dart';
import 'package:curahead_app/state_management/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/appstate.dart';
import 'home.dart';
import 'search.dart';
import 'assessment.dart';
import 'profile.dart';
import '../widgets/custom_bottom_navigator.dart';

class BackGroundPage extends StatelessWidget {
  const BackGroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pages to navigate between
    final List<Widget> pages = [
      const HomePage(),
      const TherapistPage(),
      const AssessmentPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10.0),
        child: Container(color: Colors.blue),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          final user = auth.currentUser;

          if (user == null) {
            return SplashScreen();
          }

          return ValueListenableBuilder<int>(
            valueListenable: AppState().selectedPageIndexNotifier,
            builder: (context, selectedPageIndex, _) {
              return pages[selectedPageIndex];
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      resizeToAvoidBottomInset: false,
    );
  }
}
