import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/key_player_list_model.dart';
import 'ads_controller.dart';

class KeyPlayerScreenController extends GetxController {
  RxBool isLoading = true.obs;

  RxInt isTabPressed = 1.obs;

  RxList<TopList> topBatsmanList=RxList();
  RxList<TopList> topBowlerList=RxList();
  RxList<TopList> topAllRounderList=RxList();


  int team1Id = Get.arguments[0];
  int team2Id = Get.arguments[1];

  AdsController adsController=Get.find();
  bool isAdLoaded = false;
  @override
  void onInit() {
    super.onInit();
    keyPlayerListData();
    adsController.loadNative(callBack:(){
      isLoading(true);
      isAdLoaded=true;
      isLoading(false);
    });
  }

  void changeTab(int number) {
    isLoading(true);
    isTabPressed=number.obs;
    isLoading(false);
  }



  keyPlayerListData() async {
    isLoading(true);

    Map<String, String> body = {"serviceNo": 5.toString(),"team1Id": team1Id.toString(),"team2Id": team2Id.toString()};

    await apiCall(
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
            topBatsmanList.addAll(data.topBatsmanList);
            topBowlerList.addAll(data.topBowlerList);
            topAllRounderList.addAll(data.topAllRounderList);

          } else {
            //Utils.snackBar('Error fetching data!');
          }
          isLoading(false);
        });
  }

}
