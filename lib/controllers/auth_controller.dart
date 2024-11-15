import 'package:curahead_app/pages/auth/auth_landing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/auth_provider.dart';

import 'navigation_controller.dart';

import '../pages/background.dart'; //Eventual page that I will be using

class SignInMethods {
  void signInGoogle(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.signInWithGoogle();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed in from Google')),
      );
      NavigationController.newRootPush(context, BackGroundPage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google: $e')),
      );
    }
  }

  // Sign in with email and password
  void signInWithEmail(BuildContext context, String email, String password) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.signInWithEmail(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed in with Email')),
      );
      NavigationController.newRootPush(context, AuthLandingPage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Email: $e')),
      );
    }
  }
}