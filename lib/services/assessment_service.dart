import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/assessment.dart';
import 'user_services.dart';

class AssessmentService {
  final CollectionReference _assessmentCollection = FirebaseFirestore.instance.collection('Assessments');

  Future<void> saveSession(AssessmentSession session) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;
    try {
      DocumentReference assessmentRef = await _assessmentCollection.add({...session.toMap(), 'userID': userID});

      await UserService().addAssessmentID(assessmentRef.id);

      print('Assessment session saved successfully.');
    } catch (e) {
      print('Error saving assessment session: $e');
    }
  }

  // Get all assessments for the current user by looking up their assessmentIDs
  Future<List<AssessmentSession>> getUserAssessments() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;
    try {

      List<String> assessmentIDs = await UserService().getAssessmentIDs();
      if (assessmentIDs.isEmpty) {
        print('No assessments found for this user.');
        return [];
      }

      // Fetch all assessments based on the stored assessmentIDs
      QuerySnapshot snapshot = await _assessmentCollection
          .where(FieldPath.documentId, whereIn: assessmentIDs)
          .get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return AssessmentSession.fromMap(data);
      }).toList();
    } catch (e) {
      print('Error retrieving assessments for userID $userID: $e');
      return [];
    }
  }
}
