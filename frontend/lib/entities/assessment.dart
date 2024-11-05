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
  void modifyQuestion({String? newText,List<String>? newOptions}) {
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

  // Factory constructor to create a Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'],
      options: List<String>.from(json['options'] ?? []),
    );
  }
}



class Assessment {
  String name;
  List<Question> questions = [];
  int _currentQuestionIndex = 0;

  Assessment({required this.name});

  // Load questions from a JSON file in assets
  Future<void> loadQuestionsFromJson(String jsonPath) async {
    final String jsonString = await rootBundle.loadString(jsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Parse JSON data into Question instances
    questions = jsonData.entries.map((entry) {
      String questionText = entry.key;
      List<String> options = List<String>.from(entry.value['options'] ?? []);
      return Question(
        questionText: questionText,
        options: options,
      );
    }).toList();
  }

  // Modify a specific question by index
  void modifyQuestion(int index, {String? newText, String? newType, List<String>? newOptions}) {
    if (index >= 0 && index < questions.length) {
      questions[index].modifyQuestion(newText: newText, newOptions: newOptions);
    }
  }

  // Get remaining questions count
  int remainingQuestions() {
    return questions.length - _currentQuestionIndex;
  }

  // Get the next question in line, if available
  Question? nextQuestion() {
    if (_currentQuestionIndex < questions.length) {
      return questions[_currentQuestionIndex++];
    } else {
      return null; // No more questions
    }
  }
}

class AssessmentSession {
  final String sessionId;
  final Assessment assessment;
  DateTime startTime;
  DateTime? endTime;
  final Map<int, String> responses = {}; // Maps question index to response

  AssessmentSession({
    required this.sessionId,
    required this.assessment,
    required this.startTime,
  });

  // Record response to a specific question by index
  void addResponse(int questionIndex, String response) {
    responses[questionIndex] = response;
  }

  // Mark the session as complete by setting the end time
  void completeSession() {
    endTime = DateTime.now();
  }

  // Check if the session is complete (all questions answered)
  bool isComplete(s) {
    return responses.length == assessment.questions.length;
  }

  // Convert the session to a Map for saving in a database
  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'assessmentName': assessment.name,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'responses': responses,
    };
  }
}


