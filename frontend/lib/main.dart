import 'package:curahead_app/pages/booking.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:curahead_app/firebase_options.dart';
import 'package:provider/provider.dart';

import 'entities/therapist.dart';
import 'state_management/auth_provider.dart';
import 'pages/background.dart';
import 'pages/auth/auth_landing.dart'; // Import your auth landing page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Auto-generated from Firebase console
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            title: 'Curahead',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: authProvider.currentUser == null
                ? AuthLandingPage() // Replace with your actual auth landing page
                : const BackGroundPage(),
          );
        },
      ),
    );
  }
}
