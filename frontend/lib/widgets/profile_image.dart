import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entities/user.dart';
import 'dart:math';

// ChangeNotifier class to manage image loading state
class ProfileImageNotifier extends ChangeNotifier {
  String imageURL;
  bool isImageLoaded;

  ProfileImageNotifier({
    required this.imageURL,
    this.isImageLoaded = false,
  });

  void setImageLoaded(bool value) {
    isImageLoaded = value;
    notifyListeners(); // Notify listeners when the image load status changes
  }

  void setImageFailed() {
    isImageLoaded = false;
    notifyListeners(); // Notify listeners to fall back to initials
  }
}

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
    return ChangeNotifierProvider<ProfileImageNotifier>(
      create: (_) => ProfileImageNotifier(imageURL: user.imageURL),
      child: Consumer<ProfileImageNotifier>(
        builder: (context, notifier, child) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: _getRandomColor(), // Random background color if no image
            child: ClipOval(
              child: notifier.isImageLoaded
                  ? Container(
                height: radius * 2,
                width: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.imageURL),
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : FutureBuilder<ImageProvider>(
                future: _loadImage(user.imageURL),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      _getInitials(user.displayName),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: radius * 0.7, // Adjust text size based on the radius
                      ),
                    );
                  } else if (snapshot.hasError || snapshot.data == null || user.imageURL.isEmpty) {
                    // If the image fails to load, fall back to initials
                    notifier.setImageFailed();
                    return Text(
                      _getInitials(user.displayName),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: radius * 0.7, // Adjust text size based on the radius
                      ),
                    );
                  } else {
                    // Once the image is loaded successfully, update the notifier
                    notifier.setImageLoaded(true);
                    return Container(
                      height: radius * 2,
                      width: radius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String _getInitials(String name) {
    final nameParts = name.split(' ');
    final cleanedName = nameParts.where((part) => !['Dr.', 'Prof.', 'Mr.', 'Mrs.'].contains(part)).join(' ');
    final initials = cleanedName.isNotEmpty
        ? cleanedName.split(' ').map((part) => part[0].toUpperCase()).join('')
        : '';
    return initials.isNotEmpty ? initials : '?'; // Return initials or '?' if no valid name is found
  }

  Future<ImageProvider> _loadImage(String url) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate loading delay
    try {
      return NetworkImage(url);
    } catch (e) {
      throw Exception('Image loading failed');
    }
  }

  Color _getRandomColor() {
    // Generate a random color
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
