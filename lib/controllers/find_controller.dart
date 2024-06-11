import 'package:flutter/material.dart';
import 'package:lets_enlist/utilities/value.dart';

// not named 'SearchController' since it already exists in flutter
class FindController {
  static final DateTime now = DateTime.now();
  static final DateTimeRange initialEnlistDateTimeRange = DateTimeRange(
    start: DateTime(
      FindController.now.year,
      FindController.now.month,
      1,
    ),
    end: DateTime(
      FindController.now.year + 1,
      FindController.now.month,
      0,
    ),
  );
  static final DateTimeRange initialDischargeDateTimeRange = DateTimeRange(
    start: DateTime(
      FindController.now.year + 1,
      FindController.now.month + 6,
      1,
    ),
    end: DateTime(
      FindController.now.year + 2,
      FindController.now.month + 6,
      0,
    ),
  );

  static TextEditingController mainViewKeywordController =
      TextEditingController();
  static TextEditingController searchViewKeywordController =
      TextEditingController();
  static String keyword = '';
  static Branch branch = Branch.ALL;
  static InterviewType interviewType = InterviewType.ALL;
  static DateTimeRange enlistDateTimeRange = initialEnlistDateTimeRange;
  static DateTimeRange dischargeDateTimeRange = initialDischargeDateTimeRange;

  static void clearKeyword() {
    mainViewKeywordController.clear();
    searchViewKeywordController.clear();
    keyword = '';
  }

  static void clear() {
    mainViewKeywordController.clear();
    searchViewKeywordController.clear();
    keyword = '';
    branch = Branch.ALL;
    interviewType = InterviewType.ALL;
    enlistDateTimeRange = initialEnlistDateTimeRange;
    dischargeDateTimeRange = initialDischargeDateTimeRange;
  }
}
