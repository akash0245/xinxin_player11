import 'dart:convert';

import 'compare_team_model.dart';
import 'dasboard_models.dart';
import 'key_player_list_model.dart';
import 'match_status_model.dart';
import 'player_perfomance.dart';
import 'team_list_model.dart';

DataClass dataFromJson(String str) => DataClass.fromJson(json.decode(str));

// String emptyToJson(Data data) => json.encode(data.toJson());

class DataClass {
  DataClass({
    required this.matchList,
    required this.seriesList,
    required this.tournamentsList,
    required this.matchTypeList,
    required this.status,
    required this.message,
    required this.playerInfo,
    required this.batingPerformance,
    required this.bowlingPerformance,
    required this.topBatsmanList,
    required this.topBowlerList,
    required this.topAllRounderList,

    required this.team1,
    required this.team2,
    required this.team1NiceName,
    required this.team2NiceName,
    required this.team1Icon,
    required this.team2Icon,
    required this.totalMatch,
    required this.team1WinMatch,
    required this.team2WinMatch,
    required this.team1LoseMatch,
    required this.team2LoseMatch,
    required this.noResultMatch,
    required this.recMatchListService,
    required this.oldMatchListService,
    required this.teamListService,
    required this.allTeamListService,

  });

  List<MatchList> matchList;
  List<SeriesList> seriesList;
  List<TournamentsList> tournamentsList;
  List<MatchTypeList> matchTypeList;
  bool status;
  String message;
  List<PlayerInfo> playerInfo;
  List<BatingPerformance> batingPerformance;
  List<BowlingPerformance> bowlingPerformance;
  List<TopList> topBatsmanList;
  List<TopList> topBowlerList;
  List<TopList> topAllRounderList;

  String team1;
  String team2;
  String team1NiceName;
  String team2NiceName;
  String team1Icon;
  String team2Icon;
  int totalMatch;
  int team1WinMatch;
  int team2WinMatch;
  int team1LoseMatch;
  int team2LoseMatch;
  int noResultMatch;
  List<RecMatchListService> recMatchListService;
  List<OldMatchListService> oldMatchListService;
  List<TeamListService> teamListService;
  List<AllTeamListService> allTeamListService;


  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        matchList: json["MatchList"] != null ? List<MatchList>.from(json["MatchList"].map((x) => MatchList.fromJson(x))) : [],
        seriesList: json["SeriesList"] != null ? List<SeriesList>.from(json["SeriesList"].map((x) => SeriesList.fromJson(x))) : [],
        tournamentsList: json["TournamentsList"] != null ? List<TournamentsList>.from(json["TournamentsList"].map((x) => TournamentsList.fromJson(x))) : [],
        matchTypeList: json["matchTypeList"] != null ? List<MatchTypeList>.from(json["matchTypeList"].map((x) => MatchTypeList.fromJson(x))) : [],
        playerInfo: json["PlayerInfo"]!=null?List<PlayerInfo>.from(json["PlayerInfo"].map((x) => PlayerInfo.fromJson(x))):[],
        batingPerformance: json["BatingPerformance"]!=null?List<BatingPerformance>.from(json["BatingPerformance"].map((x) => BatingPerformance.fromJson(x))):[],
        bowlingPerformance: json["BowlingPerformance"]!=null?List<BowlingPerformance>.from(json["BowlingPerformance"].map((x) => BowlingPerformance.fromJson(x))):[],
        topBatsmanList:json["TopBatsmanList"]!=null? List<TopList>.from(json["TopBatsmanList"].map((x) => TopList.fromJson(x))):[],
        topBowlerList: json["TopBowlerList"]!=null?List<TopList>.from(json["TopBowlerList"].map((x) => TopList.fromJson(x))):[],
        topAllRounderList: json["TopAllRounderList"]!=null ? List<TopList>.from(json["TopAllRounderList"].map((x) => TopList.fromJson(x))):[],
        team1: json["Team1"]??"",
        team2: json["Team2"]??"",
        team1NiceName: json["Team1NiceName"]??"",
        team2NiceName: json["Team2NiceName"]??"",
        team1Icon: json["Team1Icon"]??"",
        team2Icon: json["Team2Icon"]??"",
        totalMatch: json["TotalMatch"]??0,
        team1WinMatch: json["Team1WinMatch"]??0,
        team2WinMatch: json["Team2WinMatch"]??0,
        team1LoseMatch: json["Team1LoseMatch"]??0,
        team2LoseMatch: json["Team2LoseMatch"]??0,
        noResultMatch: json["NoResultMatch"]??0,
        recMatchListService:json["RecMatchListService"]!=null? List<RecMatchListService>.from(json["RecMatchListService"].map((x) => RecMatchListService.fromJson(x))):[],
        oldMatchListService:json["OldMatchListService"]!=null? List<OldMatchListService>.from(json["OldMatchListService"].map((x) => OldMatchListService.fromJson(x))):[],
        teamListService: json["TeamListService"]!=null ? List<TeamListService>.from(json["TeamListService"].map((x) => TeamListService.fromJson(x))):[],
        allTeamListService: json["AllTeamListService"]!=null ? List<AllTeamListService>.from(json["AllTeamListService"].map((x) => AllTeamListService.fromJson(x))):[],


        status: json["status"],
        message: json["message"],
      );
}
