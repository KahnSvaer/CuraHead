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
                      _ModifiedWelcomeBar(graphNum: graphNum, user: user!),
                      _Graph(selectedNotifier: graphNum),
                      _AppointmentsBar(userID: user.uid,)
                    ]))),
          ),
        );
      },
    ));
  }
}

class _ModifiedWelcomeBar extends StatelessWidget {
  final ValueNotifier<int> graphNum;
  final User user;

  const _ModifiedWelcomeBar({
    required this.graphNum,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {

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
                  ProfileImage(user: user, radius: 60),
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
                        user.displayName, // Dynamic profile name placeholder
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
  final String userID;

  const _AppointmentsBar({super.key, required this.userID});

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
              fontSize: 20, // Font size for the heading
              fontWeight: FontWeight.bold, // Make the heading bold
              color: Colors.black, // Text color for the heading
            ),
          ),
          const SizedBox(height: 16.0), // Space between heading and content
          FutureBuilder<List<Appointment>>(
            future: AppointmentController().getUpcomingAppointmentsForClient(context),
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
                      'No appointments scheduled.',
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

