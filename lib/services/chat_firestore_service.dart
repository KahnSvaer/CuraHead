import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curahead_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

class ChatService {
  final CollectionReference chatsRef = FirebaseFirestore.instance.collection('Chats');

  // Chat creation
  Future<void> createChat(Chat chatData) async {
    try {
      DocumentReference newChatRef = await chatsRef.add(chatData.toMap());

      // Update chatId field in chatData
      await newChatRef.update({'chatId': newChatRef.id});
      print(1);
      chatData.chatId = newChatRef.id; // Set chatId permanently
      print(2);
      // Add system-generated message
      CollectionReference messagesRef = newChatRef.collection('Messages');
      await messagesRef.add({
        'senderId': 'system', // indicating system-generated message
        'text': 'Chat created',
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'system'
      });

      // Add chatId to user's chat list
      await UserService().addChatID(newChatRef.id);

    } catch (e) {
      print("Error creating chat ChatService: $e");
    }
  }

  // Listen to chat messages in real-time
  Stream<List<Message>> listenToChatMessages(String chatId) {
    // Real-time listener for messages
    CollectionReference messagesRef = chatsRef.doc(chatId).collection('Messages');
    return messagesRef
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    });
  }

  // Retrieve all chats where the user is a participant (Contacts) - Real-time
  Stream<List<Chat>> listenToChats(String userId) {
    return UserService().listenToChatIDs().asyncMap((chatsList) async {
      if (chatsList.isEmpty) {
        return [];
      }

      // Stream all chats that the user is a participant of
      Query query = chatsRef
          .where(FieldPath.documentId, whereIn: chatsList)
          .where('participants', arrayContains: userId);

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();
    });
  }

  // Send a single message
  Future<void> sendMessage(String chatId, Message messageData) async {
    try {
      CollectionReference messagesRef = chatsRef.doc(chatId).collection('Messages');
      await messagesRef.add(messageData.toMap());
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  // Send a batch of messages
  Future<void> sendBatchMessages(String chatId, List<Message> messages) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    CollectionReference messagesRef = chatsRef.doc(chatId).collection('Messages');

    for (Message message in messages) {
      DocumentReference messageRef = messagesRef.doc();
      batch.set(messageRef, message.toMap());
    }

    try {
      await batch.commit();
    } catch (e) {
      print("Error sending batch messages: $e");
    }
  }

  // Update the last message in the chat (for chat previews)
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
