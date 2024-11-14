import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entities/appointments.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Save a new booking
  Future<void> saveBooking(Appointment appointment) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;
    try {
      await _firestore.collection('Bookings').add({
        ...appointment.toMap(),
        'userID': userID,
      });
    } catch (e) {
      throw Exception("Error saving booking: $e");
    }
  }

  // Get all bookings for a client
  Future<List<Appointment>> getBookingsForClient(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching bookings for client: $e");
    }
  }

  // Get all bookings for a therapist
  Future<List<Appointment>> getBookingsForTherapist(String therapistId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('therapistId', isEqualTo: therapistId)
          .get();
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching bookings for therapist: $e");
    }
  }

  // Delete a booking by ID
  Future<void> deleteBooking(String bookingId) async {
    try {
      await _firestore.collection('Bookings').doc(bookingId).delete();
    } catch (e) {
      throw Exception("Error deleting booking: $e");
    }
  }

  // Reschedule an appointment
  Future<void> rescheduleBooking(String bookingId, DateTime newDateTime) async {
    try {
      await _firestore.collection('Bookings').doc(bookingId).update({
        'appointmentDate': newDateTime.toIso8601String(),
      });
    } catch (e) {
      throw Exception("Error rescheduling booking: $e");
    }
  }

  // Get all bookings within a specific date range
  Future<List<Appointment>> getBookingsInRange(DateTime startDate, DateTime endDate) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('appointmentDate', isGreaterThanOrEqualTo: startDate.toIso8601String())
          .where('appointmentDate', isLessThanOrEqualTo: endDate.toIso8601String())
          .get();
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching bookings in date range: $e");
    }
  }

  // Check availability for a specific time slot
  Future<bool> isTimeSlotAvailable(String therapistId, DateTime dateTime) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('therapistId', isEqualTo: therapistId)
          .where('appointmentDate', isEqualTo: dateTime.toIso8601String())
          .get();
      return snapshot.docs.isEmpty; // If no bookings exist for this slot, it is available
    } catch (e) {
      throw Exception("Error checking time slot availability: $e");
    }
  }

  // Get bookings by status
  Future<List<Appointment>> getBookingsByStatus(AppointmentStatus status) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('status', isEqualTo: status.toString().split('.').last)
          .get();
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching bookings by status: $e");
    }
  }

  // Get upcoming bookings for a client
  Future<List<Appointment>> getUpcomingAppointmentsForClient(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('userId', isEqualTo: userId)
          .where('appointmentDate', isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
          .get();
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching upcoming appointments for client: $e");
    }
  }

  // Count upcoming appointments for a therapist
  Future<int> countUpcomingAppointmentsForTherapist(String therapistId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('therapistId', isEqualTo: therapistId)
          .where('appointmentDate', isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
          .get();
      return snapshot.docs.length; // Count how many upcoming appointments
    } catch (e) {
      throw Exception("Error counting upcoming appointments for therapist: $e");
    }
  }

  // Get a booking by its ID
  Future<Appointment> getBookingById(String bookingId) async {
    try {
      final DocumentSnapshot snapshot = await _firestore
          .collection('Bookings')
          .doc(bookingId)
          .get();
      if (snapshot.exists) {
        return Appointment.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("Booking not found");
      }
    } catch (e) {
      throw Exception("Error fetching booking by ID: $e");
    }
  }
}