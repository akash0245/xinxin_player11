
class BatingPerformance {
  BatingPerformance({
    required this.teamNiceName,
    required this.teamIcon,
    required this.batRun,
    required this.sixes,
    required this.fours,
    required this.balls,
    required this.strikeRate,
    required this.date,
  });

  String teamNiceName;
  String teamIcon;
  int batRun;
  int sixes;
  int fours;
  int balls;
  int strikeRate;
  String date;

  factory BatingPerformance.fromJson(Map<String, dynamic> json) => BatingPerformance(
    teamNiceName: json["teamNiceName"]??"",
    teamIcon: json["teamIcon"]??"",
    batRun: json["batRun"]??0,
    sixes: json["sixes"]??0,
    fours: json["fours"]??0,
    balls: json["balls"]??0,
    strikeRate: json["strikeRate"].toInt()??0,
    date: json["date"]??"",
  );

  Map<String, dynamic> toJson() => {
    "teamNiceName": teamNiceName,
    "teamIcon": teamIcon,
    "batRun": batRun,
    "sixes": sixes,
    "fours": fours,
    "balls": balls,
    "strikeRate": strikeRate,
    "date": date,
  };
}

class BowlingPerformance {
  BowlingPerformance({
    required this.teamNiceName,
    required this.teamIcon,
    required this.overs,
    required this.ballRun,
    required this.wickets,
    required this.maidenOver,
    required this.economyRate,
    required this.isManOfMatch,
    required this.date,
  });

  String teamNiceName;
  String teamIcon;
  int overs;
  int ballRun;
  int wickets;
  int maidenOver;
  double economyRate;
  int isManOfMatch;
  String date;

  factory BowlingPerformance.fromJson(Map<String, dynamic> json) => BowlingPerformance(
    teamNiceName: json["teamNiceName"],
    teamIcon: json["teamIcon"],
    overs: json["overs"],
    ballRun: json["ballRun"],
    wickets: json["wickets"],
    maidenOver: json["maidenOver"],
    economyRate: json["economyRate"].toDouble(),
    isManOfMatch: json["isManOfMatch"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "teamNiceName": teamNiceName,
    "teamIcon": teamIcon,
    "overs": overs,
    "ballRun": ballRun,
    "wickets": wickets,
    "maidenOver": maidenOver,
    "economyRate": economyRate,
    "isManOfMatch": isManOfMatch,
    "date": date,
  };
}

class PlayerInfo {
  PlayerInfo({
    required this.playerName,
    required this.playerImage,
  });

  String playerName;
  String playerImage;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => PlayerInfo(
    playerName: json["playerName"]??"",
    playerImage: json["playerImage"]??"",
  );

  Map<String, dynamic> toJson() => {
    "playerName": playerName,
    "playerImage": playerImage,
  };
}
