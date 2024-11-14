import 'package:curahead_app/entities/therapist.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../entities/appointments.dart';
import '../widgets/custom_bottom_navigator.dart';
import '../widgets/heading_bar.dart';
import '../controllers/appointment_controller.dart'; // Import the controller

class BookingPage extends StatefulWidget {
  final Therapist therapist;

  const BookingPage({super.key, required this.therapist});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final AppointmentController _appointmentController = AppointmentController();

  DateTime? _selectedDate;
  String? _selectedTime;

  // List of all available timings
  List<String> availableTimings = [
    '10:00 AM',
    '12:00 PM',
    '3:00 PM',
    '5:00 PM',
  ];

  // Timings that are filling up
  List<String> fillingUpTimings = [
    '12:00 PM',
    '3:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeadingBar(title: "Book Appointment"),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Calendar Widget
              SizedBox(
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      if (selectedDay.isAfter(DateTime.now())) {
                        _selectedDate = selectedDay;
                        _selectedTime = null; // Reset time when a new date is selected
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a future date.')),
                        );
                      }
                    });
                  },
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Available Timings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (_selectedDate == null)
                        Center(
                          child: Text('Please select a date to see available timings.'),
                        )
                      else
                        Wrap(
                          spacing: 0,
                          runSpacing: 0,
                          children: availableTimings.map((time) {
                            final isSelected = time == _selectedTime;
                            final isFillingUp = fillingUpTimings.contains(time);

                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? Colors.blue
                                      : isFillingUp
                                      ? Colors.grey[300]
                                      : Colors.grey[100],
                                  foregroundColor: isSelected
                                      ? Colors.white
                                      : isFillingUp
                                      ? Colors.grey[600]
                                      : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: isFillingUp
                                    ? null
                                    : () {
                                  setState(() {
                                    _selectedTime = time;
                                  });
                                },
                                child: Text(time),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),

              // Create Appointment Button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedDate != null && _selectedTime != null
                        ? () async {
                      // Use AppointmentController directly
                      await _appointmentController.saveBooking(
                        context,
                        Appointment(
                          therapist: widget.therapist,
                          appointmentDateTime: _convertToDateTime(
                              _selectedTime!, _selectedDate!),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      backgroundColor: (_selectedDate == null || _selectedTime == null)
                          ? Colors.grey
                          : Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Create Appointment',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _convertToDateTime(String timeString, DateTime date) {
    List<String> timeParts = timeString.split(' ');

    List<String> time = timeParts[0].split(':');
    int hour = int.parse(time[0]);
    int minute = int.parse(time[1]);

    if (timeParts[1] == 'PM' && hour != 12) {
      hour += 12; // Convert to 24-hour format
    } else if (timeParts[1] == 'AM' && hour == 12) {
      hour = 0; // Convert midnight (12 AM) to 00:00
    }

    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
