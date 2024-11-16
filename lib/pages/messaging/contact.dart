import 'package:curahead_app/entities/chat.dart';
import 'package:curahead_app/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import provider
import '../../entities/user.dart';
import '../../widgets/profile_image.dart';
import 'chat.dart';
import '../../services/chat_firestore_service.dart';

class ContactListPage extends StatelessWidget {
  ContactListPage({super.key});

  final ChatService _chatService = ChatService(); // Service for chat functionality

  @override
  Widget build(BuildContext context) {
    // Access current user from provider
    final User currentUser = Provider.of<User>(context, listen: false); // Use provider to get user info

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Chat>>(
        stream: _chatService.listenToChats(currentUser.uid), // Stream for fetching chats involving the current user
        builder: (context, contactsSnapshot) {
          if (contactsSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (contactsSnapshot.hasError) {
            return Center(child: Text('Error: ${contactsSnapshot.error}'));
          } else if (!contactsSnapshot.hasData || contactsSnapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts available'));
          } else {
            final contacts = contactsSnapshot.data!;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final chat = contacts[index];
                final otherParticipant = chat.participants
                    .firstWhere((participant) => participant != currentUser.uid); // Get the other participant
                final user = User(uid: otherParticipant, displayName: "", email: '', phoneNumber: ''); // Assuming you can fetch user details here
                return ContactButton(user: user, chatId: chat.chatId!);
              },
            );
          }
        },
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final User user;
  final String chatId;

  const ContactButton({required this.user, required this.chatId, super.key});

  @override
  Widget build(BuildContext context) {
    String name = user.displayName;
    final ChatService chatService = ChatService();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChatPage(user: user, chatId: chatId)),
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
            // Display last message using Stream
            StreamBuilder<List<Message>>(
              stream: chatService.listenToChatMessages(chatId), // Listening to the messages in the chat
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No messages');
                } else {
                  final lastMessage = snapshot.data!.last; // Fetch last message
                  return Text(
                    lastMessage.text,
                    style: const TextStyle(color: Colors.grey),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
