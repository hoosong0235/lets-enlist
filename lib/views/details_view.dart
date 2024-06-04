import 'package:flutter/material.dart';
import 'package:flutter_app/models/enlist_model.dart';
import 'package:flutter_app/utilities/color.dart';
import 'package:flutter_app/utilities/value.dart';
import 'package:flutter_app/utilities/widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class DetailsView extends StatelessWidget {
  EnlistModel enlistModel;

  DetailsView({super.key, required this.enlistModel});

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    Stack _buildStack() {
      return Stack(
        children: [
          SvgPicture.asset(
            'assets/${enlistModel.branch.nameEng}GradientLarge.svg',
            height: 320,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: PADDING),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    enlistModel.descriptionShort,
                    style: tt.headlineLarge?.copyWith(
                      color: WHITE,
                    ),
                  ),
                  Text(
                    enlistModel.classification ?? '-',
                    style: tt.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: WHITE,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      body: ListView(
        children: [
          _buildStack(),
          Padding(
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
                  enlistModel.description ?? '-',
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
                  enlistModel.qualification ?? '-',
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
                  enlistModel.documentsNeeded ?? '-',
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
                enlistModel.hasInterview
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '모집',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      '${enlistModel.recruitmentNumber ?? 0}명',
                                      style: tt.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '면접종류',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      enlistModel.interviewType?.name ?? '없음',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '지원',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      '${enlistModel.applicationStart.toString().substring(0, 16)} ~ ${enlistModel.applicationEnd.toString().substring(0, 16)}',
                                      style: tt.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '서류발표',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      enlistModel.firstResultsDateTime
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '면접',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      (enlistModel.interviewStart != null &&
                                              enlistModel.interviewEnd != null)
                                          ? '${enlistModel.interviewStart.toString().substring(0, 16)} ~ ${enlistModel.interviewEnd.toString().substring(0, 16)}'
                                          : '-',
                                      style: tt.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '최종발표',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      enlistModel.finalResultsDateTime
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '모집',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      '${enlistModel.recruitmentNumber ?? 0}명',
                                      style: tt.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '면접종류',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      enlistModel.interviewType?.name ?? '없음',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '지원',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      '${enlistModel.applicationStart.toString().substring(0, 16)} ~ ${enlistModel.applicationEnd.toString().substring(0, 16)}',
                                      style: tt.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '최종발표',
                                      style: tt.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // todo: modify here
                                      enlistModel.finalResultsDateTime
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
                                enlistModel.enlistDateTime
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
                                enlistModel.dischargeDateTime
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
                                enlistModel.recruitTrainingCenter ?? '-',
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
                enlistModel.administrationAnnouncementLink != null
                    ? InkWell(
                        child: Text(
                          enlistModel.administrationAnnouncementLink!,
                          style: tt.bodyLarge,
                        ),
                        onTap: () async => await launchUrlString(
                          enlistModel.administrationAnnouncementLink!,
                        ),
                      )
                    : Text(
                        '-',
                        style: tt.bodyLarge,
                      ),
                buildSizedBox(64),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
