import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curahead_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:curahead_app/entities/appointments.dart';
import 'package:curahead_app/services/appointment_service.dart';

class AppointmentController{
  final AppointmentService _appointmentService = AppointmentService();


  // Show SnackBar for errors
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Save a new booking
  Future<void> saveBooking(BuildContext context, Appointment appointment) async {
    try {
      await _appointmentService.saveBooking(appointment);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Appointment Booked'),
        ),
      );
      NavigationController.goBack(context);
    } catch (e) {
      _showErrorSnackBar(context, "Error saving booking: $e");
    }
  }

  // Get all bookings for a client
  Future<List<Appointment>> getBookingsForClient(BuildContext context, String userId) async {
    try {
      final bookings = await _appointmentService.getBookingsForClient();
      return bookings;
    } catch (e) {
      _showErrorSnackBar(context, "Error fetching bookings for client: $e");
      return [];
    }
  }

  // Get all bookings for a therapist
  Future<List<Appointment>> getBookingsForTherapist(BuildContext context, String therapistId) async {
    try {
      final bookings = await _appointmentService.getBookingsForTherapist(therapistId);
      return bookings;
    } catch (e) {
      _showErrorSnackBar(context, "Error fetching bookings for therapist: $e");
      return [];
    }
  }

  // Delete a booking by ID
  Future<void> deleteBooking(BuildContext context, String bookingId) async {
    try {
      await _appointmentService.deleteBooking(bookingId);
    } catch (e) {
      _showErrorSnackBar(context, "Error deleting booking: $e");
    }
  }

  // Reschedule an appointment
  Future<void> rescheduleBooking(BuildContext context, String bookingId, Timestamp newDateTime) async {
    try {
      await _appointmentService.rescheduleBooking(bookingId, newDateTime);
    } catch (e) {
      _showErrorSnackBar(context, "Error rescheduling booking: $e");
    }
  }

  // Check availability for a specific time slot
  Future<bool> isTimeSlotAvailable(BuildContext context, String therapistId, Timestamp dateTime) async {
    try {
      return await _appointmentService.isTimeSlotAvailable(therapistId, dateTime);
    } catch (e) {
      _showErrorSnackBar(context, "Error checking time slot availability: $e");
      return false;
    }
  }

  // Get upcoming bookings for a client
  Future<List<Appointment>> getUpcomingAppointmentsForClient(BuildContext context) async {
    try {
      final bookings = await _appointmentService.getUpcomingAppointmentsForClient();
      return bookings;
    } catch (e) {
      _showErrorSnackBar(context, "Error fetching upcoming appointments for client: $e");
      print(e);
      return [];
    }
  }

  // Get a booking by its ID
  Future<Appointment?> getBookingById(BuildContext context, String bookingId) async {
    try {
      return await _appointmentService.getBookingById(bookingId);
    } catch (e) {
      _showErrorSnackBar(context, "Error fetching booking by ID: $e");
      return null;
    }
  }
}
