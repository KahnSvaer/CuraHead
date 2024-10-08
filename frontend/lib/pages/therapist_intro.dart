import 'package:flutter/material.dart';

import '../widgets/heading_bar.dart';
import '../widgets/star_rating.dart';
import '../widgets/custom_bottom_navigator.dart';

class TherapistIntroPage extends StatelessWidget {
  final String name;
  final String therapistID;
  final double stars;
  final String title;
  final String hospital;
  final String details;
  final int patientsNum;
  final int experience;
  final int numComments;

  const TherapistIntroPage({
    super.key,
    this.therapistID = '123',
    this.stars = 5,
    this.name = 'Dr John Doe',
    this.title = 'Therapist',
    this.hospital = 'ABC Hospital, New Delhi',
    this.details = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis, enim quis vestibulum commodo, libero sapien luctus mi, ut imperdiet velit augue at dui. Proin faucibus suscipit purus. Nam commodo, augue sit amet venenatis porttitor, ipsum odio dictum enim, id auctor lacus magna sed urna. Nulla facilisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis tincidunt convallis libero malesuada dictum. Fusce at posuere erat.\n\nNunc volutpat lacinia felis, vestibulum laoreet leo semper quis. Curabitur nec ultricies odio. Morbi et ligula ut ante blandit hendrerit. Vestibulum tincidunt dapibus diam nec consectetur. Nam ornare erat turpis, eu commodo turpis faucibus vel. Nullam maximus tellus ac hendrerit molestie. Morbi rhoncus justo in metus dictum blandit. Aenean nec ipsum ut dui congue tempor. Nullam accumsan a odio ac dapibus. Ut vitae pretium lacus. Phasellus tempor vehicula mauris sed porta. Sed nibh nulla, porta et rutrum eget, pretium id leo.',
    this.patientsNum = 0,
    this.experience = 0,
    this.numComments = 0,
  });

  @override
  Widget build(BuildContext context) {
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
                        const TherapistImageWidget(
                          imageUrl: '',
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
        crossAxisAlignment:
        CrossAxisAlignment.start, // Align content to the start
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Space buttons evenly
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for the first button
                    print('Button 1 pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10), // Rounded corners
                    ),
                    backgroundColor: Colors.blue, // Button color
                  ),
                  child: const Text('Button 1'),
                ),
              ),
              const SizedBox(width: 10), // Space between buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for the second button
                    print('Button 2 pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10), // Rounded corners
                    ),
                    backgroundColor: Colors.blueAccent, // Button color
                  ),
                  child: const Text('Button 2'),
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