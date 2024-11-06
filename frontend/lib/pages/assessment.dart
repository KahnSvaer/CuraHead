import 'package:curahead_app/entities/assessment.dart';
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
            NavigationController.navigateToPage(context, QuestionPage(exam: Exam(name: "GHQ", jsonPath: "assets/data/ghq.json" ))); //Dummy question
          },
          child: Text("GHQ")),
    );
  }
}
