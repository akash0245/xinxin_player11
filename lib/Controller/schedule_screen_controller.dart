import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/dasboard_models.dart';
import 'ads_controller.dart';



class ScheduleScreenController extends GetxController {
  AdsController adsController=Get.find();
  RxBool isLoading = true.obs;
  RxBool isDataSubmit = true.obs;
  RxList<MatchList> schedulematchList = RxList();
  int pageNumber=1;
  bool apiCalling = true;
  ScrollController scrollController = ScrollController();
  int seriasId = Get.arguments[0];
  bool isAdLoaded = false;

  @override
  void onInit() {
    super.onInit();
    scheduleData();
    adsController.loadNative(callBack:(){
      isLoading(true);
      isAdLoaded=true;
      isLoading(false);
    });

    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && apiCalling){
          pageNumber++;
          scheduleData();
      }
    });
  }

  scheduleData() async {
    pageNumber == 1?isLoading(true):isDataSubmit(true);

    Map<String, String> body = {"serviceNo": 10.toString(),"seriesId": seriasId.toString(),"pageNo": pageNumber.toString()};

    await apiCall(
        endPoint: ApiUrl.baseUrl,
        body: body,
        header: ApiUrl.reqHeader2,
        apiType: ApiType.POST,
        isMultiRequest: false,
        onSuccess: (data, status, statusCode) {
          debugPrint('after api call status: $status statusCode: $statusCode');

          if (status) {
              schedulematchList.addAll(data.matchList);
          } else {
            //Utils.snackBar('Error fetching data!');
            apiCalling=false;
          }
          isLoading(false);
          isDataSubmit(false);
        });
  }


}
