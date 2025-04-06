// To parse this JSON data, do
//
//     final matchStatusModel = matchStatusModelFromJson(jsonString);

import 'dart:convert';

MatchStatusModel matchStatusModelFromJson(String str) => MatchStatusModel.fromJson(json.decode(str));

String matchStatusModelToJson(MatchStatusModel data) => json.encode(data.toJson());

class MatchStatusModel {
  MatchStatusModel({

    required this.status,
    required this.message,
  });


  bool status;
  String message;

  factory MatchStatusModel.fromJson(Map<String, dynamic> json) => MatchStatusModel(

    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {

    "status": status,
    "message": message,
  };
}

class OldMatchListService {
  OldMatchListService({
    required this.matchYear,
    required this.yearTotalMatch,
    required this.team1WinMatch,
    required this.team2WinMatch,
  });

  int matchYear;
  int yearTotalMatch;
  int team1WinMatch;
  int team2WinMatch;

  factory OldMatchListService.fromJson(Map<String, dynamic> json) => OldMatchListService(
    matchYear: json["matchYear"],
    yearTotalMatch: json["yearTotalMatch"],
    team1WinMatch: json["team1WinMatch"],
    team2WinMatch: json["team2WinMatch"],
  );

  Map<String, dynamic> toJson() => {
    "matchYear": matchYear,
    "yearTotalMatch": yearTotalMatch,
    "team1WinMatch": team1WinMatch,
    "team2WinMatch": team2WinMatch,
  };
}

class RecMatchListService {
  RecMatchListService({
    required this.matchId,
    required this.seriesTitle,
    required this.matchIndexNum,
    required this.matchYear,
    required this.team1Name,
    required this.team2Name,
    required this.team1NiceName,
    required this.team2NiceName,
    required this.team1Icon,
    required this.team2Icon,
    required this.team1Run,
    required this.team2Run,
    required this.manOfMatch,
    required this.winText,
    required this.stadiumName,
    required this.stadiumCity,
    required this.stadiumCountry,
    required this.matchDate,
  });

  int matchId;
  String seriesTitle;
  int matchIndexNum;
  int matchYear;
  String team1Name;
  String team2Name;
  String team1NiceName;
  String team2NiceName;
  String team1Icon;
  String team2Icon;
  String team1Run;
  String team2Run;
  String manOfMatch;
  String winText;
  String stadiumName;
  String stadiumCity;
  String stadiumCountry;
  String matchDate;

  factory RecMatchListService.fromJson(Map<String, dynamic> json) => RecMatchListService(
    matchId: json["matchId"],
    seriesTitle: json["seriesTitle"],
    matchIndexNum: json["matchIndexNum"],
    matchYear: json["matchYear"],
    team1Name: json["team1Name"],
    team2Name: json["team2Name"],
    team1NiceName: json["team1NiceName"],
    team2NiceName: json["team2NiceName"],
    team1Icon: json["team1Icon"],
    team2Icon: json["team2Icon"],
    team1Run: json["team1Run"],
    team2Run: json["team2Run"],
    manOfMatch: json["manOfMatch"],
    winText: json["winText"],
    stadiumName: json["stadiumName"],
    stadiumCity: json["stadiumCity"],
    stadiumCountry: json["stadiumCountry"],
    matchDate: json["matchDate"],
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "seriesTitle": seriesTitle,
    "matchIndexNum": matchIndexNum,
    "matchYear": matchYear,
    "team1Name": team1Name,
    "team2Name": team2Name,
    "team1NiceName": team1NiceName,
    "team2NiceName": team2NiceName,
    "team1Icon": team1Icon,
    "team2Icon": team2Icon,
    "team1Run": team1Run,
    "team2Run": team2Run,
    "manOfMatch": manOfMatch,
    "winText": winText,
    "stadiumName": stadiumName,
    "stadiumCity": stadiumCity,
    "stadiumCountry": stadiumCountry,
    "matchDate": matchDate,
  };
}
