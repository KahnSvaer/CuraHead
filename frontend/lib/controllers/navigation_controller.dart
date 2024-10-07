import 'package:flutter/material.dart';

import '../appstate.dart';

class NavigationController {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
    AppState().toShowNavFalse();
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
