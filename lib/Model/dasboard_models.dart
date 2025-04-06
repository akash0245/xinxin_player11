class MatchList {
  MatchList({
    this.adTitle = '',
    this.matchId = 0,
    this.matchIndexNum = 0,
    this.seriesId = 0,
    this.seriesTitle = '',
    this.team1Id = 0,
    this.team2Id = 0,
    this.team1Name = '',
    this.team2Name = '',
    this.team1NiceName = '',
    this.team2NiceName = '',
    this.team1Icon = '',
    this.team2Icon = '',
    this.team1Run = '',
    this.team2Run = '',
    this.textLine = '',
    this.stadiumName = '',
    this.stadiumCity = '',
    this.stadiumCountry = '',
    this.matchDate = '',
    this.ground = '',
  });

  String adTitle;
  int matchId;
  int matchIndexNum;
  int seriesId;
  String seriesTitle;
  int team1Id;
  int team2Id;
  String team1Name;
  String team2Name;
  String team1NiceName;
  String team2NiceName;
  String team1Icon;
  String team2Icon;
  String team1Run;
  String team2Run;
  String textLine;
  String stadiumName;
  String stadiumCity;
  String stadiumCountry;
  String matchDate;
  String ground;

  factory MatchList.fromJson(Map<String, dynamic> json) => MatchList(
        adTitle: json["adTitle"] ?? '',
        matchId: json["matchId"] ?? 0,
        matchIndexNum: json["matchIndexNum"] ?? 0,
        seriesId: json["seriesId"] ?? 0,
        seriesTitle: json["SeriesTitle"] ?? '',
        team1Id: json["team1Id"] ?? 0,
        team2Id: json["team2Id"] ?? 0,
        team1Name: json["team1Name"] ?? '',
        team2Name: json["team2Name"] ?? '',
        team1NiceName: json["team1NiceName"] ?? '',
        team2NiceName: json["team2NiceName"] ?? '',
        team1Icon: json["team1Icon"] ?? '',
        team2Icon: json["team2Icon"] ?? '',
        team1Run: json["team1Run"] ?? '',
        team2Run: json["team2Run"] ?? '',
        textLine: json["textLine"] ?? '',
        stadiumName: json["stadiumName"] ?? '',
        stadiumCity: json["stadiumCity"] ?? '',
        stadiumCountry: json["stadiumCountry"] ?? '',
        matchDate: json["matchDate"] ?? '',
        ground: json["ground"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "adTitle": adTitle,
        "matchId": matchId,
        "matchIndexNum": matchIndexNum,
        "seriesId": seriesId,
        "SeriesTitle": seriesTitle,
        "team1Id": team1Id,
        "team2Id": team2Id,
        "team1Name": team1Name,
        "team2Name": team2Name,
        "team1NiceName": team1NiceName,
        "team2NiceName": team2NiceName,
        "team1Icon": team1Icon,
        "team2Icon": team2Icon,
        "team1Run": team1Run,
        "team2Run": team2Run,
        "textLine": textLine,
        "stadiumName": stadiumName,
        "stadiumCity": stadiumCity,
        "stadiumCountry": stadiumCountry,
        "matchDate": matchDate,
        "ground": ground,
      };
}

class MatchTypeList {
  MatchTypeList({
    this.title = '',
    this.matchType = 0,
  });

  String title;
  int matchType;

  factory MatchTypeList.fromJson(Map<String, dynamic> json) => MatchTypeList(
        title: json["title"] ?? '',
        matchType: json["matchType"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "matchType": matchType,
      };
}

class SeriesList {
  SeriesList({
    this.adTitle = '',
    this.seriesId = 0,
    this.seriesTitle = '',
    this.tournamentName = '',
    this.team1Icon = '',
    this.team2Icon = '',
    required this.teamIconList,
    this.playingTeams = 0,
    this.timePeriod = '',
    this.startDate = '',
    this.lastDate = '',
  });

  String adTitle;
  int seriesId;
  String seriesTitle;
  String tournamentName;
  String team1Icon;
  String team2Icon;
  List<TeamIconList> teamIconList;
  int playingTeams;
  String timePeriod;
  String startDate;
  String lastDate;

  factory SeriesList.fromJson(Map<String, dynamic> json) => SeriesList(
        adTitle: json["adTitle"] ?? '',
        seriesId: json["seriesId"] ?? 0,
        seriesTitle: json["seriesTitle"] ?? '',
        tournamentName: json["tournamentName"] ?? '',
        team1Icon: json["team1Icon"] ?? '',
        team2Icon: json["team2Icon"] ?? '',
        teamIconList: json["teamIconList"] != null ? List<TeamIconList>.from(json["teamIconList"].map((x) => TeamIconList.fromJson(x))) : [],
        playingTeams: json["playingTeams"] ?? 0,
        timePeriod: json["timePeriod"] ?? '',
        startDate: json["startDate"] ?? '',
        lastDate: json["lastDate"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "adTitle": adTitle,
        "seriesId": seriesId,
        "seriesTitle": seriesTitle,
        "tournamentName": tournamentName,
        "team1Icon": team1Icon,
        "team2Icon": team2Icon,
        "teamIconList": List<dynamic>.from(teamIconList.map((x) => x.toJson())),
        "playingTeams": playingTeams,
        "timePeriod": timePeriod,
        "startDate": startDate,
        "lastDate": lastDate,
      };
}

class TeamIconList {
  TeamIconList({
    this.teamName = '',
    this.teamNiceName = '',
    this.teamIcon = '',
  });

  String teamName;
  String teamNiceName;
  String teamIcon;

  factory TeamIconList.fromJson(Map<String, dynamic> json) => TeamIconList(
        teamName: json["teamName"] ?? '',
        teamNiceName: json["teamNiceName"] ?? '',
        teamIcon: json["teamIcon"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "teamName": teamName,
        "teamNiceName": teamNiceName,
        "teamIcon": teamIcon,
      };
}

class TournamentsList {
  TournamentsList({
    this.tournamentId = 0,
    this.tournamentTitle = '',
  });

  int tournamentId;
  String tournamentTitle;

  factory TournamentsList.fromJson(Map<String, dynamic> json) => TournamentsList(
        tournamentId: json["tournamentId"] ?? 0,
        tournamentTitle: json["tournamentTitle"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tournamentId": tournamentId,
        "tournamentTitle": tournamentTitle,
      };
}
