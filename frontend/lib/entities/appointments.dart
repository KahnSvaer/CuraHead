import 'package:curahead_app/entities/therapist.dart';
import 'package:curahead_app/entities/user.dart';
import 'package:curahead_app/state_management/auth_provider.dart';

enum AppointmentStatus {
  scheduled,
  completed,
  canceled,
  rescheduled,
  pending,
}

class Appointment {
  final String id;
  final User client;
  final Therapist therapist;
  final DateTime appointmentDateTime;
  AppointmentStatus status;

  Appointment({
    required this.id,
    required this.client,
    required this.therapist,
    required this.appointmentDateTime,
    this.status = AppointmentStatus.scheduled,
  });

  // Methods for CRUD operations
  factory Appointment.fromMap(Map<String, dynamic> data) {
    return Appointment(
      id: data['id'],
      client: User.withId(data['userId']),
      therapist: Therapist.withId(data['therapistId']),
      appointmentDateTime: DateTime.parse(data['appointmentDate']),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': client.uid,
      'therapistId': therapist.uid,
      'appointmentDate': appointmentDateTime.toIso8601String(),
      'status': status,
    };
  }
}
