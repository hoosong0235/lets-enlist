import 'package:flutter_app/controllers/find_controller.dart';
import 'package:flutter_app/models/enlist_model.dart';
import 'package:flutter_app/utilities/database.dart';
import 'package:flutter_app/utilities/value.dart';

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
  static EnlistType enlistType = EnlistType.ALL;

  // ignore: prefer_final_fields
  static List<EnlistModel> _rawEnlists = [];
  static List<EnlistModel> _foundEnlists = [];

  static List<EnlistModel> get rawEnlists => _rawEnlists;
  static List<EnlistModel> get foundEnlists => _foundEnlists
      .where((EnlistModel enlistModel) => enlistType.function(enlistModel))
      .toList();
  static List<EnlistModel> get latestEnlists {
    return _rawEnlists
        .where(
          (EnlistModel enlistmodel) => enlistmodel.dDay == null
              ? false
              : (0 <= enlistmodel.dDay! && enlistmodel.dDay! < 30),
        )
        .toList()
      ..sort((a, b) => a.applicationEnd.difference(b.applicationEnd).inMinutes);
  }

  // will be executed once before launch
  static void fetchRawEnlists() {
    // todo: read csv and fetch all enlist models in the list '_rawEnlists'
    _rawEnlists.addAll(
      database.map(
        (Map<String, dynamic> enlistMap) => EnlistModel(
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

  // will be executed every single time user clicks search button
  static void findFoundEnlists() {
    // todo: filter '_rawEnlists' and update '_enlists' using three static variables below.
    // in flutter, static variables are unique, and can be shared among the whole application
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
        .toList()
      ..sort(SortType.RECOMMEND.function);
  }

  static void sortFoundEnlists(SortType sortType) {
    _foundEnlists.sort(sortType.function);
  }
}
