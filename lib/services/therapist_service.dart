import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curahead_app/entities/therapist.dart';

class TherapistService {
  final CollectionReference _therapistsCollection =
  FirebaseFirestore.instance.collection('Therapists');

  // Add a list of dummy therapists
  Future<void> addDummyTherapists(List<Therapist> dummyTherapists) async {
    for (var therapist in dummyTherapists) {
      await _therapistsCollection
          .doc(therapist.uid) // Set uid as the document ID
          .set(therapist.toMap());
    }
  }

  Future<List<Therapist>> getTherapists() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Therapists').get();

      if (snapshot.docs.isEmpty) {
        return []; // Return an empty list if no therapists are found.
      }

      // Map the documents to a list of Therapist objects
      return snapshot.docs.map((doc) {
        return Therapist.fromMap({
          ...doc.data(), // Document fields
          'uid': doc.id,
          'imageURL': '',// Include the document ID as 'uid'
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch therapists: $e');
    }
  }

  // Retrieve a single therapist by therapistID
  Future<Therapist?> getTherapistById(String therapistID) async {
    final docSnapshot = await _therapistsCollection.doc(therapistID).get();
    if (docSnapshot.exists) {
      return Therapist.fromMap({
        ...docSnapshot.data() as Map<String, dynamic>,
        'uid': docSnapshot.id, // Include the document ID as uid
      });
    }
    return null;
  }
}
