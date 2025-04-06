class Match {
  final int matchId;
  final int seriesId;
  final String matchTitle;
  final int team1Id;
  final String team1Name;
  final String team1ShortName;
  final String team1Logo;
  final int team2Id;
  final String team2Name;
  final String team2ShortName;
  final String team2Logo;
  final String eFormat;
  final String stadiumName;
  final String stadiumLocation;
  final DateTime matchTime;
  final int team1Score;
  final int team2Score;
  final String winningText;
  final String winningTeam;

  Match({
    required this.matchId,
    required this.seriesId,
    required this.matchTitle,
    required this.team1Id,
    required this.team1Name,
    required this.team1ShortName,
    required this.team1Logo,
    required this.team2Id,
    required this.team2Name,
    required this.team2ShortName,
    required this.team2Logo,
    required this.eFormat,
    required this.stadiumName,
    required this.stadiumLocation,
    required this.matchTime,
    required this.team1Score,
    required this.team2Score,
    required this.winningText,
    required this.winningTeam,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      matchId: json['matchId'] ?? 0,
      seriesId: json['seriesId'] ?? 0,
      matchTitle: json['matchTitle'] ?? '',
      team1Id: json['team1Id'] ?? 0,
      team1Name: json['team1Name'] ?? '',
      team1ShortName: json['team1ShortName'] ?? '',
      team1Logo: json['team1Logo'] ?? '',
      team2Id: json['team2Id'] ?? 0,
      team2Name: json['team2Name'] ?? '',
      team2ShortName: json['team2ShortName'] ?? '',
      team2Logo: json['team2Logo'] ?? '',
      eFormat: json['eFormat'] ?? '',
      stadiumName: json['stadiumName'] ?? '',
      stadiumLocation: json['stadiumLocation'] ?? '',
      matchTime: DateTime.parse(json['matchTime'] ?? '1970-01-01 00:00:00'),
      team1Score: json['team1Score'] ?? 0,
      team2Score: json['team2Score'] ?? 0,
      winningText: json['winningText'] ?? '',
      winningTeam: json['winningTeam'] ?? '',
    );
  }
}

class MatchListResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Match> data;

  MatchListResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MatchListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Match> matches = list.map((i) => Match.fromJson(i)).toList();

    return MatchListResponse(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: matches,
    );
  }
}