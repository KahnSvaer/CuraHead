import 'package:flutter/material.dart';
import '../../entities/user.dart';
import '../../widgets/profile_image.dart';
import 'chat.dart';

class ContactListPage extends StatelessWidget {
  ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> contacts = [
      "Alice",
      "Bob",
      "Charlie",
      "David",
      "Eve"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactButton(user: User(uid: "", email: "", displayName: contacts[index], phoneNumber: ""));
        },
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final User user;

  const ContactButton({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    String name = user.displayName;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChatPage(user: user)),
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          children: [
            ProfileImage(user: user, radius: 20.0),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


