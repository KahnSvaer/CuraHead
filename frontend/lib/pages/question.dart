import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigator.dart';
import '../widgets/heading_bar.dart';

class QuestionPage extends StatelessWidget {
  final int num;
  final String questionText;
  final List<String> options;

  const QuestionPage({
    super.key,
    this.num = 1,
    this.questionText =
        "Have you recently been feeling perfectly well and in good health?",
    this.options = const ["True", "False"],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeadingBar(title: 'Assessment'),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child: Container(
                color: const Color(0xfff4f6ff),
                child: _QuestionBody(
                    num: num, questionText: questionText, options: options),
              )),
            ),
          );
        },
      )),
    );
  }
}

class _QuestionBody extends StatelessWidget {
  final int num;
  final String questionText;
  final List<String> options;

  const _QuestionBody({
    required this.num,
    required this.questionText,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question $num',
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
                      width: double.infinity, // Make button stretch across the screen
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          textStyle: const TextStyle(fontSize: 16),
                          alignment: Alignment.centerLeft, // Align text to the left
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Rounded corners
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
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xfff4f6ff),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.arrow_back), // Icon for "Previous"
                          SizedBox(width: 8), // Spacing between icon and text
                          Text("Previous"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between the buttons
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xfff4f6ff),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Next"),
                          SizedBox(width: 8), // Spacing between text and icon
                          Icon(Icons.arrow_forward), // Icon for "Next"
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ))
    ]);
  }
}
