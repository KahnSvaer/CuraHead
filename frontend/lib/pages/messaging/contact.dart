import 'chat.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

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
          return ContactButton(name: contacts[index]);
        },
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final String name;

  const ContactButton({required this.name, super.key});

  Color _getRandomColor(String name) {
    final int hash = name.hashCode;
    final int red = (hash & 0xFF0000) >> 16;
    final int green = (hash & 0x00FF00) >> 8;
    final int blue = (hash & 0x0000FF);
    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ChatPage(contact: name))
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
            CircleAvatar(
              backgroundColor: _getRandomColor(name),
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
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


