// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/controllers/chat_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/controllers/firestore_database_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/views/ai_view.dart';
import 'package:lets_enlist/views/details_view.dart';
import 'package:lets_enlist/views/profile_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class buildAppBar extends StatefulWidget implements PreferredSizeWidget {
  const buildAppBar({super.key});

  @override
  State<buildAppBar> createState() => _buildAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _buildAppBarState extends State<buildAppBar> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {});
    });

    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth <= WIDTHTRHESHOLD;

    return Padding(
      padding: EdgeInsets.only(
        left: isMobile ? 0 : DESKTOPPADDING(viewportWidth),
        right: isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
      ),
      child: AppBar(
        backgroundColor: WHITE,
        scrolledUnderElevation: 0,
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
              'assets/LetsEnlistHorizontal.svg',
              width: 128,
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
    );
  }
}

SizedBox buildSizedBox(double d) {
  return SizedBox(
    width: d,
    height: d,
  );
}

// ignore: must_be_immutable
class buildEnlist extends StatefulWidget {
  buildEnlist({super.key, required this.enlistModel});

  EnlistModel enlistModel;

  @override
  State<buildEnlist> createState() => _buildEnlistState();
}

class _buildEnlistState extends State<buildEnlist> {
  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth < WIDTHTRHESHOLD;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {});
    });

    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a, b) => DetailsView(
              enlistModel: widget.enlistModel,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: const EdgeInsets.all(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.enlistModel.descriptionLong,
                        style: (isMobile ? tt.titleSmall : tt.titleLarge)
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: widget.enlistModel.branch.color,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      buildSizedBox(4),
                      Row(
                        children: [
                          Text(
                            '${widget.enlistModel.recruitmentNumber ?? '0'}명',
                            style: (isMobile ? tt.labelSmall : tt.labelLarge)
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.enlistModel.branch.color,
                            ),
                          ),
                          buildSizedBox(4),
                          Text(
                            'D${widget.enlistModel.dDay != null ? (widget.enlistModel.dDay! == 0 ? '-day' : (widget.enlistModel.dDay! > 0 ? '-${widget.enlistModel.dDay!}' : '+${-widget.enlistModel.dDay!}')) : '-0'}',
                            style: (isMobile ? tt.labelSmall : tt.labelLarge)
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.enlistModel.branch.color,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.enlistModel.descriptionLong,
                            style: (isMobile ? tt.titleSmall : tt.titleLarge)
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.enlistModel.branch.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          buildSizedBox(8),
                          Text(
                            '${widget.enlistModel.recruitmentNumber ?? '0'}명',
                            style: (isMobile ? tt.labelSmall : tt.labelLarge)
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.enlistModel.branch.color,
                            ),
                          ),
                          buildSizedBox(8),
                          Text(
                            'D${widget.enlistModel.dDay != null ? (widget.enlistModel.dDay! == 0 ? '-day' : (widget.enlistModel.dDay! > 0 ? '-${widget.enlistModel.dDay!}' : '+${-widget.enlistModel.dDay!}')) : '-0'}',
                            style: (isMobile ? tt.labelSmall : tt.labelLarge)
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.enlistModel.branch.color,
                            ),
                          ),
                        ],
                      ),
                      FirestoreDatabaseController.isFavoriteEnlist(
                              widget.enlistModel)
                          ? IconButton(
                              onPressed: () async {
                                if (AuthenticationController
                                    .hasUserCredential) {
                                  await FirestoreDatabaseController
                                      .removeFavoriteEnlists(
                                    widget.enlistModel,
                                  );
                                } else {
                                  await AuthenticationController.signIn();
                                }

                                setState(() {});
                              },
                              icon: const Icon(Icons.star),
                            )
                          : IconButton(
                              onPressed: () async {
                                if (AuthenticationController
                                    .hasUserCredential) {
                                  await FirestoreDatabaseController
                                      .appendFavoriteEnlists(
                                    widget.enlistModel,
                                  );
                                } else {
                                  await AuthenticationController.signIn();
                                }

                                setState(() {});
                              },
                              icon: const Icon(Icons.star_border),
                            ),
                    ],
                  ),
            buildSizedBox(16),
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '지원',
                        style:
                            (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.enlistModel.applicationStart.toString().substring(0, 16)} ~ ${widget.enlistModel.applicationEnd.toString().substring(0, 16)}',
                        style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 32),
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '서류발표',
                        style:
                            (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.enlistModel.firstResultsDateTime
                                ?.toString()
                                .substring(0, 16) ??
                            '-',
                        style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '면접',
                        style:
                            (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        (widget.enlistModel.interviewStart != null &&
                                widget.enlistModel.interviewEnd != null)
                            ? '${widget.enlistModel.interviewStart.toString().substring(0, 16)} ~ ${widget.enlistModel.interviewEnd.toString().substring(0, 16)}'
                            : '-',
                        style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 32),
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '최종발표',
                        style:
                            (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.enlistModel.finalResultsDateTime
                                ?.toString()
                                .substring(0, 16) ??
                            '-',
                        style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '입대',
                        style:
                            (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.enlistModel.enlistDateTime
                            .toString()
                            .substring(0, 16),
                        style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 32),
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '전역',
                        style:
                            (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.enlistModel.dischargeDateTime
                            .toString()
                            .substring(0, 16),
                        style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class buildFloatingActionButton extends StatefulWidget {
  const buildFloatingActionButton({super.key});

  @override
  State<buildFloatingActionButton> createState() =>
      _buildFloatingActionButtonState();
}

class _buildFloatingActionButtonState extends State<buildFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth < WIDTHTRHESHOLD;

    return ChatController.isChatFloating
        ? Container(
            width: isMobile ? viewportWidth - 32 : 384,
            height: 512,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
              boxShadow: kElevationToShadow[3],
            ),
            child: Column(
              children: [
                Container(
                  width: isMobile ? viewportWidth - 32 : 384,
                  height: 56,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        GeminiFirst,
                        GeminiSecond,
                        GeminiThird,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('assets/LetsEnlistAIHorizontal.svg'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              ChatController.isChatFloating = false;
                            });
                          },
                          icon: const Icon(
                            Icons.minimize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
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
                                mainAxisAlignment: ChatController
                                    .chats[i].chatType.mainAxisAlignment,
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      margin: ChatController
                                          .chats[i].chatType.edgeInsets,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: ChatController
                                            .chats[i].chatType.borderRadius,
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
                                    color: ([
                                      GeminiFirst,
                                      GeminiSecond,
                                      GeminiThird
                                    ]..shuffle())
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
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: kElevationToShadow[3],
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  GeminiFirst,
                  GeminiSecond,
                  GeminiThird,
                ],
              ),
            ),
            child: FloatingActionButton.large(
              onPressed: () {
                isMobile
                    ? Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a, b) => const AiView(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      )
                    : setState(() {
                        ChatController.isChatFloating = true;
                      });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: SvgPicture.asset('assets/AI.svg'),
            ),
          );
  }
}
