import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigator.dart';
import '../widgets/heading_bar.dart';

class StarterPage extends StatelessWidget {

  const StarterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeadingBar(title: 'Starter Page'),
      bottomNavigationBar: CustomBottomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Ensures it expands to the full height
              ),
              child: IntrinsicHeight(
                child: Container(
                  color: const Color(0xfff4f6ff), // Outer blue container
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(24), // Margin around the inner container
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10), // Rounded corners (optional)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0), // Inner padding for content
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Starter Page',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Starter Page',
                                  style: TextStyle(fontSize: 16),
                                ),
                                // Add more content as needed
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
