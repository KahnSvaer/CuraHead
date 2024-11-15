import 'package:flutter/material.dart';
import '../controllers/navigation_controller.dart';
import '../pages/assessment/assessment_complete.dart';
import '../entities/assessment.dart';
import '../services/assessment_service.dart';

class AssessmentController {
  final Exam exam;
  final ValueNotifier<Question?> currentQuestionNotifier = ValueNotifier<Question?>(null);
  late final AssessmentSession _session; // To track session information
  late String? currantResponse;

  AssessmentController({
    required this.exam,
  });

  // Initialize the session
  void startSession() async {
    await exam.loadQuestionsFromJson();
    _session = AssessmentSession(
      exam: exam,
      startTime: DateTime.now(),
    );
    nextQuestion(null, ""); // Load the first question
  }

  Future<void> _endSession(BuildContext context) async {
    NavigationController.pushAndPopUntilRoot(context, AssessmentCompletedPage());
    await AssessmentService().saveSession(_session);
  }

  // Load the next question and notify listeners
  String? nextQuestion(BuildContext? context, String? response) {
    // Save response for the current question
    if (exam.currentQuestionIndex >= 0 && exam.currentQuestionIndex < exam.questions.length) {
      _session.addResponse(exam.currentQuestionIndex, response);
    }

    if (_session.isComplete()) {
      _endSession(context!);
      return null;
    }

    // Move to the next question
    if (exam.hasNextQuestion()) {
      currentQuestionNotifier.value = exam.nextQuestion();
      return _session.responses[exam.currentQuestionIndex];
    }
    return null;
  }

  // Load the previous question and return the previous response
  String? previousQuestion(String? response) {
    if (exam.currentQuestionIndex > 0) {
      _session.addResponse(exam.currentQuestionIndex, response);
      currentQuestionNotifier.value = exam.previousQuestion();
      return _session.responses[exam.currentQuestionIndex]; // Return previous response
    }
    return null; // No previous response or no more previous questions
  }

  // Get the current session
  AssessmentSession get session => _session;

  // Get the total number of questions
  int get totalQuestions => exam.questions.length;

  // Get the remaining questions count
  int get remainingQuestions => exam.remainingQuestions();

  // A method to track if the exam is complete
  bool get isComplete => _session.isComplete();
}
