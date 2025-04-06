import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/compare_team_model.dart';
import '../Utils/utils.dart';
import 'ads_controller.dart';

class CompareTeamsController extends GetxController {
  RxBool isLoading = true.obs;

  RxString selectedSearies ="".obs;
  RxInt selectedSeariesIndex =0.obs;

  RxString selectedTeam1 = "".obs;
  RxInt selectedTeam1Id = 0.obs;
  RxString selectedTeam2 = "".obs;
  RxInt selectedTeam2Id = 0.obs;

  RxList<TeamListService> teamListData = RxList();

  AdsController adsController=Get.find();
  bool isAdLoaded = false;
  @override
  void onInit() {
    super.onInit();
    compareDataApi();
    adsController.loadNative(callBack:(){
      isLoading(true);
      isAdLoaded=true;
      isLoading(false);
    });
  }

  compareDataApi() async {
    isLoading(true);

    Map<String, String> body = {"serviceNo": 12.toString()};

    await apiCall(
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
            teamListData.addAll(data.teamListService);
            selectedSearies.value = teamListData[0].seriesTitle;

            selectedTeam1 = teamListData[0].teamList[0].teamNiceName.obs;
            selectedTeam1Id=teamListData[0].teamList[0].teamId.obs;
            selectedTeam2 = teamListData[0].teamList[0].teamNiceName.obs;
            selectedTeam2Id=teamListData[0].teamList[0].teamId.obs;
          } else {
            //Utils.snackBar('Error fetching data!');
          }
          isLoading(false);
        });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
