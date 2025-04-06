import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../Api/api_call.dart';
import '../../Api/api_url.dart';
import '../../Model/match.dart';
import '../../Model/series_model.dart';
import '../../Utils/app_lifecycle_reactor.dart';
import '../../Utils/app_open_ad_manager.dart';
import '../../Utils/network_service.dart';
import '../../Utils/storage_service.dart';

class DashBoardController extends GetxController {
  final NetworkService networkService = Get.find<NetworkService>();

  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxBool showNoInternet = false.obs;
  var errorMessage = ''.obs;
  int seriesId = 0;
  RxList<Match> matchList = RxList();
  RxList<Series> seriesList = RxList();
  RxList<int> seriesListDots = RxList();
  RxInt currentSeriesSliderIndex = 0.obs;
  RxInt currentMatchSliderIndex = 0.obs;

  final _storage = StorageService();

  late AppLifecycleReactor _appLifecycleReactor;
  late NativeAd nativeAd1;
  late NativeAd nativeAd2;
  bool isAdLoaded1 = false;
  bool isAdLoaded2 = false;
  bool isAdLoaded = false;



  @override
  void onInit() {
    super.onInit();

    checkInternet();

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
        appOpenAdManager: appOpenAdManager);

    /*adsController.loadNative(callBack:(){
      isLoading(true);
      isAdLoaded=true;
      isLoading(false);
    });*/
  }

  checkInternet() async {
    isLoading(true);
    bool isInternet = await networkService.checkInternetConnection();

    if(isInternet){
      fetchSeriesData();
    } else {
      showNoInternet.value = true;
      errorMessage.value = 'No internet connection';
    }
  }


  fetchSeriesData() async {
    try {
      isLoading(true);
      errorMessage('');

      await apiCall(
          endPoint: 'get-series',
          body: {
            "tournamentId": '2',
            "eSeriesType": '',
            "limit": '0',
          },
          header: ApiUrl.reqHeader,
          apiType: ApiType.POST,
          isMultiRequest: false,
          onSuccess: (data, status, statusCode) {
            debugPrint('after get-series api call status: $status statusCode: $statusCode');

            if (status) {
              final seriesResponse = SeriesResponse.fromJson(data);
              seriesList.value = seriesResponse.data;

              if(seriesList.isNotEmpty) {
                seriesId = seriesList[0].seriesId;
              }
            } else {
              isError(true);
              errorMessage(data['message']);
              throw Exception(data['message']);
            }
          });
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
    } finally {
      fetchMatchData();
    }
  }

  fetchMatchData() async {
    try {
      await apiCall(
          endPoint: 'matchlist',
          body: {
            'seriesId': seriesId.toString(),
            'eFormat': '0',
            'limit': '10'
          },
          header: ApiUrl.reqHeader,
          apiType: ApiType.POST,
          isMultiRequest: true,
          onSuccess: (data, status, statusCode) {
            debugPrint('after matchlist api call status: $status statusCode: $statusCode');

            if (status) {
              final matchResponse = MatchListResponse.fromJson(data);
              matchList.value = matchResponse.data;
            } else {
              isError(true);
              errorMessage(data['message']);
              throw Exception(data['message']);
            }
          });
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
