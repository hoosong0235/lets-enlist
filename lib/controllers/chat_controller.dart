// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lets_enlist/models/chat_model.dart';
import 'package:lets_enlist/utilities/gitignore.dart';
import 'package:lets_enlist/utilities/value.dart';

class ChatController {
  static bool isChatFloating = true;
  static String text = '';
  static List<ChatModel> _chats = [];
  static TextEditingController textEditingController = TextEditingController();
  static ScrollController scrollController = ScrollController();

  static List<ChatModel> get chats => _chats;

  static bool isChatReceiving = false;
  static ChatSession? _chatSession;
  static GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: GeminiAPIKey,
    // generationConfig: GenerationConfig(maxOutputTokens: 100),
  );

  static void initialize(bool isMobile) {
    isChatFloating = isMobile ? false : true;
  }

  static void sendChat() {
    if (text == '' || isChatReceiving) return;

    isChatReceiving = true;

    _chatSession ??= _model.startChat(
      history: [
        Content.text('너는 대한민국 모집병 통합검색 웹사이트 "이때입대"의 챗봇이야. 사용자에게 모집병을 추천해줘.'),
      ],
    );

    _chats.add(
      ChatModel(
        chatType: ChatType.User,
        text: text,
      ),
    );

    text = '';
    textEditingController.clear();
    scrollDown();
  }

  static Future<void> receiveChat() async {
    if (!isChatReceiving) return;

    dynamic response = await _chatSession?.sendMessage(
      Content.text(_chats[_chats.length - 1].text),
    );

    _chats.add(
      ChatModel(
        chatType: ChatType.Gemeni,
        text: response.text.toString().trim(),
      ),
    );

    scrollDown();
    isChatReceiving = false;
  }

  static void scrollDown() {
    Timer(
      const Duration(),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }
}
