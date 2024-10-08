import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigator.dart';
import '../widgets/heading_bar.dart';
import '../widgets/therapist_search_card_button.dart';

class DiseasePage extends StatelessWidget {
  final String diseaseName;

  const DiseasePage({super.key, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    //Temp Variables Placeholders

    final String diseaseTitle = 'Disease Information';
    final String diseaseDetails =
        "Harry listened closely to the silence around him. Was he half expecting to hear the creak of a stair or the swish of a cloak? And then he jumped slightly as he heard his cousin Dudley give a tremendous grunting snore from the next room. Harry shook himself mentally; he was being stupid. There was no one in the house with him except Uncle Vernon, Aunt Petunia, and Dudley, and they were plainly still asleep, their dreams untroubled and painless. Asleep was the way Harry liked the Dursleys best; it wasn't as though they were ever any help to him awake. Uncle Vernon, Aunt Petunia, and Dudley were Harry's only living relatives. They were Muggles who hated and despised magic in any form, which meant that Harry was about as welcome in their house as dry rot. They had explained away Harry's long absences at Hogwarts over the last three years by telling everyone that he went to St. Brutus's Secure Center for Incurably Criminal Boys. They knew perfectly well that, as an underage wizard, Harry wasn't allowed to use magic outside Hogwarts, but they were still apt to blame him for anything that went wrong about the house. Harry had never been able to confide in them or tell them anything about his life in the wizarding world. The very idea of going to them when they awoke, and telling them about his scar hurting him, and about his worries about Voldemort, was laughable. And yet it was because of Voldemort that Harry had come to live with the Dursleys in the first place. If it hadn't been for Voldemort, Harry would not have had the lightning scar on his forehead. If it hadn't been for Voldemort, Harry would still have had parents... Harry had been a year old the night that Voldemort -- the most powerful Dark wizard for a century, a wizard who had been gaining power steadily for eleven years -- arrived at his house and killed his father and mother. Voldemort had then turned his wand on Harry; he had performed the curse that had disposed of many full-grown witches and wizards in his steady rise to power -- and, incredibly, it had not worked. Instead of killing the small boy, the curse had rebounded upon Voldemort. Harry had survived with nothing but a lightning-shaped cut on his forehead, and Voldemort had been reduced to something barely alive. His powers gone, his life almost extinguished, Voldemort had fled; the terror in which the secret community of witches and wizards had lived for so long had lifted, Voldemort's followers had disbanded, and Harry Potter had become famous. It had been enough of a shock for Harry to discover, on his eleventh birthday, that he was a wizard; it had been even more disconcerting to find out that everyone in the hidden wizarding world knew his name. Harry had arrived at Hogwarts to find that heads turned and whispers followed him wherever he went. But he was used to it now: At the end of this summer, he would be starting his fourth year at Hogwarts, and Harry was already counting the days until he would be back at the castle again. But there was still a fortnight to go before he went back to school. He looked hopelessly around his room again, and his eye paused on the birthday cards his two best friends had sent him at the end of July. What would they say if Harry wrote to them and told them about his scar hurting? At once, Hermione Granger's voice seemed to fill his head, shrill and panicky. \"Your scar hurt? Harry, that's really serious.... Write to Professor Dumbledore! And I'll go and check Common Magical Ailments and Afflictions.... Maybe there's something in there about curse scars. . . .\" Yes, that would be Hermione's advice: Go straight to the headmaster of Hogwarts, and in the meantime, consult a book. Harry stared out of the window at the inky blue-black sky. He doubted very much whether a book could help him now. As far as he knew, he was the only living person to have survived a curse like Voldemort's; it was highly unlikely, therefore, that he would find his symptoms listed in Common Magical Ailments and Afflictions. As for informing the headmaster, Harry had no idea where Dumbledore went during the summer holidays. He amused himself for a moment, picturing Dumbledore, with his long silver beard, full length wizard's robes, and pointed hat, stretched out on a beach somewhere, rubbing suntan lotion onto his long crooked nose. Wherever Dumbledore was, though, Harry was sure that Hedwig would be able to find him; Harry's owl had never yet failed to deliver a letter to anyone, even without an address. But what would he write? Dear Professor Dumbledore, Sorry to bother you, but my scar hurt this morning. Yours sincerely, Harry Potter. Even inside his head the words sounded stupid.";
    final String diseaseCure =
        "Harry didn't like to tell Mrs. Weasley that Muggle taxi drivers rarely transported overexcited owls, and Pigwidgeon was making an earsplitting racket. Nor did it help that a number of Filibuster's Fabulous No-Heat, Wet-Start Fireworks went off unexpectedly when Fred's trunk sprang open, causing the driver carrying it to yell with fright and pain as Crookshanks clawed his way up the man's leg. The journey was uncomfortable, owing to the fact that they were jammed in the back of the taxis with their trunks. Crookshanks took quite a while to recover from the fireworks, and by the time they entered London, Harry, Ron, and Hermione were all severely scratched. They were very relieved to get out at King's Cross, even though the rain was coming down harder than ever, and they got soaked carrying their trunks across the busy road and into the station. Harry was used to getting onto platform nine and three-quarters by now. It was a simple matter of walking straight through the apparently solid barrier dividing platforms nine and ten. The only tricky part was doing this in an unobtrusive way, so as to avoid attracting Muggle attention. They did it in groups today; Harry, Ron, and Hermione (the most conspicuous, since they were accompanied by Pigwidgeon and Crookshanks) went first; they leaned casually against the barrier, chatting unconcernedly, and slid sideways through it. . . and as they did so, platform nine and three-quarters materialized in front of them. The Hogwarts Express, a gleaming scarlet steam engine, was already there, clouds of steam billowing from it, through which the many Hogwarts students and parents on the platform appeared like dark ghosts. Pigwidgeon became noisier than ever in response to the hooting of many owls through the mist. Harry, Ron, and Hermione set off to find seats, and were soon stowing their luggage in a compartment halfway along the train. They then hopped back down onto the platform to say good-bye to Mrs. Weasley, Bill, and Charlie. ";

    return Scaffold(
      appBar: CustomHeadingBar(title: 'Disease: $diseaseName'),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                  color: const Color(0xfff4f6ff), // Outer blue container
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                diseaseTitle,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                diseaseDetails,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Cure",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                diseaseCure,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              const Divider(
                                color: Colors.blue, // Line color
                                thickness: 1.5, // Line thickness
                                indent: 15, // Optional: Indent from left
                                endIndent: 15, // Optional: Indent from right
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              _TherapistListWidget(diseaseName: diseaseName),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      })),
    );
  }
}

class _TherapistListWidget extends StatelessWidget {
  final String diseaseName;

  const _TherapistListWidget({
    super.key,
    required this.diseaseName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xfff4f6ff),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "$diseaseName Therapists",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 12), // Space between heading and therapist list
        const TherapistCard(
          name: "John Doe",
          rating: 5,
          imageUrl: 'https://via.placeholder.com/100.png?text=John+Doe',
        ),
        const SizedBox(height: 12), // Space between heading and therapist list
        const TherapistCard(
          name: "John Doe",
          rating: 5,
          imageUrl: 'https://via.placeholder.com/100.png?text=John+Doe',
        ),
      ],
    );
  }
}
