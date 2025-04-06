// To parse this JSON data, do
//
//     final compareTeamModel = compareTeamModelFromJson(jsonString);

import 'dart:convert';

CompareTeamModel compareTeamModelFromJson(String str) => CompareTeamModel.fromJson(json.decode(str));

String compareTeamModelToJson(CompareTeamModel data) => json.encode(data.toJson());

class CompareTeamModel {
  CompareTeamModel({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory CompareTeamModel.fromJson(Map<String, dynamic> json) => CompareTeamModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

class TeamListService {
  TeamListService({
    required this.seriesId,
    required this.seriesTitle,
    required this.teamList,
  });

  int seriesId;
  String seriesTitle;
  List<TeamList> teamList;

  factory TeamListService.fromJson(Map<String, dynamic> json) => TeamListService(
    seriesId: json["seriesId"],
    seriesTitle: json["seriesTitle"],
    teamList: List<TeamList>.from(json["teamList"].map((x) => TeamList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seriesId": seriesId,
    "seriesTitle": seriesTitle,
    "teamList": List<dynamic>.from(teamList.map((x) => x.toJson())),
  };
}

class TeamList {
  TeamList({
    required this.teamId,
    required this.teamName,
    required this.teamNiceName,
    required this.teamIcon,
    required this.description,
  });

  int teamId;
  String teamName;
  String teamNiceName;
  String teamIcon;
  String description;

  factory TeamList.fromJson(Map<String, dynamic> json) => TeamList(
    teamId: json["teamId"],
    teamName: json["teamName"],
    teamNiceName: json["teamNiceName"],
    teamIcon: json["teamIcon"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "teamId": teamId,
    "teamName": teamName,
    "teamNiceName": teamNiceName,
    "teamIcon": teamIcon,
    "description": description,
  };
}
