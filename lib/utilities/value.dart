// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lets_enlist/models/enlist_model.dart';
import 'package:lets_enlist/utilities/color.dart';

const double PADDING = 256;

enum Branch {
  ALL("전체", BLACK, "ALL", LinearGradient(colors: [BLACK])),
  ROKA("육군", ROKAColor, "ROKA", ROKAGradient),
  ROKN("해군", ROKNColor, "ROKN", ROKNGradient),
  ROKAF("공군", ROKAFColor, "ROKAF", ROKAFGradient),
  ROKMC("해병대", ROKMCColor, "ROKMC", ROKMCGradient);

  const Branch(this.nameKor, this.color, this.nameEng, this.gradientColor);

  final String nameKor;
  final Color color;
  final String nameEng;
  final LinearGradient gradientColor;
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

enum FilterType {
  ALL(filterAll, "전체"), // filterAll
  PAST(filterPast, "마감"), // filterPast
  CURRENT(filterCurrent, "진행중"); // filterCurrnet

  const FilterType(this.function, this.name);

  final bool Function(EnlistModel) function;
  final String name;
}

enum ChatType {
  User(
    MainAxisAlignment.end,
    EdgeInsets.only(
      top: 16,
      bottom: 16,
      left: 64,
      right: 32,
    ),
    BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.zero,
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  ),
  Gemeni(
    MainAxisAlignment.start,
    EdgeInsets.only(
      top: 16,
      bottom: 16,
      left: 32,
      right: 64,
    ),
    BorderRadius.only(
      topLeft: Radius.zero,
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  );

  const ChatType(
    this.mainAxisAlignment,
    this.edgeInsets,
    this.borderRadius,
  );

  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets edgeInsets;
  final BorderRadius borderRadius;
}
