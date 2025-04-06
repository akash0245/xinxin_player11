
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/data.dart';
import '../Model/match_status_model.dart';


class MatchStatusScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<RecMatchListService> recentMatchList = RxList();
  RxInt currentSliderIndex = 0.obs;
  late DataClass allData;
  double teamOneRate=0;
  double teamTwoRate=0;
  int team1Id = Get.arguments[0];
  int team2Id = Get.arguments[1];

  @override
  void onInit() {
    super.onInit();
    matchStatusData();
  }



  matchStatusData() async {
    isLoading(true);

    Map<String, String> body = {"serviceNo": 2.toString(),"team1Id": team1Id.toString(),"team2Id": team2Id.toString()};

    await apiCall(
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
            allData = data;
            recentMatchList.addAll(data.recMatchListService);

            teamOneRate = allData.team1WinMatch/allData.totalMatch*100;
            teamTwoRate = allData.team2WinMatch/allData.totalMatch*100;
            teamOneRate.toString()=="NaN"?teamOneRate=0:teamOneRate.ceil();
            teamTwoRate.toString()=="NaN"?teamTwoRate=0:teamTwoRate.floor();

          } else {
            //Utils.snackBar('Error fetching data!');
          }
          isLoading(false);
        });
  }

}
