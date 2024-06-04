// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_app/models/enlist_model.dart';
import 'package:flutter_app/utilities/color.dart';

const double PADDING = 256;

enum Branch {
  ALL("전체", BLACK, "ALL"),
  ROKA("육군", ROKAColor, "ROKA"),
  ROKN("해군", ROKNColor, "ROKN"),
  ROKAF("공군", ROKAFColor, "ROKAF"),
  ROKMC("해병대", ROKMCColor, "ROKMC");

  const Branch(this.nameKor, this.color, this.nameEng);

  final String nameKor;
  final Color color;
  final String nameEng;
}

enum InterviewType {
  ALL("전체"),
  F2F("대면"),
  NF2F("비대면"),
  VIDEO("영상평가"),
  RAFFLE("전산추첨");

  const InterviewType(this.name);

  final String name;
}

int sortTime(EnlistModel a, EnlistModel b) =>
    a.applicationEnd.difference(b.applicationEnd).inMinutes;

int branchScore(Branch branch) {
  return branch == Branch.ALL
      ? 0
      : (branch == Branch.ROKA
          ? 1
          : (branch == Branch.ROKN
              ? 2
              : (branch == Branch.ROKAF
                  ? 3
                  : (branch == Branch.ROKMC ? 4 : 5))));
}

int sortRecommend(EnlistModel a, EnlistModel b) =>
    branchScore(a.branch) - branchScore(b.branch);

enum SortType {
  RECOMMEND(sortRecommend, "추천순"),
  TIME(sortTime, "시간순");

  const SortType(this.function, this.name);

  final int Function(EnlistModel, EnlistModel) function;
  final String name;
}

bool filterAll(EnlistModel enlistModel) => true;
bool filterPast(EnlistModel enlistModel) =>
    enlistModel.applicationEnd.isBefore(DateTime.now());
bool filterCurrent(EnlistModel enlistModel) =>
    enlistModel.applicationEnd.isAfter(DateTime.now());

enum EnlistType {
  ALL(filterAll, "전체"), // filterAll
  PAST(filterPast, "마감"), // filterPast
  CURRENT(filterCurrent, "진행중"); // filterCurrnet

  const EnlistType(this.function, this.name);

  final bool Function(EnlistModel) function;
  final String name;
}
