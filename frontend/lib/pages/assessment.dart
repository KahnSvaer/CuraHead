import 'package:flutter/material.dart';

import '../controllers/navigation_controller.dart';

import 'question.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
          onPressed: () {
            NavigationController.navigateToPage(context, QuestionPage());
          },
          child: Text("Exam 1")),
    );
  }
}
