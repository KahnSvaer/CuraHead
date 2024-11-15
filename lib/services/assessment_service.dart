import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/assessment.dart';

class AssessmentService {
  final CollectionReference _assessmentCollection = FirebaseFirestore.instance.collection('Assessments');

  Future<void> saveSession(AssessmentSession session) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;
    try {
      await _assessmentCollection.add({...session.toMap(), 'userID': userID,});
      print('Assessment session saved successfully.');
    } catch (e) {
      print('Error saving assessment session: $e');
    }
  }

  Future<List<AssessmentSession>> getUserAssessments() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;
    try {
      QuerySnapshot snapshot = await _assessmentCollection
          .where('userID', isEqualTo: userID)
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
