import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                        child: Column(
                          children: [
                            _ModifiedWelcomeBar(),


                          ],
                        )
                    ),
                  ),
                );
              },
            )
    );
  }
}

class _ModifiedWelcomeBar extends StatelessWidget {
  const _ModifiedWelcomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(10),
      height: 150, // Adjust height as needed
      child: Stack(
        children: [
          // Base content (profile image and text)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              _buildProfileImage(60),
              const SizedBox(width: 10), // Space between profile image and text

              // Column for the text (Hello, Profile Name)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32, // Slightly larger text for "Hello"
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '[Profile Name]', // Dynamic profile name placeholder
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2), // Overlay background with transparency
              child: Align(
                alignment: Alignment.bottomCenter, // Row aligned at the bottom
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 90,),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Option 1'),
                        ),
                      ),
                      Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Option 2'),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(double radius) {
    return Column(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: Image.network(
              '', // URL for the profile image
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Icon(
                  Icons.person,
                  size: radius * 1.3,
                  color: Colors.blue,
                );
              },
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 30,)
      ],
    ) ;
  }
}


