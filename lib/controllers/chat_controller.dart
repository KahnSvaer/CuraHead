import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/chat_firestore_service.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

class ChatController extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Variables to hold chat data
  List<Chat> _chats = [];
  List<Message> _messages = [];
  bool _isLoading = false;

  // Getters for the private variables
  List<Chat> get chats => _chats;
  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  // Stream to listen to chats in real-time
  Stream<List<Chat>> get chatsStream {
    final user = _auth.currentUser;
    if (user != null) {
      return _chatService.listenToChats(user.uid); // Real-time updates for chats
    } else {
      // Return an empty stream or handle accordingly
      return Stream.empty();
    }
  }

  // Stream to listen to messages in real-time for a specific chat
  Stream<List<Message>> listenToMessages(String chatId) {
    return _chatService.listenToChatMessages(chatId); // Real-time updates for messages in a chat
  }

  // Fetch all chats for the authenticated user (one-time fetch)
  Future<void> fetchChats() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Use real-time listener instead of a one-time fetch
        await for (var chatList in _chatService.listenToChats(user.uid)) {
          _chats = chatList; // Update chat list as new data comes in
          notifyListeners();
        }
      } else {
        print("No authenticated user found.");
      }
    } catch (e) {
      print("Error fetching chats: $e");
    }

    _isLoading = false;
  }

  // Fetch messages within a specific chat (one-time fetch)
  Future<void> fetchMessages(String chatId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch messages in real-time instead of a one-time fetch
      await for (var messageList in _chatService.listenToChatMessages(chatId)) {
        _messages = messageList; // Update messages as they arrive
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }

    _isLoading = false;
  }

  // Create a new chat
  Future<void> createChat(Chat chatData) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _chatService.createChat(chatData);
      _chats.add(chatData); // Add the new chat to the local list
      notifyListeners();
    } catch (e) {
      print("Error creating chat: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Send a message in a specific chat
  Future<void> sendMessage(String chatId, Message messageData) async {
    try {
      await _chatService.sendMessage(chatId, messageData);
      _messages.add(messageData); // Add message to local list
      notifyListeners();
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  // Clear the message list (useful when switching chats)
  void clearMessages() {
    _messages = [];
    notifyListeners();
  }
}
