import 'package:curahead_app/entities/appointments.dart';
import 'package:flutter/material.dart';
import '../controllers/chat_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/phone_controller.dart';
import '../entities/chat.dart';
import '../pages/messaging/contact.dart';
import '../pages/therapist_intro.dart';
import 'profile_image.dart';  // Import the ProfileImage widget

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  AppointmentCardState createState() => AppointmentCardState();
}

class AppointmentCardState extends State<AppointmentCard> {
  bool _isExpanded = false;
  bool _showButtons = false;
  final int animationTime = 120;

  @override
  Widget build(BuildContext context) {
    final Appointment appointment = widget.appointment;
    final String name = appointment.therapist.displayName;
    final String qualification = appointment.therapist.qualifications;
    final DateTime appointmentDateTime = appointment.appointmentDateTime;
    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.09; // Reduced image height
    final double widgetHeight = screenHeight * 0.105; // Increased base height
    final double expandedHeight = screenHeight * 0.17; // Increased expanded height

    return AnimatedContainer(
      duration: Duration(milliseconds: animationTime), // Duration for the smooth animation
      curve: Curves.easeInOutCubic, // Smooth transition curve
      height: _isExpanded ? expandedHeight : widgetHeight, // Dynamic height
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 0), // Padding for card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (true) {
              _isExpanded = true;
              Future.delayed(Duration(milliseconds: animationTime), () {
                setState(() {
                  _showButtons = true; // Show buttons after animation completes
                });
              });
            } else {
              // Handle tap for navigation (e.g., therapist intro page)
              NavigationController.pushAndPopUntilRoot(context, TherapistIntroPage(therapist: appointment.therapist));
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8.0), // Margin added here
                    child: ProfileImage(
                      user: appointment.therapist,
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
                        style: const TextStyle(
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
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0), // Padding for the date
                      child: Text(
                        _formatDate(appointmentDateTime),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0), // Padding for the time
                      child: Text(
                        _formatTime(appointmentDateTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_isExpanded && _showButtons) ...[
              // Buttons appear only when expanded and after animation
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Buttons in a row
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final Chat? chat = await ChatController().handleChat(context, appointment.therapist.uid);
                        if (chat != null) {
                          NavigationController.pushAndPopUntilRoot(context, ContactListPage());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Smaller padding
                        textStyle: const TextStyle(fontSize: 14), // Smaller text
                      ),
                      child: const Text("Chat"),
                    ),
                    const SizedBox(width: 8), // Space between buttons
                    ElevatedButton(
                      onPressed: () {
                        String phoneNumber = "+917303418908";
                        PhoneController.launchPhoneNumber(phoneNumber);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Smaller padding
                        textStyle: const TextStyle(fontSize: 14), // Smaller text
                      ),
                      child: const Text("Call"),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return "${_monthToShorthand(dateTime.month)} ${dateTime.day}${_getOrdinalSuffix(dateTime.day)}";
  }

  String _monthToShorthand(int month) {
    const List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1]; // Months are 1-indexed
  }

  String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th'; // Special case for 11th, 12th, 13th
    }
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  bool _isAppointmentSoon(DateTime appointmentDateTime) {
    final now = DateTime.now();
    final difference = appointmentDateTime.difference(now).inMinutes;
    return (difference <= 5) && (difference > -60);
  }
}
