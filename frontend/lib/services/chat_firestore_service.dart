import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

class ChatService {
  // Collection reference for chats
  final CollectionReference chatsRef = FirebaseFirestore.instance.collection('chats');

  // Chat creation
  Future<void> createChat(Chat chatData) async {
    try {
      DocumentReference newChatRef = await chatsRef.add(chatData.toMap());

      await newChatRef.update({'chatId': newChatRef.id});
      chatData.chatId = newChatRef.id; // Final set for chatId in chatData, no further changes

      CollectionReference messagesRef = newChatRef.collection('messages');
      await messagesRef.add({
        'senderId': 'system', // indicating system-generated message
        'text': 'Chat created',
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'system'
      });
    } catch (e) {
      print("Error creating chat: $e");
    }
  }

  // Retrieve all chats where the user is a participant (Contacts)
  Future<List<Chat>> getAllChats(String userId) async {
    try {
      QuerySnapshot snapshot = await chatsRef
          .where('participants', arrayContains: userId)
          .get();

      return snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error getting chats: $e");
      return [];
    }
  }

  Future<List<Message>> getMessagesInChat(String chatId) async {
    try {
      CollectionReference messagesRef = chatsRef.doc(chatId).collection('messages');

      QuerySnapshot snapshot = await messagesRef.orderBy('timestamp').get();
      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error getting messages: $e");
      return [];
    }
  }

  Future<void> sendMessage(String chatId, Message messageData) async {
    try {
      CollectionReference messagesRef = chatsRef.doc(chatId).collection('messages');

      await messagesRef.add(messageData.toMap());
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Future<void> updateChatMessage(String chatId, String lastMessage) async {
    try {
      await chatsRef.doc(chatId).update({
        'lastMessage': lastMessage,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error updating chat message: $e");
    }
  }
}
