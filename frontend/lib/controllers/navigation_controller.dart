import 'package:flutter/material.dart';

import '../state_management/appstate.dart';

class NavigationController {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
    AppState().toShowNavFalse();
  }

  static void pushAndPopUntilRoot(BuildContext context, Widget page) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    navigateToPage(context, page);
  }

  // This method will only be used to end the authentication phase and start on the new phase
  static void newRootPush(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => false, // Remove all previous routes
    );
    AppState().toShowNavTrue();
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}