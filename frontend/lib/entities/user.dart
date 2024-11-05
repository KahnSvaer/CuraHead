enum UserRole {
  therapist,
  patient,
}

class User {
  final String uid;
  final String email;
  final String displayName;
  final String phoneNumber;
  final String imageURL;
  UserRole role;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
    this.role = UserRole.patient,
    this.imageURL = 'https://via.placeholder.com/150',
  });

  User.withId(String uid)
      : this(
    uid: uid,
    displayName: 'John Doe',
    email: '',
    phoneNumber: '',
    role: UserRole.therapist,
    imageURL: 'https://via.placeholder.com/150',
  );

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      role: UserRole.values.firstWhere(
            (e) => e.toString() == 'UserRole.${map['role']}',
        orElse: () => UserRole.patient,
      ),
      imageURL: 'https://via.placeholder.com/150',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'role': role.toString().split('.').last, // Save as string ("therapist" or "patient")
    };
  }
}
