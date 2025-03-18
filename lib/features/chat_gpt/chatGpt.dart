import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/controllers/user_controller.dart';

class ChatGptScreen extends StatefulWidget {
  final UserController userController;
  ChatGptScreen({super.key}) : userController = Get.put(UserController());

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  final _openAI = OpenAI.instance.build(
      token: AppConstant.OPENAI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      ),
      enableLog: true);

  final ChatUser _user = ChatUser(
    profileImage: userData.image,
    id: userData.userid,
    firstName: userData.firstName,
    lastName: userData.lastName,
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Alpha',
    lastName: 'Genius',
  );

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];
  bool _isSending = false; // State variable to manage text field state

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Talent Genius Chatbot',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: DashChat(
        currentUser: _user,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Colors.deepPurple,
          textColor: Colors.white,
        ),
        onSend: (ChatMessage m) {
          if (!_isSending) {
            getChatResponse(m);
          }
        },
        messages: _messages,
        typingUsers: _typingUsers,
        readOnly: _isSending, // Disable text field when sending
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _isSending = true; // Disable the text field
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    List<Map<String, dynamic>> messagesHistory =
        _messages.reversed.toList().map((m) {
      if (m.user == _user) {
        return Messages(role: Role.user, content: m.text).toJson();
      } else {
        return Messages(role: Role.assistant, content: m.text).toJson();
      }
    }).toList();

    final request = ChatCompleteText(
      messages: messagesHistory,
      maxToken: 2000,
      model: Gpt4O2024ChatModel(),
    );

    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }

    setState(() {
      _typingUsers.remove(_gptChatUser);
      _isSending = false; // Re-enable the text field
    });

    _saveMessages(); // Save messages to local storage
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messages = _messages.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList('chat_messages', messages);
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messages = prefs.getStringList('chat_messages');
    if (messages != null) {
      setState(() {
        _messages =
            messages.map((m) => ChatMessage.fromJson(jsonDecode(m))).toList();
      });
    }
  }
}