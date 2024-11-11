import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  late final String? chatId;
  final List<String> participants;  // List of user IDs in the chat
  final String lastMessage;
  final Timestamp lastUpdated;

  Chat({
    this.chatId,
    required this.participants,
    this.lastMessage = "",
    Timestamp? lastUpdated,
  }) : lastUpdated = lastUpdated ?? Timestamp.now(); // Corrected null check for lastUpdated


  // Convert a Firestore document to a Chat instance
  factory Chat.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Chat(
      chatId: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastUpdated: data['lastUpdated'] ?? Timestamp.now(),
    );
  }

  // Convert Chat instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessage': lastMessage,
      'lastUpdated': lastUpdated,
    };
  }
}
