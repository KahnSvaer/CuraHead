import 'package:flutter/material.dart';
import '../services/chat_firestore_service.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

class ChatController extends ChangeNotifier {
  final ChatService _chatService = ChatService();

  // Variables to hold chat data
  List<Chat> _chats = [];
  List<Message> _messages = [];
  bool _isLoading = false;

  // Getters for the private variables
  List<Chat> get chats => _chats;
  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  // Fetch all chats for a specific user
  Future<void> fetchChats(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _chats = await _chatService.getAllChats(userId);
    } catch (e) {
      print("Error fetching chats: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch messages within a specific chat
  Future<void> fetchMessages(String chatId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _messages = await _chatService.getMessagesInChat(chatId);
    } catch (e) {
      print("Error fetching messages: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Create a new chat
  Future<void> createChat(Chat chatData) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _chatService.createChat(chatData);
      _chats.add(chatData); // Add the new chat to the local list
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
