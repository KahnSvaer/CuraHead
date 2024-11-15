import 'package:curahead_app/entities/appointments.dart';
import 'package:flutter/material.dart';
import '../controllers/navigation_controller.dart';
import '../pages/therapist_intro.dart';
import 'profile_image.dart';  // Import the ProfileImage widget

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final String name = appointment.therapist.displayName;
    final String imageUrl = appointment.therapist.imageURL;
    final String qualification = appointment.therapist.qualifications;
    final DateTime appointmentDateTime = appointment.appointmentDateTime;

    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.11;
    final double cardHeight = imageHeight;

    return TextButton(
      onPressed: () {
        NavigationController.navigateToPage(
          context,
          TherapistIntroPage(therapist: appointment.therapist),
        );
      },
      style: TextButton.styleFrom(
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
                    style: TextStyle(
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
}
