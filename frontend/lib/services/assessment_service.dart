import 'package:flutter/material.dart';
import '../entities/assessment.dart';

class AssessmentService {
  final Exam exam;
  final ValueNotifier<Question?> currentQuestionNotifier = ValueNotifier<Question?>(null);
  late final AssessmentSession _session; // To track session information
  late String? currantResponse;

  AssessmentService({
    required this.exam,
  });

  // Initialize the session
  void startSession() async {
    await exam.loadQuestionsFromJson();
    _session = AssessmentSession(
      exam: exam,
      startTime: DateTime.now(),
    );
    nextQuestion(""); // Load the first question
  }

  // Load the next question and notify listeners
  String? nextQuestion(String? response) {
    if (_session.isComplete()) {
      currentQuestionNotifier.value = exam.nextQuestion(); // No more questions, session complete
      return _session.responses[exam.currentQuestionIndex];
    }

    // Save response for the current question
    if (exam.currentQuestionIndex >= 0 && exam.currentQuestionIndex < exam.questions.length) {
      _session.addResponse(exam.currentQuestionIndex, response);
    }

    // Move to the next question
    if (exam.hasNextQuestion()) {
      currentQuestionNotifier.value = exam.nextQuestion();
    }
    return null;
  }

  // Load the previous question and return the previous response
  String? previousQuestion() {
    if (exam.currentQuestionIndex > 0) {
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
