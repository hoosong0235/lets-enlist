// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/controllers/firestore_database_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PADDING),
      child: AppBar(
        backgroundColor: WHITE,
        scrolledUnderElevation: 0,
        leadingWidth: 128,
        leading: MouseRegion(
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
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // todo: modify here
                      widget.enlistModel.descriptionLong,
                      style: tt.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.enlistModel.branch.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    buildSizedBox(8),
                    Text(
                      // todo: modify here
                      '${widget.enlistModel.recruitmentNumber ?? '0'}명',
                      style: tt.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.enlistModel.branch.color,
                      ),
                    ),
                    buildSizedBox(8),
                    Text(
                      'D${widget.enlistModel.dDay != null ? (widget.enlistModel.dDay! == 0 ? '-day' : (widget.enlistModel.dDay! > 0 ? '-${widget.enlistModel.dDay!}' : '+${-widget.enlistModel.dDay!}')) : '-0'}',
                      style: tt.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.enlistModel.branch.color,
                      ),
                    ),
                  ],
                ),
                FirestoreDatabaseController.isFavoriteEnlist(widget.enlistModel)
                    ? IconButton(
                        onPressed: () async {
                          if (AuthenticationController.hasUserCredential) {
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
                          if (AuthenticationController.hasUserCredential) {
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '지원',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // todo: modify here
                        '${widget.enlistModel.applicationStart.toString().substring(0, 16)} ~ ${widget.enlistModel.applicationEnd.toString().substring(0, 16)}',
                        style: tt.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '서류발표',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // todo: modify here
                        widget.enlistModel.firstResultsDateTime
                                ?.toString()
                                .substring(0, 16) ??
                            '-',
                        style: tt.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '면접',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        (widget.enlistModel.interviewStart != null &&
                                widget.enlistModel.interviewEnd != null)
                            ? '${widget.enlistModel.interviewStart.toString().substring(0, 16)} ~ ${widget.enlistModel.interviewEnd.toString().substring(0, 16)}'
                            : '-',
                        style: tt.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '최종발표',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // todo: modify here
                        widget.enlistModel.finalResultsDateTime
                                ?.toString()
                                .substring(0, 16) ??
                            '-',
                        style: tt.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '입대',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // todo: modify here
                        widget.enlistModel.enlistDateTime
                            .toString()
                            .substring(0, 16),
                        style: tt.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '전역',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // todo: modify here
                        widget.enlistModel.dischargeDateTime
                            .toString()
                            .substring(0, 16),
                        style: tt.bodyLarge,
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
