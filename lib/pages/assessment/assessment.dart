import 'package:curahead_app/entities/assessment.dart';
import 'package:flutter/material.dart';
import '../../controllers/navigation_controller.dart';
import 'question.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            "Assessments",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "GHQ 28",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "The GHQ-28 is derived from the original 60-item General Health Questionnaire to streamline the assessment process while maintaining diagnostic accuracy. "
                    "Each of the four subscales contains seven items, enabling focused evaluation of common psychological difficulties.",
                style: TextStyle(fontSize: 16,),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8),
              const Text(
                "The somatic symptoms subscale examines physical manifestations of distress, while anxiety and insomnia highlights emotional tension and sleep disturbances. "
                    "Social dysfunction assesses difficulties in everyday interpersonal and occupational functioning, and severe depression screens for core depressive symptoms.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                "This concise format enhances its suitability for use in busy primary care environments, ensuring quick identification of individuals who may require further psychiatric evaluation.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationController.navigateToPage(
                      context,
                      QuestionPage(
                        exam: Exam(name: "GHQ", jsonPath: "assets/data/ghq.json"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Start Test Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
