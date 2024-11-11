import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final String type; // "text", "image", "file", etc.

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.type,
  });

  // Convert a Firestore document to a Message instance
  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      timestamp: ((data['timestamp'] as Timestamp?) ?? Timestamp.now()).toDate().toLocal(),
      type: data['type'] ?? 'text',  // Default to "text"
    );
  }

  // Convert Message instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'type': type,
    };
  }
}
