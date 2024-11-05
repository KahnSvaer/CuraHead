import 'package:curahead_app/entities/user.dart';

class Therapist extends User {
  final String licenseNumber;
  final List<String> specialties;
  final String qualifications;
  final String contactNumber;
  final double rating; // Changed from Float to double
  final String hospital; // Added hospital field
  final String details; // Added details field
  final int patientsNum; // Added number of patients field
  final int experience; // Added experience field
  final int numComments;
  final String imageURL; // Added number of comments field

  Therapist({
    required super.uid,
    required super.displayName,
    required super.email,
    required super.phoneNumber,
    super.role = UserRole.therapist,
    required this.licenseNumber,
    required this.specialties,
    this.qualifications = "PHD",
    required this.contactNumber,
    this.rating = 5,
    required this.hospital,
    required this.details,
    this.patientsNum = 0,
    this.experience = 0,
    this.numComments = 0,
    this.imageURL = 'https://via.placeholder.com/150'
  });

  // Would later use this to find therapist from database directly
  Therapist.withId(String uid)
      : this(
    uid: uid,
    displayName: 'John Doe',
    email: '',
    phoneNumber: '',
    role: UserRole.therapist,
    licenseNumber: '',
    specialties: [],
    qualifications: "PHD",
    contactNumber: '+0001234567891',
    rating: 5,
    hospital: 'ABC Hospital',
    details: '',
    patientsNum: 0,
    experience: 0,
    numComments: 0,
    imageURL: 'https://via.placeholder.com/150',
  );

  // Factory constructor for creating a Therapist from a Map
  factory Therapist.fromMap(Map<String, dynamic> data) {
    return Therapist(
      uid: data['uid'],
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      role: data['role'] != null
          ? UserRole.values.firstWhere((e) => e.toString() == data['role'])
          : UserRole.therapist,
      licenseNumber: data['licenseNumber'] ?? '',
      specialties: List<String>.from(data['specialties'] ?? []),
      qualifications: data['qualifications'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0, // Ensure rating is a double
      hospital: data['hospital'] ?? '',
      details: data['details'] ?? '',
      patientsNum: data['patientsNum'] ?? 0,
      experience: data['experience'] ?? 0,
      numComments: data['numComments'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'licenseNumber': licenseNumber,
      'specialties': specialties,
      'qualifications': qualifications,
      'contactNumber': contactNumber,
      'rating': rating,
      'hospital': hospital,
      'details': details,
      'patientsNum': patientsNum,
      'experience': experience,
      'numComments': numComments,
    });
    return map;
  }

}
