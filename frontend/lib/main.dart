import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StateManagement/providerState.dart';
import 'pages/background.dart';

void main() {
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
