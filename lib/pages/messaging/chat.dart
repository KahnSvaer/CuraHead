import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../../entities/user.dart';

class ChatPage extends StatefulWidget {
  final User user;
  final String chatId;

  const ChatPage({
    super.key,
    required this.user,
    required this.chatId,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final message = {
        "text": _messageController.text,
        "senderId": widget.user.uid,
        "time": FieldValue.serverTimestamp(),  // Firestore timestamp for real-time updates
      };
      // Send the message to Firestore under the specific chat
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .add(message);  // Add message to Firestore
      _messageController.clear();
    }
  }

  void _selectFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gallery selection not implemented')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.displayName.isNotEmpty ? widget.user.displayName : 'Chat'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // Close keyboard when tapping outside of the text field
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    .orderBy('time')  // Sort messages by timestamp
                    .snapshots(),  // Listen to real-time updates
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages'));
                  } else {
                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final messageText = message['text'];
                        final messageTime = message['time']?.toDate();
                        final senderId = message['senderId'];
                        final isSentByUser = senderId == widget.user.uid;

                        return MessageWidget(
                          messageText: messageText,
                          messageTime: messageTime != null ? messageTime.toString() : 'N/A',
                          isSentByUser: isSentByUser,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: _selectFromGallery,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter message',
                        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String messageText;
  final String messageTime;
  final bool isSentByUser;

  const MessageWidget({
    super.key,
    required this.messageText,
    required this.messageTime,
    required this.isSentByUser,
  });

  @override
  Widget build(BuildContext context) {
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
