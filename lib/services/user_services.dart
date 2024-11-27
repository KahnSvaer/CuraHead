import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _ensureUserDocumentExists() async {
    if (userID == null) {
      throw Exception("User is not authenticated.");
    }
    final userRef = _firestore.collection('Users').doc(userID);

    try {
      final userSnapshot = await userRef.get();
      if (!userSnapshot.exists) {
        await userRef.set({
          'chatIDs': [],
          'assessmentIDs': [],
          'appointmentIDs': [],
        });
      }
    } catch (e) {
      throw Exception("Error ensuring user document exists: $e");
    }
  }

  Future<void> _updateUserField(String field, String id, bool isAdd) async {
    if (userID == null) {
      throw Exception("User is not authenticated.");
    }

    await _ensureUserDocumentExists();  // Ensure the document exists first

    final userRef = _firestore.collection('Users').doc(userID);

    try {
      final fieldUpdate = isAdd
          ? FieldValue.arrayUnion([id])
          : FieldValue.arrayRemove([id]);

      await userRef.update({
        field: fieldUpdate,
      });
    } catch (e) {
      throw Exception("Error updating user $field: $e");
    }
  }

  Future<void> addChatID(String chatID) async {
    _updateUserField('chatIDs', chatID, true);
    print("New Chat Added");
  }

  Future<void> addAssessmentID(String assessmentID) async => _updateUserField('assessmentIDs', assessmentID, true);

  Future<void> addAppointmentID(String appointmentID) async => _updateUserField('appointmentIDs', appointmentID, true);

  Future<void> removeChatID(String chatID) async => _updateUserField('chatIDs', chatID, false);

  Future<void> removeAssessmentID(String assessmentID) async => _updateUserField('assessmentIDs', assessmentID, false);

  Future<void> removeAppointmentID(String appointmentID) async => _updateUserField('appointmentIDs', appointmentID, false);

  // Real-time listener for chat IDs
  Stream<List<String>> listenToChatIDs() {
    if (userID == null) {
      throw Exception("User is not authenticated.");
    }

    final userRef = _firestore.collection('Users').doc(userID);

    return userRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return List<String>.from(data['chatIDs'] ?? []);
      } else {
        return [];
      }
    });
  }

  Future<List<String>> _getIDs(String field) async {
    if (userID == null) {
      throw Exception("User is not authenticated.");
    }

    await _ensureUserDocumentExists();  // Ensure the document exists first

    try {
      final userSnapshot = await _firestore.collection('Users').doc(userID).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        return List<String>.from(data[field] ?? []);
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching $field: $e");
    }
  }

  Future<List<String>> getChatIDs() async => _getIDs('chatIDs');

  Future<List<String>> getAssessmentIDs() async => _getIDs('assessmentIDs');

  Future<List<String>> getAppointmentIDs() async => _getIDs('appointmentIDs');
}
