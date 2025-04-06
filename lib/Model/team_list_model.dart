// To parse this JSON data, do
//
//     final teamListModel = teamListModelFromJson(jsonString);

import 'dart:convert';

TeamListModel teamListModelFromJson(String str) => TeamListModel.fromJson(json.decode(str));

String teamListModelToJson(TeamListModel data) => json.encode(data.toJson());

class TeamListModel {
  TeamListModel({
    required this.allTeamListService,

  });

  List<AllTeamListService> allTeamListService;


  factory TeamListModel.fromJson(Map<String, dynamic> json) => TeamListModel(
    allTeamListService: List<AllTeamListService>.from(json["AllTeamListService"].map((x) => AllTeamListService.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "AllTeamListService": List<dynamic>.from(allTeamListService.map((x) => x.toJson())),

  };
}

class AllTeamListService {
  AllTeamListService({
    required this.teamId,
    required this.teamName,
    required this.teamNiceName,
    required  this.teamIcon,
    required  this.description,
  });

  int teamId;
  String teamName;
  String teamNiceName;
  String teamIcon;
  String description;

  factory AllTeamListService.fromJson(Map<String, dynamic> json) => AllTeamListService(
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
