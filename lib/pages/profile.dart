import 'package:curahead_app/controllers/assessment_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/appointments.dart';
import '../entities/user.dart';
import '../state_management/auth_provider.dart';

import '../controllers/appointment_controller.dart';
import '../widgets/appointment_card.dart';
import '../widgets/profile_image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).currentUser;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  color: const Color(0xfff4f6ff),
                  child: Column(
                    children: [
                      _ModifiedWelcomeBar(user: user!),
                      _AppointmentsBar(userID: user.uid),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ModifiedWelcomeBar extends StatelessWidget {
  final User user;

  const _ModifiedWelcomeBar({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          // Settings Button
          Positioned(
            top: 0,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // Add your settings action here
                print("Settings button pressed");
              },
            ),
          ),

          // Base content (profile image and text)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  ProfileImage(user: user, radius: 60),
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
                        user.displayName, // Dynamic profile name placeholder
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppointmentsBar extends StatefulWidget {
  final String userID;

  const _AppointmentsBar({
    super.key,
    required this.userID,
  });

  @override
  _AppointmentsBarState createState() => _AppointmentsBarState();
}

class _AppointmentsBarState extends State<_AppointmentsBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Appointments',
            style: TextStyle(
              fontSize: 24, // Font size for the heading
              fontWeight: FontWeight.bold, // Make the heading bold
              color: Colors.black, // Text color for the heading
            ),
          ),
          const SizedBox(height: 16.0), // Space between heading and content
          FutureBuilder<List<Appointment>>(
            future: AppointmentController()
                .getUpcomingAppointmentsForClient(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      'No appointments available.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                final appointments = snapshot.data!;
                return Column(
                  children: appointments.map((appointment) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: AppointmentCard(appointment: appointment),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
