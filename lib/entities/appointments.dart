import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curahead_app/entities/therapist.dart';

enum AppointmentStatus {
  scheduled,
  completed,
  canceled,
  rescheduled,
  pending,
}

class Appointment {
  final Therapist therapist;
  final DateTime appointmentDateTime;
  AppointmentStatus status;

  Appointment({
    required this.therapist,
    required this.appointmentDateTime,
    this.status = AppointmentStatus.scheduled,
  });

  // Methods for CRUD operations
  factory Appointment.fromMap(Map<String, dynamic> data) {
    return Appointment(
      therapist: Therapist.withId(data['therapistId']),
      appointmentDateTime:  (data['appointmentDateTime'] as Timestamp).toDate(),
      status: AppointmentStatus.values.byName(data['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'therapistId': therapist.uid,
      'appointmentDateTime': Timestamp.fromDate(appointmentDateTime),
      'status': status.name,
    };
  }
}
