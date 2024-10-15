import 'package:curahead_app/entities/therapist.dart';
import 'package:curahead_app/entities/user.dart';

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
  final DateTime appointmentDate;
  AppointmentStatus status;
  final String notes;

  Appointment({
    required this.id,
    required this.client,
    required this.therapist,
    required this.appointmentDate,
    this.status = AppointmentStatus.scheduled,
    this.notes = "",
  });

  // Methods for CRUD operations
  factory Appointment.fromMap(Map<String, dynamic> data) {
    return Appointment(
      id: data['id'],
      client: data['client'],
      therapist: data['Therapist'],
      appointmentDate: DateTime.parse(data['appointmentDate']),
      status: data['status'],
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client': client,
      'therapist': therapist,
      'appointmentDate': appointmentDate.toIso8601String(),
      'status': status,
      'notes': notes,
    };
  }
}
