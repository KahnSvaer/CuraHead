import 'package:flutter/material.dart';

import '../StateManagement/appstate.dart';
import '../widgets/search_bar.dart';

import '../widgets/therapist_search_card_button.dart';

class TherapistPage extends StatelessWidget {
  const TherapistPage({super.key});

  @override
  Widget build(BuildContext context) {
    int pageAmt = 8;
    return Column(
      children: [
        Container(
            color: Colors.blue,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const SearchWidget(
                  showLast: true,
                ),
              ],
            )),
        Expanded(
            child: Container(
                color: const Color(0xfff4f6ff),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(pageAmt, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: const TherapistCard(
                            name: "John Doe", rating: 5, imageUrl: ""),
                      );
                    }),
                  ),
                ))),
      ],
    );
  }
}
