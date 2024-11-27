import 'package:curahead_app/state_management/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/chat_controller.dart';
import '../../entities/chat.dart';
import '../../entities/message.dart';
import '../../entities/therapist.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;


  const ChatPage({super.key, required this.chat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage(String senderID) {
    if (_messageController.text.trim().isNotEmpty && widget.chat.chatId != null) {
      final chatController = Provider.of<ChatController>(context, listen: false);
      chatController.sendMessage(
        widget.chat.chatId!,
        Message(
          text: _messageController.text,
          senderId: senderID,
          localDateTime: DateTime.now(),
          type: 'Text',
        ),
      );
      _messageController.clear();
    }else{
      print("ChatID still null");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserID = Provider.of<AuthProvider>(context).currentUser?.uid;
    final therapistID = widget.chat.participants.firstWhere((id) => id != currentUserID!);
    final chatController = Provider.of<ChatController>(context);

    String? chatID = widget.chat.chatId;

    return Scaffold(
      appBar: AppBar(title: Text(Therapist.withId(therapistID).displayName), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: chatController.listenToMessages(chatID!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageWidget(
                        message: message,
                        currentUserID: currentUserID!,
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: () => _sendMessage(currentUserID!)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;
  final String currentUserID;

  const MessageWidget({
    super.key,
    required this.message,
    required this.currentUserID,
  });

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    // Determine AM or PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;  // Handle 12:00 PM and 12:00 AM case

    // Format minute to always show two digits
    String minuteStr = minute < 10 ? '0$minute' : '$minute';

    return '$hour:$minuteStr $period';
  }

  @override
  Widget build(BuildContext context) {
    final String messageText = message.text;
    String messageTime = _formatTime(message.localDateTime);
    final bool isSentByUser = message.senderId == currentUserID;
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isSentByUser ? Colors.blue.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: (isSentByUser)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: (isSentByUser)
                  ? const EdgeInsets.only(right: 16)
                  : const EdgeInsets.only(left: 16),
              child: Text(
                messageText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              messageTime,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
