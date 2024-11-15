import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_navigator.dart';
import '../../widgets/heading_bar.dart';

class AssessmentCompletedPage extends StatelessWidget {
  const AssessmentCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeadingBar(title: 'Assessment Completed'),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Assessment Completed!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Thank you for completing the assessment. Your responses would be analysed by your therapist',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Go Back'),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
