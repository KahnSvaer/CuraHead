import 'package:curahead_app/controllers/chat_controller.dart';
import 'package:curahead_app/controllers/navigation_controller.dart';
import 'package:curahead_app/pages/booking.dart';
import 'package:curahead_app/pages/messaging/contact.dart';
import 'package:curahead_app/widgets/profile_image.dart';
import 'package:flutter/material.dart';

import '../entities/chat.dart';
import '../entities/therapist.dart';
import '../widgets/heading_bar.dart';
import '../widgets/star_rating.dart';
import '../widgets/custom_bottom_navigator.dart';
import 'messaging/chat.dart';

class TherapistIntroPage extends StatelessWidget {
  final Therapist therapist;

  const TherapistIntroPage({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double imageRadius = screenWidth * 0.6;

    final String name = therapist.displayName;
    final double stars = therapist.rating;
    return Scaffold(
      appBar: const CustomHeadingBar(
        title: 'Therapist',
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xfff4f6ff), // Outer blue container
                    child: Column(
                      children: [
                        const SizedBox(height: 20), // Space below the app bar
                        ProfileImage(user: therapist, radius: imageRadius/2),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center, // Center the text
                        ),
                        const SizedBox(height: 10),
                        RatingStars(
                          rating: stars, // Replace with dynamic rating if needed
                          starSize: 30.0, // Example: Custom star size
                          spacing: 6.0, // Example: Custom spacing between stars
                          alignment: MainAxisAlignment.center,
                        ),
                        TherapistInformationWidget(
                          therapist: therapist,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      )
    );
  }
}



class TherapistInformationWidget extends StatelessWidget {
  final Therapist therapist;

  const TherapistInformationWidget({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    final String title = therapist.qualifications;
    final String hospital = therapist.hospital;
    final String details = therapist.details;
    final int patientsNum = therapist.patientsNum;
    final int experience = therapist.experience;
    final int numComments = therapist.numComments;

    return Expanded(child: Container(
      color: Colors.white, // Background color
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    final Chat? chat = await ChatController().handleChat(context, therapist.uid);
                    if (chat != null) {
                      NavigationController.pushAndPopUntilRoot(context, ContactListPage());
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10), // Rounded corners
                    ),
                    backgroundColor: Colors.blueAccent, // Button color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.chat_bubble_outline, // Chatting icon
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        'Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10), // Space between buttons
              Expanded(
                child: TextButton(
                  onPressed: () {
                    NavigationController.navigateToPage(context, BookingPage(therapist: therapist,));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10), // Rounded corners
                    ),
                    backgroundColor: Colors.blueAccent, // Button color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.event_available_outlined, // Booking icon
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        'Book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ), // Text color
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Text(
            title, // Display qualification
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            hospital, // Display qualification
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20,),
          const Text(
            'About', // Display qualification
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            details, // Display therapist details
            style: const TextStyle(fontSize: 14, color: Colors.black),
            maxLines: null,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          InfoContainerWidget(
            patientsNum: patientsNum,
            experience: experience,
            numComments: numComments,
          ),
        ],
      ),
    ));
  }
}

class InfoContainerWidget extends StatelessWidget {
  final int patientsNum;
  final int experience;
  final int numComments;

  const InfoContainerWidget({
    super.key,
    required this.patientsNum,
    required this.experience,
    required this.numComments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff4f6ff),
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal space
        children: [
          _infoCard('Patients', patientsNum.toString()),
          _infoCard('Experience', "$experience yrs"),
          _infoCard('Stories', numComments.toString()),
        ],
      ),
    );
  }

  Widget _infoCard(String heading, String number) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          number,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}