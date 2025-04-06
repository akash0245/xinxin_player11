import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/player_perfomance.dart';
import '../Model/team_list_model.dart';
import 'ads_controller.dart';

class ProfileScreenController extends GetxController {
  AdsController adsController=Get.find();
  bool isAdLoaded = false;
  bool isFirstTimeLoad = true;
  RxBool isLoaderShow = false.obs;

  RxBool isLoading = true.obs;
  String playerName="";
  String playerImage="";
  RxList<BatingPerformance> batingPerformance=RxList();
  RxList<BowlingPerformance> bowlingPerformance=RxList();
  var selected = "SRH".obs;

  RxList<AllTeamListService> allTeamListService = RxList();

   void setSelected(String value){
    selected.value = value;
  }
  int teamId = 0;
  int playerId = Get.arguments[1];

  @override
  void onInit() {
    super.onInit();
    teamListData();

  }

  profileScreenData() async {

    if(isFirstTimeLoad){
      isLoading(true);
      isFirstTimeLoad=false;
    }else{
      isLoaderShow(true);
    }

    Map<String, String> body = {"serviceNo": 7.toString(),"teamId": teamId.toString(),"playerId": playerId.toString()};
    await apiCall(
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
            debugPrint('data.matchList.length: ${data.matchList.length}');
            playerName = data.playerInfo[0].playerName;
            playerImage = data.playerInfo[0].playerImage;
            batingPerformance.clear();
            batingPerformance.addAll(data.batingPerformance);
            bowlingPerformance.clear();
            bowlingPerformance.addAll(data.bowlingPerformance);
          } else {
             //Utils.snackBar('Error fetching data!');
          }
          isLoading(false);
          isLoaderShow(false);
        });
  }

  teamListData() async {
    isLoading(true);

    Map<String, String> body = {"serviceNo": 1.toString()};
    await apiCall (
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) async {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
            debugPrint('data.matchList.length: ${data.matchList.length}');

            allTeamListService.addAll(data.allTeamListService);
            selected.value=allTeamListService[0].teamNiceName;
            await profileScreenData();

            adsController.loadNative(callBack:(){
              isLoading(true);
              isAdLoaded=true;
              isLoading(false);
            });

          } else {
             //Utils.snackBar('Error fetching data!');
          }
          isLoading(false);
        });
  }

}
