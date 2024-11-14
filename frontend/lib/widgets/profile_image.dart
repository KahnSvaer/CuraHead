import 'package:flutter/material.dart';

import '../entities/user.dart';

class ProfileImage extends StatelessWidget {
  final User user;
  final double radius;

  const ProfileImage({
    required this.user,
    required this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: user.imageURL.isNotEmpty
          ? NetworkImage(user.imageURL)
          : null,
      child: user.imageURL.isEmpty
          ? Text(
        user.displayName[0].toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 18),
      )
          : null,
    );
  }
}