import 'package:flutter/material.dart';

import '../entities/therapist.dart';
import '../widgets/search_bar.dart';

import '../widgets/therapist_card.dart';

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
                        child: TherapistCard(
                            therapist: Therapist.withId("1234"),
                        )
                      );
                    }),
                  ),
                ))),
      ],
    );
  }
}
