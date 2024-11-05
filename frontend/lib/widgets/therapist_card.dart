import 'package:curahead_app/entities/therapist.dart';
import 'package:curahead_app/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import '../controllers/navigation_controller.dart';
import '../pages/therapist_intro.dart';

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({
    super.key,
    required this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    final String name = therapist.displayName;
    final double rating = therapist.rating;
    final String imageUrl = therapist.imageURL;
    final String qualification = therapist.qualifications;

    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.11; // Reduced image height
    final double cardHeight = imageHeight;

    return TextButton(
      onPressed: () {
        NavigationController.navigateToPage(context, TherapistIntroPage(therapist: Therapist.withId("1234"),));
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
      ),
      child: SizedBox(
        height: cardHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: imageHeight,
                width: imageHeight,
                margin: EdgeInsets.all(5),
                child: _buildCircularImage(imageUrl, imageHeight),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr $name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    qualification,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  RatingStars(
                    rating: rating,
                    starSize: 16.0,
                    spacing: 4.0,
                    alignment: MainAxisAlignment.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularImage(String url, double size) {
    return CircleAvatar(
      radius: size / 2, // Reduced circle size
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: FutureBuilder<ImageProvider>(
          future: _getImageProvider(url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show icon while image is loading
              return Center(
                child: Icon(
                  Icons.person,
                  size: size * 0.8,
                  color: Colors.grey,
                ),
              );
            } else if (snapshot.hasError || snapshot.data == null || url == '') {
              // Show icon in case of error or empty URL
              return Icon(
                Icons.person,
                size: size * 0.8,
                color: Colors.grey,
              );
            } else {
              // Show image when it's fully loaded
              return Image(
                image: snapshot.data!,
                height: size,
                width: size,
                fit: BoxFit.cover,
              );
            }
          },
        ),
      ),
    );
  }

  Future<ImageProvider> _getImageProvider(String url) async {
    try {
      return NetworkImage(url);
    } catch (e) {
      throw Exception('Image loading failed');
    }
  }
}
