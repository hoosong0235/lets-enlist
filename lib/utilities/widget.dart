import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/find_controller.dart';
import 'package:flutter_app/models/enlist_model.dart';
import 'package:flutter_app/utilities/color.dart';
import 'package:flutter_app/utilities/value.dart';
import 'package:flutter_app/views/details_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class buildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const buildAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PADDING),
      child: AppBar(
        backgroundColor: WHITE,
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
              'assets/LetsEnlist.svg',
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: Icon(
                  Icons.construction,
                  color: cs.primary,
                ),
                content: const Text('준비 중입니다'),
              ),
            ),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

SizedBox buildSizedBox(double d) {
  return SizedBox(
    width: d,
    height: d,
  );
}

// todo: build enlist card refering to the value of given 'enlistModel'
Widget buildEnlist(EnlistModel enlistModel, BuildContext context) {
  TextTheme tt = Theme.of(context).textTheme;

  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, a, b) => DetailsView(
            enlistModel: enlistModel,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  // todo: modify here
                  enlistModel.descriptionLong,
                  style: tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: enlistModel.branch.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              buildSizedBox(8),
              Text(
                // todo: modify here
                '${enlistModel.recruitmentNumber ?? '0'}명',
                style: tt.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: enlistModel.branch.color,
                ),
              ),
              buildSizedBox(8),
              Text(
                'D${enlistModel.dDay != null ? (enlistModel.dDay! == 0 ? '-day' : (enlistModel.dDay! > 0 ? '-${enlistModel.dDay!}' : '+${-enlistModel.dDay!}')) : '-0'}',
                style: tt.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: enlistModel.branch.color,
                ),
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
                      '${enlistModel.applicationStart.toString().substring(0, 16)} ~ ${enlistModel.applicationEnd.toString().substring(0, 16)}',
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
                      enlistModel.enlistDateTime.toString().substring(0, 16),
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
                      enlistModel.dischargeDateTime.toString().substring(0, 16),
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
