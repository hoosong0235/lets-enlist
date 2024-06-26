import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/controllers/firestore_database_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/color.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    Stack _buildStack() {
      return Stack(
        children: [
          SvgPicture.asset(
            'assets/${widget.enlistModel.branch.nameEng}GradientLarge.svg',
            height: 320,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: PADDING),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.enlistModel.descriptionShort,
                            style: tt.headlineLarge?.copyWith(
                              color: WHITE,
                            ),
                          ),
                          Text(
                            widget.enlistModel.classification ?? '-',
                            style: tt.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: WHITE,
                            ),
                          ),
                        ],
                      ),
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
            ),
          ),
        ],
      );
    }

    Padding _buildDetail() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48,
          horizontal: PADDING,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '보직특성',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Text(
              widget.enlistModel.description ?? '-',
              style: tt.bodyLarge,
            ),
            buildSizedBox(64),
            Text(
              '지원자격',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Text(
              widget.enlistModel.qualification ?? '-',
              style: tt.bodyLarge,
            ),
            buildSizedBox(64),
            Text(
              '필요서류',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Text(
              widget.enlistModel.documentsNeeded ?? '-',
              style: tt.bodyLarge,
            ),
            buildSizedBox(64),
            Text(
              '지원정보',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            widget.enlistModel.hasInterview
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '모집',
                                  style: tt.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  // todo: modify here
                                  '${widget.enlistModel.recruitmentNumber ?? 0}명',
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
                                  '면접종류',
                                  style: tt.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  // todo: modify here
                                  widget.enlistModel.interviewType?.name ??
                                      '없음',
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
                                  // todo: modify here
                                  (widget.enlistModel.interviewStart != null &&
                                          widget.enlistModel.interviewEnd !=
                                              null)
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
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '모집',
                                  style: tt.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  // todo: modify here
                                  '${widget.enlistModel.recruitmentNumber ?? 0}명',
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
                                  '면접종류',
                                  style: tt.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  // todo: modify here
                                  widget.enlistModel.interviewType?.name ??
                                      '없음',
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
                    ],
                  ),
            buildSizedBox(64),
            Text(
              '입대정보',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            Column(
              children: [
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
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '훈련소',
                            style: tt.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // todo: modify here
                            widget.enlistModel.recruitTrainingCenter ?? '-',
                            style: tt.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    const Expanded(
                      child: Row(),
                    ),
                  ],
                ),
              ],
            ),
            buildSizedBox(64),
            Text(
              '참고자료',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBox(16),
            widget.enlistModel.administrationAnnouncementLink != null
                ? InkWell(
                    child: Text(
                      widget.enlistModel.administrationAnnouncementLink!,
                      style: tt.bodyLarge,
                    ),
                    onTap: () async => await launchUrlString(
                      widget.enlistModel.administrationAnnouncementLink!,
                    ),
                  )
                : Text(
                    '-',
                    style: tt.bodyLarge,
                  ),
            buildSizedBox(64),
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
