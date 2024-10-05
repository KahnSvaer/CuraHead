import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final double spacing;
  final MainAxisAlignment alignment; // New property for alignment

  const RatingStars({
    super.key,
    required this.rating,
    this.starSize = 20.0,
    this.spacing = 4.0,
    this.alignment = MainAxisAlignment.start, // Default alignment
  });

  @override
  Widget build(BuildContext context) {
    int starCount = rating.toInt(); // Integer part for full stars
    double halfStar = rating - starCount >= 0.5 ? 1.0 : 0.0; // Check for a half star

    List<Widget> stars = List.generate(5, (index) {
      if (index < starCount) {
        return Icon(Icons.star, color: Colors.amber, size: starSize);
      } else if (index == starCount && halfStar == 1.0) {
        return Icon(Icons.star_half, color: Colors.amber, size: starSize);
      } else {
        return Icon(Icons.star_border, color: Colors.amber, size: starSize);
      }
    });

    return Row(
      mainAxisAlignment: alignment, // Set the alignment here
      children: [
        ...stars, // Spread the stars into the Row
        const SizedBox(width: 4), // Space between stars and the rating text
        Text(
          '${rating.toStringAsFixed(1)}', // Display the rating number
          style: TextStyle(
            fontSize: 0.7*starSize,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
