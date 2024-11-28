import 'package:curahead_app/entities/therapist.dart';
import 'package:curahead_app/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import '../controllers/navigation_controller.dart';
import '../pages/therapist_intro.dart';
import 'profile_image.dart';  // Import the ProfileImage widget

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
        NavigationController.navigateToPage(context, TherapistIntroPage(therapist: therapist,));
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
                child: ProfileImage(   // Use ProfileImage widget here
                  user: therapist,
                  radius: imageHeight / 2,
                ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Cuts off text with an ellipsis
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
}
