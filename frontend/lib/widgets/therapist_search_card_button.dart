import 'package:curahead_app/widgets/star_rating.dart';
import 'package:flutter/material.dart';

import '../controllers/navigation_controller.dart';
import '../pages/therapist_intro.dart';

class TherapistCard extends StatelessWidget {
  final String name;
  final double rating;
  final String imageUrl;
  final String qualification;

  const TherapistCard({
    super.key,
    required this.name,
    required this.rating,
    required this.imageUrl,
    this.qualification = 'PHD',
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.11; // Reduced image height
    final double cardHeight = imageHeight;

    return OutlinedButton(
      onPressed: () {
        NavigationController.navigateToPage(context, TherapistIntroPage());
      },
      style: OutlinedButton.styleFrom(
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
        child: Image.network(
          url,
          height: size,
          width: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person,
              size: size * 0.8,
              color: Colors.grey,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // Show image once fully loaded
            return Center(
              child: Icon(
                Icons.person,
                size: size * 0.8,
                color: Colors.grey,
              ), // Show icon while image is loading
            );
          },
        ),
      ),
    );
  }
}
