import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/user_services.dart';
import '../entities/appointments.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();  // Instance of UserService

  // Save a new booking
  Future<void> saveBooking(Appointment appointment) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;

    try {
      DocumentReference bookingRef = await _firestore.collection('Bookings').add({
        ...appointment.toMap(),
        'userID': userID,
      });

      // Add the appointment ID to the user's appointment list
      if (userID != null) {
        await _userService.addAppointmentID(bookingRef.id);  // Assuming appointment has an ID field
        print('Booking Added');
      }
    } catch (e) {
      throw Exception("Error saving booking: $e");
    }
  }

  Future<List<Appointment>> getBookingsForClient() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;

    if (userID == null) {
      throw Exception("User is not authenticated.");
    }

    try {
      List<String> appointmentIDs = await _userService.getAppointmentIDs();

      if (appointmentIDs.isEmpty) {
        return [];
      }

      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where(FieldPath.documentId, whereIn: appointmentIDs)  // Get bookings where the ID matches one of the appointmentIDs
          .where('userID', isEqualTo: userID)
          .get();

      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching bookings for client: $e");
    }
  }

  // Delete a booking by ID
  Future<void> deleteBooking(String bookingId) async {
    try {
      // Delete the appointment from the 'Bookings' collection
      await _firestore.collection('Bookings').doc(bookingId).delete();

      // Remove the appointment ID from the user's appointment list
      await _userService.removeAppointmentID(bookingId);
    } catch (e) {
      throw Exception("Error deleting booking: $e");
    }
  }

  // Reschedule an appointment
  Future<void> rescheduleBooking(String bookingId, Timestamp newDateTime) async {
    try {
      await _firestore.collection('Bookings').doc(bookingId).update({
        'appointmentDate': newDateTime,
      });
    } catch (e) {
      throw Exception("Error rescheduling booking: $e");
    }
  }

  // Check availability for a specific time slot
  Future<bool> isTimeSlotAvailable(String therapistId, Timestamp timeStamp) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where('therapistId', isEqualTo: therapistId)
          .where('appointmentDate', isEqualTo: timeStamp)
          .get();
      return snapshot.docs.isEmpty; // If no bookings exist for this slot, it is available
    } catch (e) {
      throw Exception("Error checking time slot availability: $e");
    }
  }


  // Get upcoming bookings for a client
  Future<List<Appointment>> getUpcomingAppointmentsForClient() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;

    if (userID == null) {
      throw Exception("User is not authenticated.");
    }

    try {
      List<String> appointmentIDs = await _userService.getAppointmentIDs();

      if (appointmentIDs.isEmpty){
        return [];
      }

      final QuerySnapshot snapshot = await _firestore
          .collection('Bookings')
          .where(FieldPath.documentId, whereIn: appointmentIDs)
          .where('userID', isEqualTo: userID)
          .get();

      // Code to filter out the appointments
      List<Appointment> upcomingAppointments = [];
      DateTime now = DateTime.now();
      for (var doc in snapshot.docs) {
        var timestamp = doc['appointmentDateTime'];
        if (timestamp is Timestamp) {
          DateTime appointmentDateTime = timestamp.toDate();
          if (appointmentDateTime.isAfter(now)) {
            upcomingAppointments.add(Appointment.fromMap(doc.data() as Map<String, dynamic>));
          }
        }
      }
      upcomingAppointments.sort((a, b) {
        return a.appointmentDateTime.compareTo(b.appointmentDateTime);
      });

      return upcomingAppointments;
    } catch (e) {
      throw Exception("Error fetching upcoming appointments for client: $e");
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
