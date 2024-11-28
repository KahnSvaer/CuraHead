import 'package:flutter/material.dart';
import '../entities/therapist.dart';
import '../services/therapist_service.dart';
import '../widgets/search_bar.dart';
import '../widgets/therapist_card.dart';

class TherapistPage extends StatefulWidget {
  const TherapistPage({super.key});

  @override
  _TherapistPageState createState() => _TherapistPageState();
}

class _TherapistPageState extends State<TherapistPage> {
  late Future<List<Therapist>> _therapistsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch therapists from the service
    _therapistsFuture = TherapistService().getTherapists();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          padding: EdgeInsets.all(10),
          child: Column(
            children: const [
              SizedBox(height: 15),
              SearchWidget(showLast: true),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xfff4f6ff),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: FutureBuilder<List<Therapist>>(
              future: _therapistsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a circular loading indicator while data is loading
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // Display error message if there is an error
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Display a message if no therapists are available
                  return Center(
                    child: Text('No therapists available.'),
                  );
                }

                final therapists = snapshot.data!;
                return ListView.builder(
                  itemCount: therapists.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TherapistCard(therapist: therapists[index]),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
