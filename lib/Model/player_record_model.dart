
class PlayerRecordResponse {
  final bool success;
  final int statusCode;
  final String message;
  final PlayerRecordData data;

  PlayerRecordResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PlayerRecordResponse.fromJson(Map<String, dynamic> json) {
    return PlayerRecordResponse(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: PlayerRecordData.fromJson(json['data']),
    );
  }
}

class PlayerRecordData {
  final int playerId;
  final String playerName;
  final String playerImg;
  final OppTeam objOppTeam;
  final OppPlayer objOppPlayer;
  final List<PlayerRecord> lstPlayerRecord;
  final List<PlayerRecord> lstPlayerLastFiveRecord;

  PlayerRecordData({
    required this.playerId,
    required this.playerName,
    required this.playerImg,
    required this.objOppTeam,
    required this.objOppPlayer,
    required this.lstPlayerRecord,
    required this.lstPlayerLastFiveRecord,
  });

  factory PlayerRecordData.fromJson(Map<String, dynamic> json) {
    return PlayerRecordData(
      playerId: json['player_id'],
      playerName: json['player_name'],
      playerImg: json['player_img'],
      objOppTeam: OppTeam.fromJson(json['obj_opp_team']),
      objOppPlayer: OppPlayer.fromJson(json['obj_opp_player']),
      lstPlayerRecord: List<PlayerRecord>.from(
          json['lst_player_record'].map((x) => PlayerRecord.fromJson(x))),
      lstPlayerLastFiveRecord: List<PlayerRecord>.from(
          json['lst_player_last_five_record'].map((x) => PlayerRecord.fromJson(x))),
    );
  }
}

class OppTeam {
  final String teamName;
  final String teamShortName;
  final String teamLogo;

  OppTeam({
    required this.teamName,
    required this.teamShortName,
    required this.teamLogo,
  });

  factory OppTeam.fromJson(Map<String, dynamic> json) {
    return OppTeam(
      teamName: json['team_name'],
      teamShortName: json['team_short_name'],
      teamLogo: json['team_logo'],
    );
  }
}

class OppPlayer {
  final int playerId;
  final String playerName;
  final String playerImg;

  OppPlayer({
    required this.playerId,
    required this.playerName,
    required this.playerImg,
  });

  factory OppPlayer.fromJson(Map<String, dynamic> json) {
    return OppPlayer(
      playerId: json['player_id'],
      playerName: json['player_name'],
      playerImg: json['player_img'],
    );
  }
}

class PlayerRecord {
  final int totalBall;
  final int batTotalRun;
  final int fours;
  final int sixes;
  final String strikeRate;
  final int batFantasyPoint;
  final int totalOver;
  final int bowTotalRun;
  final int wickets;
  final double economyRate;
  final int bowFantasyPoint;

  PlayerRecord({
    required this.totalBall,
    required this.batTotalRun,
    required this.fours,
    required this.sixes,
    required this.strikeRate,
    required this.batFantasyPoint,
    required this.totalOver,
    required this.bowTotalRun,
    required this.wickets,
    required this.economyRate,
    required this.bowFantasyPoint,
  });

  factory PlayerRecord.fromJson(Map<String, dynamic> json) {
    return PlayerRecord(
      totalBall: json['total_ball'],
      batTotalRun: json['bat_total_run'],
      fours: json['fours'],
      sixes: json['sixes'],
      strikeRate: json['strike_rate'],
      batFantasyPoint: json['bat_fantasy_point'],
      totalOver: json['total_over'],
      bowTotalRun: json['bow_total_run'],
      wickets: json['wickets'],
      economyRate: json['economy_rate']?.toDouble() ?? 0.0,
      bowFantasyPoint: json['bow_fantasy_point'],
    );
  }
}