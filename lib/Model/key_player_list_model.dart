// To parse this JSON data, do
//
//     final dataclass = dataclassFromJson(jsonString);

import 'dart:convert';


class TopList {
  TopList({
    required this.adTitle,
    required this.playerId,
    required this.teamId,
    required this.playerName,
    required this.playerImage,
    required this.playerTeam,
    required this.teamNiceName,
    required this.teamIcon,
    required this.playerType,
    required this.totalMatch,
    required this.batRun,
    required this.sixes,
    required this.fours,
    required this.balls,
    required this.strikeRate,
    required this.overs,
    required this.ballRun,
    required this.wickets,
    required this.maidenOver,
    required this.economyRate,
    required this.totalManOfMatch,
  });

  String adTitle;
  int playerId;
  int teamId;
  String playerName;
  String playerImage;
  String playerTeam;
  String teamNiceName;
  String teamIcon;
  int playerType;
  int totalMatch;
  int batRun;
  int sixes;
  int fours;
  int balls;
  double strikeRate;
  int overs;
  int ballRun;
  int wickets;
  int maidenOver;
  double economyRate;
  int totalManOfMatch;

  factory TopList.fromJson(Map<String, dynamic> json) => TopList(
    adTitle: json["adTitle"],
    playerId: json["playerId"],
    teamId: json["teamId"],
    playerName: json["playerName"],
    playerImage: json["playerImage"],
    playerTeam: json["playerTeam"],
    teamNiceName: json["teamNiceName"],
    teamIcon: json["teamIcon"],
    playerType: json["playerType"],
    totalMatch: json["totalMatch"],
    batRun: json["batRun"],
    sixes: json["sixes"],
    fours: json["fours"],
    balls: json["balls"],
    strikeRate: json["strikeRate"].toDouble(),
    overs: json["overs"].toInt()??0,
    ballRun: json["ballRun"],
    wickets: json["wickets"],
    maidenOver: json["maidenOver"],
    economyRate: json["economyRate"].toDouble(),
    totalManOfMatch: json["totalManOfMatch"],
  );

  Map<String, dynamic> toJson() => {
    "adTitle": adTitle,
    "playerId": playerId,
    "teamId": teamId,
    "playerName": playerName,
    "playerImage": playerImage,
    "playerTeam": playerTeam,
    "teamNiceName": teamNiceName,
    "teamIcon": teamIcon,
    "playerType": playerType,
    "totalMatch": totalMatch,
    "batRun": batRun,
    "sixes": sixes,
    "fours": fours,
    "balls": balls,
    "strikeRate": strikeRate,
    "overs": overs,
    "ballRun": ballRun,
    "wickets": wickets,
    "maidenOver": maidenOver,
    "economyRate": economyRate,
    "totalManOfMatch": totalManOfMatch,
  };
}
