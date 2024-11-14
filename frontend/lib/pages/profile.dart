import 'package:curahead_app/widgets/appointment_card.dart';
import 'package:curahead_app/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/appointments.dart';
import '../entities/therapist.dart';
import '../entities/user.dart';
import '../state_management/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> graphNum = ValueNotifier(0);
    return SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
                child: Container(
                    color: const Color(0xfff4f6ff),
                    child: Column(children: [
                      _ModifiedWelcomeBar(graphNum: graphNum),
                      _Graph(selectedNotifier: graphNum),
                      const _AppointmentsBar()
                    ]))),
          ),
        );
      },
    ));
  }
}

class _ModifiedWelcomeBar extends StatelessWidget {
  final ValueNotifier<int> graphNum;

  const _ModifiedWelcomeBar({
    required this.graphNum,
  });

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).currentUser;
    final String displayName = user?.displayName ?? 'User';
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  ProfileImage(user: user!, radius: 60),
                  const SizedBox(
                      width: 10), // Space between profile image and text

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
                        displayName, // Dynamic profile name placeholder
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
              SizedBox(
                height: 30,
              )
            ],
          ),
          // Base content (profile image and text)

          Positioned.fill(
            child: Container(
              // color: Colors.black.withOpacity(0.2), // Overlay background with transparency
              child: Align(
                alignment: Alignment.bottomCenter, // Row aligned at the bottom
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      _GraphIndicatorButton(
                          selectedNotifier: graphNum,
                          index: 0,
                          text: "Feature 1"),
                      SizedBox(
                        width: 10,
                      ),
                      _GraphIndicatorButton(
                          selectedNotifier: graphNum,
                          index: 1,
                          text: "Feature 2"),
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
}

class _GraphIndicatorButton extends StatelessWidget {
  final ValueNotifier<int> selectedNotifier;
  final int index;
  final String text;

  const _GraphIndicatorButton({
    required this.selectedNotifier,
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<int>(
        valueListenable: selectedNotifier,
        builder: (context, value, child) {
          return TextButton(
            onPressed: () {
              selectedNotifier.value = index; // Update the selected index
            },
            style: TextButton.styleFrom(
              fixedSize: Size.fromHeight(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: value == index
                  ? Colors.green
                  : Colors.white, // Change color if selected
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

class _Graph extends StatelessWidget {
  final ValueNotifier<int> selectedNotifier;
  final double aspectRatio;

  const _Graph({
    required this.selectedNotifier,
    this.aspectRatio = 1.25,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedNotifier,
      builder: (context, value, child) {
        return AspectRatio(
          aspectRatio: aspectRatio, // Maintains the aspect ratio
          child: Container(
            margin: const EdgeInsets.all(18.0),
            width: double.infinity, // Expands to the full width of the screen
            color: Colors.blueAccent, // Placeholder for the graph
            child: Center(
              child: Text(
                "Graph $value",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppointmentsBar extends StatelessWidget {
  const _AppointmentsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content to the left
        children: [
          const Text(
            'My Appointments',
            style: TextStyle(
              fontSize: 20, // Font size for the heading
              fontWeight: FontWeight.bold, // Make the heading bold
              color: Colors.black, // Text color for the heading
            ),
          ),
          const SizedBox(height: 16.0),
          AppointmentCard(
            appointment: Appointment(
              therapist: Therapist.withId("123"),
              appointmentDateTime: DateTime.now().add(Duration(days: 1, hours: 2)), // Appointment for tomorrow at 2 hours later
            ),
          ),
        ],
      ),
    );
  }
}
