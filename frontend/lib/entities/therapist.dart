
import 'package:curahead_app/entities/user.dart';

class Therapist extends User {
  final String licenseNumber;
  final List<String> specialties;
  final String qualifications;
  final String contactNumber;

  Therapist({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required super.createdAt,
    required super.updatedAt,
    required this.licenseNumber,
    required this.specialties,
    required this.qualifications,
    required this.contactNumber,
  });

  // Additional methods specific to Therapist can be added here
  factory Therapist.fromMap(Map<String, dynamic> data) {
    return Therapist(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: data['role'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      licenseNumber: data['licenseNumber'],
      specialties: List<String>.from(data['specialties']),
      qualifications: data['qualifications'],
      contactNumber: data['contactNumber'],
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
    });
    return map;
  }
}
