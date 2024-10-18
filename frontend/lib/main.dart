import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:curahead_app/firebase_options.dart';
import 'package:provider/provider.dart';

import 'StateManagement/providerState.dart';
import 'pages/background.dart';

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
        ChangeNotifierProvider<ProviderState>(
          create: (_) => ProviderState(),
        ),
      ],
      child: MaterialApp(
        title: 'Curahead',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BackGroundPage(),
      ),
    );
  }
}
