import 'package:curahead_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String contact;

  const ChatPage({
    super.key,
    this.contact = "",
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _messageController.text,
          "time": TimeOfDay.now().format(context),
          "isSentByUser": true,  // Assuming all messages are sent by user in this example
        });
      });
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
        title: Text(widget.contact.isNotEmpty ? widget.contact : 'Chat'),
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
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageWidget(
                    messageText: message["text"],
                    messageTime: message["time"],
                    isSentByUser: message["isSentByUser"],
                  );
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
                          borderRadius: BorderRadius.circular(12.0), // Rounded border
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
          maxWidth: MediaQuery.of(context).size.width * 0.7, // Limit width to 70% of screen width
        ),
        decoration: BoxDecoration(
          color: isSentByUser ? Colors.blue.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: (isSentByUser)?
            CrossAxisAlignment.end : CrossAxisAlignment.start ,
          children: [
            // Wrap the message text in Padding with dynamic padding based on sender
            Padding(
              padding: (isSentByUser)?
                const EdgeInsets.only(right: 16) : const EdgeInsets.only(left: 16),
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



