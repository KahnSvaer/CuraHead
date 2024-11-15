import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and check connection
  bool isFirebaseConnected = await initializeFirebase();

  runApp(MyApp(isConnected: isFirebaseConnected));
}

Future<bool> initializeFirebase() async {
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully!");

    // Check Firestore connection by fetching data
    bool isConnected = await checkFirebaseConnection();
    return isConnected;
  } catch (e) {
    print("Error initializing Firebase: $e");
    return false;
  }
}

Future<bool> checkFirebaseConnection() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Attempt to get a document from a collection (you can use any existing collection)
    var snapshot = await firestore.collection('users').limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      print("Firebase connection is working, data fetched!");
      return true;
    } else {
      print("Firebase connection is working, but no data found.");
      return true; // Connection is working, but no data found.
    }
  } catch (e) {
    print("Error checking Firestore connection: $e");
    return false;
  }
}

class MyApp extends StatelessWidget {
  final bool isConnected;

  MyApp({required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Connection Check',
      home: HomePage(isConnected: isConnected),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isConnected;

  HomePage({required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connection Test'),
      ),
      body: Center(
        child: Text(
          isConnected
              ? 'Firebase is connected and data fetched!'
              : 'Failed to connect to Firebase.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
