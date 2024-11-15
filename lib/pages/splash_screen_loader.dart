import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Load image from assets
              Image.asset(
                'assets/images/SplashScreen.png', // Your splash screen image
                width: 200,  // Adjust size as needed
                height: 200,
              ),
              SizedBox(height: 100),
              const CircularProgressIndicator(), // Loading indicator
            ],
          ),
        )

      ),
    );
  }
}
