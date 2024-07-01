import 'dart:async';
import 'dart:math';
import 'package:lets_enlist/controllers/find_controller.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/database.dart';
import 'package:lets_enlist/utilities/value.dart';

Branch _getBranch(String branch) {
  if (branch == '육군') {
    return Branch.ROKA;
  } else if (branch == '해군') {
    return Branch.ROKN;
  } else if (branch == '공군') {
    return Branch.ROKAF;
  } else if (branch == '해병대') {
    return Branch.ROKMC;
  } else {
    return Branch.ALL;
  }
}

InterviewType _getInterviewType(String interviewType) {
  if (interviewType == '대면') {
    return InterviewType.F2F;
  } else if (interviewType == '비대면') {
    return InterviewType.NF2F;
  } else if (interviewType == '영상평가') {
    return InterviewType.VIDEO;
  } else if (interviewType == '전산추첨') {
    return InterviewType.RAFFLE;
  } else {
    return InterviewType.ALL;
  }
}

InterviewType? _getNullableInterviewType(String? interviewType) {
  return interviewType != null ? _getInterviewType(interviewType) : null;
}

class EnlistController {
  static FilterType filterType = FilterType.CURRENT;
  static SortType sortType = SortType.RECOMMEND;

  // raw
  // ignore: prefer_final_fields
  static List<EnlistModel> _rawEnlists = [];
  static List<EnlistModel> get rawEnlists => _rawEnlists;

  // latest
  static int _latestEnlistsIndex = 10;
  static bool _isLoadingLatestEnlists = false;
  static bool get isLoadingLatestEnlists => _isLoadingLatestEnlists;
  static List<EnlistModel> _latestEnlist = [];
  static List<EnlistModel> get latestEnlistsList => _latestEnlist;
  static List<EnlistModel> get latestEnlistsSublist => _latestEnlist.sublist(
        0,
        min(_latestEnlist.length, _latestEnlistsIndex),
      );

  // found
  static int _foundEnlistsIndex = 10;
  static bool _isLoadingFoundEnlists = false;
  static bool get isLoadingFoundEnlists => _isLoadingFoundEnlists;
  static List<EnlistModel> _foundEnlists = [];
  static List<EnlistModel> _filteredFoundEnlists = [];
  static List<EnlistModel> _sortedFilteredFoundEnlists = [];
  static List<EnlistModel> get foundEnlistsList => _sortedFilteredFoundEnlists;
  static List<EnlistModel> get foundEnlistsSubList =>
      _sortedFilteredFoundEnlists.sublist(
        0,
        min(_sortedFilteredFoundEnlists.length, _foundEnlistsIndex),
      );

  static void fetchRawEnlists() {
    int cnt = 0;

    _rawEnlists.addAll(
      database.map(
        (Map<String, dynamic> enlistMap) => EnlistModel(
            index: cnt++,
            branch: _getBranch(enlistMap['branch']),
            serialNumber: enlistMap['serialNumber'],
            recruitTrainingCenter: enlistMap['recruitTrainingCenter'],
            baseJob: enlistMap['baseJob'],
            classification: enlistMap['classification'],
            recruitmentNumber: enlistMap['recruitmentNumber'],
            applicationStart: DateTime.parse(enlistMap['applicationStart']),
            applicationEnd: DateTime.parse(enlistMap['applicationEnd']),
            hasInterview: enlistMap['hasInterview'],
            interviewStart: enlistMap['interviewStart'] != null
                ? DateTime.parse(enlistMap['interviewStart'])
                : null,
            interviewEnd: enlistMap['interviewEnd'] != null
                ? DateTime.parse(enlistMap['interviewEnd'])
                : null,
            interviewType:
                _getNullableInterviewType(enlistMap['interviewType']),
            interviewLocation: enlistMap['interviewLocation'],
            firstResultsDateTime: enlistMap['firstResultsDateTime'] != null
                ? DateTime.parse(enlistMap['firstResultsDateTime'])
                : null,
            finalResultsDateTime: enlistMap['finalResultsDateTime'] != null
                ? DateTime.parse(enlistMap['finalResultsDateTime'])
                : null,
            enlistDateTime: DateTime.parse(enlistMap['enlistDateTime']),
            administrationAnnouncementLink:
                enlistMap['administrationAnnouncementLink'],
            qualification: enlistMap['qualification'],
            description: enlistMap['description'],
            documentsNeeded: enlistMap['documentsNeeded']),
      ),
    );
  }

  static void fetchLastestEnlists() {
    _latestEnlist = _rawEnlists
        .where(
          (EnlistModel enlistmodel) => enlistmodel.dDay == null
              ? false
              : (0 <= enlistmodel.dDay! && enlistmodel.dDay! < 30),
        )
        .toList()
      ..sort((a, b) => a.applicationEnd.difference(b.applicationEnd).inMinutes);
  }

  static void loadLatestEnlists() {
    _isLoadingLatestEnlists = true;
    _latestEnlistsIndex += 10;

    Timer(
      const Duration(),
      () {
        _isLoadingLatestEnlists = false;
      },
    );
  }

  static void fetchFoundEnlists() {
    _foundEnlists = _rawEnlists
        .where((EnlistModel enlistModel) =>
            (FindController.keyword.isEmpty ||
                enlistModel.descriptionLong.contains(FindController.keyword)) &&
            (FindController.branch == Branch.ALL ||
                enlistModel.branch == FindController.branch) &&
            (FindController.interviewType == InterviewType.ALL ||
                enlistModel.interviewType == FindController.interviewType) &&
            (FindController.enlistDateTimeRange ==
                    FindController.initialEnlistDateTimeRange ||
                (enlistModel.enlistDateTime
                        .isAfter(FindController.enlistDateTimeRange.start) &&
                    enlistModel.enlistDateTime
                        .isBefore(FindController.enlistDateTimeRange.end))) &&
            (FindController.dischargeDateTimeRange ==
                    FindController.initialDischargeDateTimeRange ||
                (enlistModel.dischargeDateTime
                        .isAfter(FindController.dischargeDateTimeRange.start) &&
                    enlistModel.dischargeDateTime
                        .isBefore(FindController.dischargeDateTimeRange.end))))
        .toList();
  }

  static void loadFoundEnlists() {
    _isLoadingFoundEnlists = true;
    _foundEnlistsIndex += 10;

    Timer(
      const Duration(),
      () {
        _isLoadingFoundEnlists = false;
      },
    );
  }

  static void filterFoundEnlists() {
    _filteredFoundEnlists = _foundEnlists
        .where((EnlistModel enlistModel) => filterType.function(enlistModel))
        .toList();
  }

  static void sortFilteredFoundEnlists() {
    _sortedFilteredFoundEnlists = [
      ..._filteredFoundEnlists,
    ]..sort(sortType.function);
  }
}
