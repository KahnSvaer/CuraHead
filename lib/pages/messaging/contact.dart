import 'package:curahead_app/state_management/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/chat_controller.dart';
import '../../entities/chat.dart';
import '../../entities/message.dart';
import '../../entities/therapist.dart';
import '../../services/chat_firestore_service.dart';
import 'chat.dart';
import '../../widgets/profile_image.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts'), centerTitle: true),
      body: StreamBuilder<List<Chat>>(
        stream: chatController.chatsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts available'));
          } else {
            final contacts = snapshot.data!;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final chat = contacts[index];


                return ContactButton(chat: chat);
              },
            );
          }
        },
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final Chat chat;

  const ContactButton({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ChatService();
    final currentUserID = Provider.of<AuthProvider>(context).currentUser?.uid;
    final therapistID = chat.participants.firstWhere((id) => id != currentUserID!);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChatPage(chat: chat,)),
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
            ProfileImage(user: Therapist.withId(therapistID), radius: 20.0),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Therapist.withId(therapistID).displayName,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            // Display last message using Stream
            StreamBuilder<List<Message>>(
              stream: chatService.listenToChatMessages(chat.chatId!), // Listening to the messages in the chat
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
