import 'package:flutter/material.dart';

import 'star_rating.dart';

import '../controllers/navigation_controller.dart';

import '../pages/therapist_intro.dart';


class TherapistCard extends StatelessWidget {
  final String name;
  final double rating;
  final String imageUrl;

  const TherapistCard({
    super.key,
    required this.name,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    // Set height ratio for image and card
    final double imageHeight = screenHeight * 0.11; // 11% of screen height
    final double cardHeight = imageHeight; // Card height including padding

    return OutlinedButton(
      onPressed: () {
        NavigationController.navigateToPage(context, TherapistIntroPage());
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded edges
        ),
        backgroundColor: Colors.white,
      ),
      child: SizedBox(
        height: cardHeight, // Set the card height
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Therapist Image with Placeholder Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // Rounded corners for image
              child: SizedBox(
                height: imageHeight,
                width: imageHeight, // Make width same as height for square image/icon
                child: _buildImage(imageUrl, imageHeight), // Use the new image builder
              ),
            ),
            const SizedBox(width: 10), // Space between image and text
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
                  const SizedBox(height: 5), // Space between name and rating
                  // Using the RatingStars widget here
                  RatingStars(
                    rating: rating,
                    starSize: 16.0, // Size of each star
                    spacing: 4.0, // Space between stars
                    alignment: MainAxisAlignment.start, // Align stars to the left
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create the therapist image with error handling and placeholder
  Widget _buildImage(String url, double size) {
    return Image.network(
      url,
      height: size, // Set the image height
      width: size, // Set the image width to match the height for a square
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        // Show default person icon in case of error or empty URL
        return Icon(
          Icons.person,
          size: size, // Resize to match the height and width of the container
          color: Colors.grey,
        );
      },
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        // Show default person icon while the image is loading
        if (loadingProgress == null) return child;
        return Icon(
          Icons.person,
          size: size, // Resize to match the height of the container
          color: Colors.grey, // Optional: color for the icon
        );
      },
    );
  }
}