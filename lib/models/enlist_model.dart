// 'EnlistModel' is the parameter for details page,
// when user clicks given card, corresponding 'EnlistModel' will be used for building details page
import 'package:flutter_app/utilities/value.dart';

class EnlistModel {
  // todo: define required fields for the functionality above
  EnlistModel({
    required this.branch,
    required this.serialNumber,
    required this.recruitTrainingCenter,
    required this.baseJob,
    required this.classification,
    required this.recruitmentNumber,
    required this.applicationStart,
    required this.applicationEnd,
    required this.hasInterview,
    required this.interviewStart,
    required this.interviewEnd,
    required this.interviewType,
    required this.interviewLocation,
    required this.firstResultsDateTime,
    required this.finalResultsDateTime,
    required this.enlistDateTime,
    required this.administrationAnnouncementLink,
    required this.qualification,
    required this.description,
    required this.documentsNeeded,
  });

  Branch branch;
  String? serialNumber;
  String? recruitTrainingCenter;
  String? baseJob;
  String? classification;
  int? recruitmentNumber;
  DateTime applicationStart;
  DateTime applicationEnd;
  bool hasInterview;
  DateTime? interviewStart;
  DateTime? interviewEnd;
  InterviewType? interviewType;
  String? interviewLocation;
  DateTime? firstResultsDateTime;
  DateTime? finalResultsDateTime;
  DateTime enlistDateTime;
  String? administrationAnnouncementLink;
  String? qualification;
  String? description;
  String? documentsNeeded;

  String get descriptionShort =>
      '${branch.nameKor}${serialNumber != null ? ' ' : ''}${serialNumber ?? ''}${baseJob != null ? ' ' : ''}${baseJob ?? ''}';

  String get descriptionLong =>
      '$descriptionShort${classification != null ? ' ' : ''}${classification ?? ''}';

  int? get dDay => applicationEnd.difference(DateTime.now()).inDays;

  DateTime get dischargeDateTime {
    if (branch == Branch.ROKA) {
      return DateTime(
        enlistDateTime.year + 1,
        enlistDateTime.month + 6,
        enlistDateTime.day - 1,
        6,
      );
    } else if (branch == Branch.ROKN) {
      return DateTime(
        enlistDateTime.year + 1,
        enlistDateTime.month + 8,
        enlistDateTime.day - 1,
        6,
      );
    } else if (branch == Branch.ROKAF) {
      return DateTime(
        enlistDateTime.year + 1,
        enlistDateTime.month + 9,
        enlistDateTime.day - 1,
        6,
      );
    } else if (branch == Branch.ROKMC) {
      return DateTime(
        enlistDateTime.year + 1,
        enlistDateTime.month + 6,
        enlistDateTime.day - 1,
        6,
      );
    } else {
      return DateTime(
        enlistDateTime.year + 1,
        enlistDateTime.month + 6,
        enlistDateTime.day - 1,
        6,
      );
    }
  }
}
