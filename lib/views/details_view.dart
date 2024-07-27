import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/controllers/firestore_database_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class DetailsView extends StatefulWidget {
  EnlistModel enlistModel;

  DetailsView({super.key, required this.enlistModel});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth <= WIDTHTRHESHOLD;

    Widget _buildStack() {
      return Container(
        padding: EdgeInsets.only(
          left: isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
          top: isMobile ? 16 : 96,
          right: isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
          bottom: isMobile ? 64 : 96,
        ),
        decoration: BoxDecoration(
          gradient: widget.enlistModel.branch.gradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.stretch
                  : CrossAxisAlignment.start,
              children: isMobile
                  ? [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FirestoreDatabaseController.isFavoriteEnlist(
                            widget.enlistModel,
                          )
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
                                  icon: const Icon(
                                    Icons.star,
                                    color: WHITE,
                                  ),
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
                                  icon: const Icon(
                                    Icons.star_border,
                                    color: WHITE,
                                  ),
                                ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.enlistModel.descriptionShort,
                            style:
                                (isMobile ? tt.headlineSmall : tt.headlineLarge)
                                    ?.copyWith(
                              color: WHITE,
                            ),
                          ),
                          Text(
                            widget.enlistModel.classification ?? '-',
                            style:
                                (isMobile ? tt.displaySmall : tt.displayLarge)
                                    ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: WHITE,
                            ),
                          ),
                        ],
                      ),
                    ]
                  : [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.enlistModel.descriptionShort,
                            style:
                                (isMobile ? tt.headlineSmall : tt.headlineLarge)
                                    ?.copyWith(
                              color: WHITE,
                            ),
                          ),
                          Text(
                            widget.enlistModel.classification ?? '-',
                            style:
                                (isMobile ? tt.displaySmall : tt.displayLarge)
                                    ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: WHITE,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FirestoreDatabaseController.isFavoriteEnlist(
                            widget.enlistModel,
                          )
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
                                  icon: const Icon(
                                    Icons.star,
                                    color: WHITE,
                                  ),
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
                                  icon: const Icon(
                                    Icons.star_border,
                                    color: WHITE,
                                  ),
                                ),
                        ],
                      ),
                    ],
            ),
          ],
        ),
      );
    }

    Padding _buildDetail() {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 48,
          horizontal: isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '보직특성',
              style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Text(
              widget.enlistModel.description ?? '-',
              style: (isMobile ? tt.bodySmall : tt.bodyLarge),
            ),
            buildSizedBox(isMobile ? 32 : 48),
            Text(
              '지원자격',
              style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Text(
              widget.enlistModel.qualification ?? '-',
              style: (isMobile ? tt.bodySmall : tt.bodyLarge),
            ),
            buildSizedBox(isMobile ? 32 : 48),
            Text(
              '필요서류',
              style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Text(
              widget.enlistModel.documentsNeeded ?? '-',
              style: (isMobile ? tt.bodySmall : tt.bodyLarge),
            ),
            buildSizedBox(isMobile ? 32 : 48),
            Text(
              '지원정보',
              style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            widget.enlistModel.hasInterview
                ? Column(
                    children: [
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
                                  '모집',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.enlistModel.recruitmentNumber ?? 0}명',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '면접종류',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.enlistModel.interviewType?.name ??
                                      '없음',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
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
                                  '지원',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.enlistModel.applicationStart.toString().substring(0, 16)} ~ ${widget.enlistModel.applicationEnd.toString().substring(0, 16)}',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '서류발표',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.enlistModel.firstResultsDateTime
                                          ?.toString()
                                          .substring(0, 16) ??
                                      '-',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
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
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (widget.enlistModel.interviewStart != null &&
                                          widget.enlistModel.interviewEnd !=
                                              null)
                                      ? '${widget.enlistModel.interviewStart.toString().substring(0, 16)} ~ ${widget.enlistModel.interviewEnd.toString().substring(0, 16)}'
                                      : '-',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '최종발표',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.enlistModel.finalResultsDateTime
                                          ?.toString()
                                          .substring(0, 16) ??
                                      '-',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
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
                                  '모집',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.enlistModel.recruitmentNumber ?? 0}명',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '면접종류',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.enlistModel.interviewType?.name ??
                                      '없음',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
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
                                  '지원',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.enlistModel.applicationStart.toString().substring(0, 16)} ~ ${widget.enlistModel.applicationEnd.toString().substring(0, 16)}',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '최종발표',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge)
                                          ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.enlistModel.finalResultsDateTime
                                          ?.toString()
                                          .substring(0, 16) ??
                                      '-',
                                  style:
                                      (isMobile ? tt.bodySmall : tt.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            buildSizedBox(isMobile ? 32 : 48),
            Text(
              '입대정보',
              style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Column(
              children: [
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
                            style: (isMobile ? tt.bodySmall : tt.bodyLarge)
                                ?.copyWith(
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
                    const SizedBox(width: 32),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '전역',
                            style: (isMobile ? tt.bodySmall : tt.bodyLarge)
                                ?.copyWith(
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
                            '훈련소',
                            style: (isMobile ? tt.bodySmall : tt.bodyLarge)
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.enlistModel.recruitTrainingCenter ?? '-',
                            style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    const Flexible(
                      fit: FlexFit.loose,
                      child: Row(),
                    ),
                  ],
                ),
              ],
            ),
            buildSizedBox(isMobile ? 32 : 48),
            Text(
              '참고자료',
              style: (isMobile ? tt.titleSmall : tt.titleLarge)?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            widget.enlistModel.administrationAnnouncementLink != null
                ? InkWell(
                    child: Text(
                      widget.enlistModel.administrationAnnouncementLink!,
                      style: (isMobile ? tt.bodySmall : tt.bodyLarge)?.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                    onTap: () async => await launchUrlString(
                      widget.enlistModel.administrationAnnouncementLink!,
                    ),
                  )
                : Text(
                    '-',
                    style: (isMobile ? tt.bodySmall : tt.bodyLarge),
                  ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      floatingActionButton: const buildFloatingActionButton(),
      body: ListView(
        children: [
          _buildStack(),
          _buildDetail(),
        ],
      ),
    );
  }
}
