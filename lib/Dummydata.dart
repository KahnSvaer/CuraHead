import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curahead_app/services/therapist_service.dart';
import 'entities/therapist.dart';
import 'entities/user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TherapistApp());
}

class DummyTherapistData {
  // List to store dummy therapists
  final List<Therapist> therapists = [];

  // Constructor to initialize and add dummy data
  DummyTherapistData() {
    // Adding dummy therapists to the list
    therapists.addAll([
      Therapist(
        displayName: "Anam",
        email: "anam@example.com",
        phoneNumber: "+91-9876543210",
        imageURL: 'https://media.istockphoto.com/id/1367507209/photo/portrait-of-indian-female-doctor-stock-photo.jpg?s=612x612&w=0&k=20&c=mI-MPGA_bHBLK9D77v8shYOZdI7Pqnlh2_xJE00tUHM=',
        role: UserRole.therapist,
        licenseNumber: "LIC12345",
        specialties: ["Clinical Psychology", "Stress Management"],
        qualifications: "M.A. (Clinical Psychology), B.A. (Psychology Hons.)",
        contactNumber: "+91-1234567890",
        rating: 4.5,
        hospital: "Therapists Clinic",
        details: "Senior Therapist with 4 years of experience in stress management and counseling.",
        patientsNum: 50,
        experience: 4,
        numComments: 20,
      ),
      Therapist(
        displayName: "Rohan Mehta",
        email: "rohan.mehta@example.com",
        phoneNumber: "+91-9988776655",
        imageURL: 'https://media.istockphoto.com/id/1158000367/photo/indian-young-doctor-stock-images.jpg?s=612x612&w=0&k=20&c=EwtFEEXDNnTMZQ9bi28ykF0hZG2YsCa_LfBSaDOKJYQ=',
        role: UserRole.therapist,
        licenseNumber: "LIC67890",
        specialties: ["Counseling Psychology", "Behavioral Therapy"],
        qualifications: "Ph.D. (Psychology), M.A. (Counseling Psychology)",
        contactNumber: "+91-5566778899",
        rating: 4.8,
        hospital: "Clinical Minds",
        details: "Lead Psychologist with 10 years of experience in counseling and behavioral therapy.",
        patientsNum: 120,
        experience: 10,
        numComments: 45,
      ),
      Therapist(
        displayName: "Priya Sharma",
        email: "priya.sharma@example.com",
        phoneNumber: "+91-9876543211",
        imageURL: 'https://media.istockphoto.com/id/671290874/photo/portrait-of-a-female-doctor.jpg?s=612x612&w=0&k=20&c=mQXp_gLFIN2YyyO_hlLc0VFlAYfbHiHK6lroJp0dtVw=',
        role: UserRole.therapist,
        licenseNumber: "LIC34567",
        specialties: ["Applied Psychology", "Child Psychology"],
        qualifications: "M.Sc. (Applied Psychology), B.Sc. (Psychology)",
        contactNumber: "+91-1122334455",
        rating: 4.6,
        hospital: "Counseling Hub",
        details: "Child Psychologist with 6 years of experience in child development and family counseling.",
        patientsNum: 80,
        experience: 6,
        numComments: 30,
      ),
      Therapist(
        displayName: "Kavita Patel",
        email: "kavita.patel@example.com",
        phoneNumber: "+91-7766554433",
        imageURL: 'https://media.istockphoto.com/id/177362371/photo/indian-female-doctor.jpg?s=612x612&w=0&k=20&c=78RiEklk7_aYDchYy-m7y1Guu4vagCHhvH7tjf5495s=',
        role: UserRole.therapist,
        licenseNumber: "LIC98765",
        specialties: ["Therapeutic Intervention", "Family Counseling"],
        qualifications: "M.A. (Psychology), B.A. (Psychology Hons.)",
        contactNumber: "+91-2233445566",
        rating: 4.2,
        hospital: "Therapists Collective",
        details: "Therapist specializing in family counseling with 3 years of experience.",
        patientsNum: 40,
        experience: 3,
        numComments: 15,
      ),
      Therapist(
        displayName: "Rajesh Kumar",
        email: "rajesh.kumar@example.com",
        phoneNumber: "+91-6655443322",
        imageURL: 'https://media.istockphoto.com/id/1298780374/photo/senior-male-doctor-looking-at-camera.jpg?s=612x612&w=0&k=20&c=OoFVt2BfRXmBXMyr_EknEpZOjij-T9Gp3FFVIMW_ix0=',
        role: UserRole.therapist,
        licenseNumber: "LIC45678",
        specialties: ["Clinical Psychology", "Anxiety Management"],
        qualifications: "M.Phil (Clinical Psychology), M.A. (Psychology)",
        contactNumber: "+91-3344556677",
        rating: 4.7,
        hospital: "Mind Care Center",
        details: "Senior Consultant with 8 years of experience in anxiety and stress management.",
        patientsNum: 100,
        experience: 8,
        numComments: 35,
      ),
      Therapist(
        displayName: "Aditi Mehta",
        email: "aditi.mehta@example.com",
        phoneNumber: "+91-9988776655",
        imageURL: 'https://media.istockphoto.com/id/1398828096/photo/portrait-of-a-young-indian-doctor-wearing-a-stethoscope-sitting-in-a-office-writing-a.jpg?s=612x612&w=0&k=20&c=JHRk3XilS2_pzTTcuozuVTX49I7AXuI8vN_NjHJQ04w=',
        role: UserRole.therapist,
        licenseNumber: "LIC22345",
        specialties: ["Counseling Psychology", "Behavioral Therapy"],
        qualifications: "Ph.D. (Psychology), M.A. (Counseling Psychology)",
        contactNumber: "+91-5566778899",
        rating: 4.9,
        hospital: "Therapists Clinic",
        details: "Experienced therapist specializing in anxiety and depression counseling.",
        patientsNum: 75,
        experience: 7,
        numComments: 40,
      ),
      Therapist(
        displayName: "Sanya Kapoor",
        email: "sanya.kapoor@example.com",
        phoneNumber: "+91-9765432100",
        imageURL: 'https://media.istockphoto.com/id/1327024466/photo/portrait-of-male-doctor-in-white-coat-and-stethoscope-standing-in-clinic-hall.jpg?s=612x612&w=0&k=20&c=49wqOwwuonk9f8NACL7M_5RosqQPFwJ8-dpmeo9AvQw=',
        role: UserRole.therapist,
        licenseNumber: "LIC23456",
        specialties: ["Psychotherapy", "Trauma Counseling"],
        qualifications: "M.A. (Psychology), B.A. (Psychology)",
        contactNumber: "+91-3322114455",
        rating: 4.6,
        hospital: "Healing Touch Center",
        details: "Specializes in trauma recovery with 8 years of experience in psychotherapy.",
        patientsNum: 95,
        experience: 8,
        numComments: 50,
      ),
      Therapist(
        displayName: "Tanya Reddy",
        email: "tanya.reddy@example.com",
        phoneNumber: "+91-8776655443",
        imageURL: 'https://media.istockphoto.com/id/177373093/photo/indian-male-doctor.jpg?s=612x612&w=0&k=20&c=5FkfKdCYERkAg65cQtdqeO_D0JMv6vrEdPw3mX1Lkfg=',
        role: UserRole.therapist,
        licenseNumber: "LIC67891",
        specialties: ["Marriage Counseling", "Relationship Therapy"],
        qualifications: "M.A. (Marriage Counseling), B.A. (Psychology)",
        contactNumber: "+91-9988776612",
        rating: 4.4,
        hospital: "Counseling Center",
        details: "Certified marriage counselor with 5 years of experience.",
        patientsNum: 65,
        experience: 5,
        numComments: 25,
      ),
      Therapist(
        displayName: "Neha Joshi",
        email: "neha.joshi@example.com",
        phoneNumber: "+91-8887776655",
        imageURL: 'https://media.istockphoto.com/id/1614145147/photo/young-positive-indian-male-doctor-wearing-stethoscope-showing-smart-phone-with-blank-display.jpg?s=612x612&w=0&k=20&c=l7MSohy5RHs8d7rxvmp8TBUAQj_QCCtstZ6ga3HeUSE=',
        role: UserRole.therapist,
        licenseNumber: "LIC98765",
        specialties: ["Clinical Psychology", "Depression Management"],
        qualifications: "M.Phil (Psychology), B.A. (Psychology)",
        contactNumber: "+91-3344557788",
        rating: 4.7,
        hospital: "Healing Minds",
        details: "Psychologist with 6 years of experience specializing in depression and anxiety.",
        patientsNum: 80,
        experience: 6,
        numComments: 40,
      ),
      Therapist(
        displayName: "Siddhi Verma",
        email: "siddhi.verma@example.com",
        phoneNumber: "+91-7008809988",
        imageURL: 'https://media.istockphoto.com/id/1212177444/photo/happy-male-doctor-of-indian-ethnicity.jpg?s=612x612&w=0&k=20&c=q5Hv1bcmMOiocprvNxpQgtqcbNcPltBnhZILdUE8BjQ=',
        role: UserRole.therapist,
        licenseNumber: "LIC12345",
        specialties: ["Therapeutic Counseling", "Grief Therapy"],
        qualifications: "M.A. (Counseling Psychology), B.A. (Psychology)",
        contactNumber: "+91-4455667788",
        rating: 4.8,
        hospital: "Counseling Institute",
        details: "Grief therapist with over 7 years of experience in supporting individuals through loss.",
        patientsNum: 100,
        experience: 7,
        numComments: 50,
      ),
      Therapist(
        displayName: "Rina Khanna",
        email: "rina.khanna@example.com",
        phoneNumber: "+91-8899006677",
        imageURL: 'https://media.istockphoto.com/id/1367507209/photo/portrait-of-indian-female-doctor-stock-photo.jpg?s=612x612&w=0&k=20&c=mI-MPGA_bHBLK9D77v8shYOZdI7Pqnlh2_xJE00tUHM=',
        role: UserRole.therapist,
        licenseNumber: "LIC22345",
        specialties: ["Behavioral Therapy", "Child Development"],
        qualifications: "M.Sc. (Clinical Psychology), B.A. (Psychology)",
        contactNumber: "+91-1122334455",
        rating: 4.6,
        hospital: "Healing Minds Center",
        details: "Specializing in child development and behavioral therapy.",
        patientsNum: 85,
        experience: 5,
        numComments: 25,
      ),
    ]);

    // Add these therapists to the service
    _addTherapistsToService();
  }

