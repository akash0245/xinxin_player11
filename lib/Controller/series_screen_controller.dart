import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/dasboard_models.dart';
import 'ads_controller.dart';


class SeriesScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<SeriesList> seriasList = RxList();
  bool isAdLoaded = false;
  AdsController adsController=Get.find();

  @override
  void onInit() {
    super.onInit();
    seriesData();

    adsController.loadNative(callBack:(){
      isLoading(true);
      isAdLoaded=true;
      isLoading(false);
    });
  }

  seriesData() async {
    isLoading(true);
    
    Map<String, String> body = {"serviceNo": 11.toString(),"tournamentId": 4.toString()};

    await apiCall(
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
            seriasList.addAll(data.seriesList);
          } else {
            //Utils.snackBar('Error fetching data!');
          }
          isLoading(false);
        });
  }

}
