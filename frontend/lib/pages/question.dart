import 'package:curahead_app/services/assessment_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navigator.dart';
import '../widgets/heading_bar.dart';
import '../entities/assessment.dart';

class QuestionPage extends StatelessWidget {
  final Exam exam;

  const QuestionPage({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeadingBar(title: 'Assessment'),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    color: const Color(0xfff4f6ff),
                    child: _QuestionBody(exam: exam),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _QuestionBody extends StatefulWidget {
  final Exam exam;

  const _QuestionBody({super.key, required this.exam});

  @override
  _QuestionBodyState createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<_QuestionBody> {
  late final AssessmentService assessmentService;
  String? selectedOption; // Track the selected option for the current question

  @override
  void initState() {
    super.initState();
    assessmentService = AssessmentService(exam: widget.exam);
    assessmentService.startSession(); // Start the session and load the first question
  }

  @override
  Widget build(BuildContext context) {
    // Use ValueListenableBuilder to listen to changes in the current question
    return ValueListenableBuilder<Question?>(
      valueListenable: assessmentService.currentQuestionNotifier,
      builder: (context, currentQuestion, child) {
        if (currentQuestion == null) {
          // Case only possible if json currently loading
          return Center(child: CircularProgressIndicator()); // Show loading spinner while question is being loaded
        }

        final questionText = currentQuestion.questionText;
        final options = currentQuestion.options;
        return Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${assessmentService.session.exam.currentQuestionIndex + 1}',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      questionText,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedOption = option; // Set the selected option
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  textStyle: const TextStyle(fontSize: 16),
                                  alignment: Alignment.centerLeft,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(
                                    color: selectedOption == option ? Colors.blue : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Text(option),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        // Previous button should only be enabled if not on the first question
                        if (assessmentService.session.exam.currentQuestionIndex > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  selectedOption = assessmentService.previousQuestion(); // Reset selected option on navigation
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: const Color(0xfff4f6ff),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.arrow_back),
                                  SizedBox(width: 8),
                                  Text("Previous"),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedOption = assessmentService.nextQuestion(selectedOption); // Move to next question
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: const Color(0xfff4f6ff),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Next"),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
