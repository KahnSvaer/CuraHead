import 'package:flutter/material.dart';

import '../entities/therapist.dart';
import '../widgets/heading_bar.dart';
import '../widgets/star_rating.dart';
import '../widgets/custom_bottom_navigator.dart';

class TherapistIntroPage extends StatelessWidget {
  final Therapist therapist;

  const TherapistIntroPage({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    final String name = therapist.displayName;
    final double stars = therapist.rating;
    final String title = therapist.qualifications;
    final String hospital = therapist.hospital;
    final String details = therapist.details;
    final int patientsNum = therapist.patientsNum;
    final int experience = therapist.experience;
    final int numComments = therapist.numComments;
    final String imageURL = therapist.imageURL;
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
                        TherapistImageWidget(
                          imageUrl: imageURL,
                          widthPercentage: 50,
                          heightPercentage: 50,
                        ),
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
                          title: title,
                          hospital: hospital,
                          details: details,
                          patientsNum: patientsNum,
                          experience: experience,
                          numComments: numComments,
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

class TherapistImageWidget extends StatelessWidget {
  final String imageUrl;
  final double widthPercentage; // Percentage for width
  final double heightPercentage; // Percentage for height

  const TherapistImageWidget({
    required this.imageUrl,
    this.widthPercentage = 50, // Default 20% width
    this.heightPercentage = 20, // Default 20% height
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double width = screenWidth * (widthPercentage / 100);
    final double height = screenHeight * (heightPercentage / 100);

    final double radius = width > height ? height : width;

    return Container(
      width: radius, // Width of the circular container
      height: radius, // Height of the circular container
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300], // Background color if needed
      ),
      child: ClipOval(
        child: FutureBuilder<ImageProvider>(
          future: _getImageProvider(imageUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              ); // Show loading indicator
            } else if (snapshot.hasError ||
                snapshot.data == null ||
                imageUrl == '') {
              return const FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.person, // Your icon here
                  color: Colors.white,
                ),
              ); // Default icon if there's an error
            } else {
              return Image(
                image: snapshot.data!,
                fit: BoxFit.cover,
              ); // Display the loaded image
            }
          },
        ),
      ),
    );
  }

  // Method to get image provider
  Future<ImageProvider> _getImageProvider(String url) async {
    try {
      // Attempt to load the image from the URL
      return NetworkImage(url);
    } catch (e) {
      // In case of an error, throw an exception
      throw Exception('Image loading failed');
    }
  }
}

class TherapistInformationWidget extends StatelessWidget {
  final String title;
  final String hospital;
  final String details;
  final int patientsNum;
  final int experience;
  final int numComments;

  const TherapistInformationWidget(
      {super.key,
        this.title = 'Therapist',
        this.hospital = '',
        this.details = '',
        this.patientsNum = 0,
        this.experience = 0,
        this.numComments = 0});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    print('Button 1 pressed');
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
                    // Add functionality for the second button
                    print('Button 2 pressed');
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