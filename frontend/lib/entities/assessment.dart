import 'dart:convert';
import 'package:flutter/services.dart';

class Question {
  String questionText;
  List<String> options;

  Question({
    required this.questionText,
    required this.options,
  });

  // Modify question text, type, or options
  void modifyQuestion({String? newText, List<String>? newOptions}) {
    if (newText != null) questionText = newText;
    if (newOptions != null) options = newOptions;
  }

  // Convert Question to Map for display or further processing
  Map<String, dynamic> toMap() {
    return {
      'text': questionText,
      'options': options,
    };
  }

  // Create a Question instance from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['question'] ?? 'No question text',
      options: (json['choices'] as Map<String, dynamic>).values.cast<String>().toList(),  // Convert Map to List<String>
    );
  }
}

class Exam {
  String name;
  String jsonPath;
  List<Question> questions = [];
  int currentQuestionIndex = -1;

  Exam({required this.name, required this.jsonPath});

  // Load questions from a JSON file in assets
  Future<void> loadQuestionsFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString(jsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Parse JSON data into Question instances
      questions = (jsonData['questions_list'] as List)
          .map((item) => Question.fromJson(item))
          .toList();
      print(questions[0].questionText);
    } catch (e) {
      print('Error loading questions: $e');
    }
  }

  // Get remaining questions count
  int remainingQuestions() {
    return questions.length - currentQuestionIndex - 1;
  }

  bool hasNextQuestion() {
    return currentQuestionIndex < questions.length - 1;
  }

  // Get the next question in line, if available
  Question? nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      return questions[currentQuestionIndex];
    }
    return questions[questions.length - 1];
  }

  // Get the previous question in line, if available
  Question? previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      return questions[currentQuestionIndex];
    }
    return null; // No previous question
  }
}

class AssessmentSession {
  final Exam exam;
  DateTime startTime;
  final Map<int, String?> responses = {}; // Maps question index to response

  AssessmentSession({
    required this.exam,
    required this.startTime,
  });

  // Record response to a specific question by index
  void addResponse(int questionIndex, String? response) {
    responses[questionIndex] = response;
  }

  // Check if the session is complete (all questions answered)
  bool isComplete() {
    return responses.length == exam.questions.length;
  }

  // Convert the session to a Map for saving in a database
  Map<String, dynamic> toMap() {
    return {
      'assessmentName': exam.name,
      'json_path': exam.jsonPath,
      'startTime': startTime.toIso8601String(),
      'responses': responses.map((key, value) => MapEntry(key.toString(), value)), // Convert int keys to String
    };
  }

  factory AssessmentSession.fromMap(Map<String, dynamic> data) {
    return AssessmentSession(
      exam: Exam(name: data['assessmentName'], jsonPath: data['json_path']),
      // assuming `Exam` has a `fromMap` method
      startTime: DateTime.parse(data['startTime']),
    )
      ..responses.addAll(
        Map<int, String?>.fromEntries(
          (data['responses'] as Map<String, dynamic>).entries.map(
                (entry) => MapEntry(int.tryParse(entry.key) ?? 0, entry.value as String?),
          ),
        ),
      );
  }
}
