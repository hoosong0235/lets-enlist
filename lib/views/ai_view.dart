import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/controllers/chat_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/widget.dart';
import 'package:lets_enlist/views/profile_view.dart';

class AiView extends StatefulWidget {
  const AiView({super.key});

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: WHITE,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                GeminiFirst,
                GeminiSecond,
                GeminiThird,
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              FindController.clear();
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            child: SvgPicture.asset(
              'assets/LetsEnlistAIHorizontal.svg',
            ),
          ),
        ),
        actions: [
          AuthenticationController.hasUserCredential
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, a, b) => const ProfileView(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        AuthenticationController.photoURL,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () async =>
                      await AuthenticationController.signIn(),
                  icon: const Icon(Icons.person_outline),
                ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          ListView(
            controller: ChatController.scrollController,
            children: [
              buildSizedBox(16),
              ...List.generate(
                ChatController.chats.length,
                (int i) {
                  return Row(
                    mainAxisAlignment:
                        ChatController.chats[i].chatType.mainAxisAlignment,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: ChatController.chats[i].chatType.edgeInsets,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                ChatController.chats[i].chatType.borderRadius,
                            boxShadow: kElevationToShadow[2],
                          ),
                          child: MarkdownBody(
                            data: ChatController.chats[i].text,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              buildSizedBox(16 + 56 + 16),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: ChatController.textEditingController,
              hintText: '이때입대 AI에게 물어보세요!',
              trailing: [
                ChatController.isChatReceiving
                    ? CircularProgressIndicator(
                        color: ([GeminiFirst, GeminiSecond, GeminiThird]
                              ..shuffle())
                            .first,
                      )
                    : IconButton(
                        onPressed: () async {
                          ChatController.sendChat();
                          setState(() {});
                          await ChatController.receiveChat();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.keyboard_return,
                        ),
                      )
              ],
              onChanged: (text) {
                ChatController.text = text;
              },
              onSubmitted: (_) async {
                ChatController.sendChat();
                setState(() {});
                await ChatController.receiveChat();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
