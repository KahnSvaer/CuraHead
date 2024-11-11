import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

class ChatService {
  // Collection reference for chats
  final CollectionReference chatsRef = FirebaseFirestore.instance.collection('chats');

  // Create a new chat with auto-generated chatId
  Future<void> createChat(Chat chatData) async {
    try {
      DocumentReference newChatRef = await chatsRef.add(chatData.toMap());
      await newChatRef.update({'chatId': newChatRef.id});
      chatData.chatId = newChatRef.id;
      CollectionReference messagesRef = newChatRef.collection('messages');
      await messagesRef.doc('initial').set({
        'systemMessage': 'Chat created',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error creating chat: $e");
    }
  }

  // Get all chats where the user is a participant
  Future<List<Chat>> getAllChats(String userId) async {
    try {
      // Query chats where the user's ID is in the 'participants' list
      QuerySnapshot snapshot = await chatsRef
          .where('participants', arrayContains: userId) // Filters chats with the user
          .get();

      List<Chat> chatList = [];
      for (var doc in snapshot.docs) {
        chatList.add(Chat.fromFirestore(doc));
      }
      return chatList;
    } catch (e) {
      print("Error getting chats: $e");
      return [];
    }
  }

  // Get all messages inside a specific chat (messages are a subcollection of chat)
  Future<List<Message>> getMessagesInChat(String chatId) async {
    try {
      // Accessing the subcollection 'messages' inside a specific chat document
      CollectionReference messagesRef = chatsRef.doc(chatId).collection('messages');

      QuerySnapshot snapshot = await messagesRef.orderBy('timestamp').get();
      List<Message> messages = [];
      for (var doc in snapshot.docs) {
        messages.add(Message.fromFirestore(doc));
      }
      return messages;
    } catch (e) {
      print("Error getting messages: $e");
      return [];
    }
  }

  // Send a message in a specific chat (messages are a subcollection of chat)
  Future<void> sendMessage(String chatId, Message messageData) async {
    try {
      CollectionReference messagesRef = chatsRef.doc(chatId).collection('messages');

      await messagesRef.add({
        ...messageData.toMap(),
        'timestamp': Timestamp.fromDate(messageData.timestamp.toUtc()),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