  // Private method to add therapists to TherapistService
  void _addTherapistsToService() {
    final therapistService = TherapistService();
    therapistService.addDummyTherapists(therapists);
  }

  // Method to display all therapists in the console
  void displayTherapists() {
    if (therapists.isEmpty) {
      print("No therapists available.");
      return;
    }
    for (var therapist in therapists) {
      print(
          "Name: ${therapist.displayName}, Specialty: ${therapist.specialties.join(', ')}");
    }
  }
}


class TherapistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Therapists List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TherapistListPage(),
    );
  }
}

class TherapistListPage extends StatelessWidget {
  final TherapistService therapistService = TherapistService();

  TherapistListPage() {
    // Add dummy data on initialization
    DummyTherapistData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapists'),
      ),
      body: FutureBuilder<List<Therapist>>(
        future: therapistService.getTherapists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No therapists available.'));
          }

          final therapists = snapshot.data!;

          return ListView.builder(
            itemCount: therapists.length,
            itemBuilder: (context, index) {
              final therapist = therapists[index];
              return TherapistCard(therapist: therapist);
            },
          );
        },
      ),
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(therapist.imageURL),
        ),
        title: Text(therapist.displayName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Specialties: ${therapist.specialties.join(', ')}\n'
            'Rating: ${therapist.rating.toStringAsFixed(1)} ★'),
        isThreeLine: true,
        onTap: () {
          // Navigate to therapist details or perform any action
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(therapist.displayName),
              content: Text(therapist.details),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

