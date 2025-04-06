import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Model/splash_model.dart';
import '../Utils/AdHelper.dart';
import '../Widget/color_helper.dart';
import 'package:http/http.dart' as http;

final dataStorage = GetStorage();

class AdsController extends GetxController{
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  int clickEvent = 0;
  var splashAdCounter;
  var nativeBannerAdUnit;
  var interstitial1AdUnit;

  @override
  void onInit() {
    super.onInit();
    // SplashDataFetch();

    // if (dataStorage.read("splashAdCounter") == null || dataStorage.read("nativeBannerAdUnit") == null || dataStorage.read("interstitial1AdUnit") == null) {
    //   dataStorage.writeIfNull("splashAdCounter", "");
    //   dataStorage.writeIfNull("nativeBannerAdUnit", "");
    //   dataStorage.writeIfNull("interstitial1AdUnit", "");
    // } else {
    //   splashAdCounter = dataStorage.read("splashAdCounter");
    //   nativeBannerAdUnit = dataStorage.read("nativeBannerAdUnit");
    //   interstitial1AdUnit = dataStorage.read("interstitial1AdUnit");
    //   debugPrint("splashAdCounter is========>>>${splashAdCounter}");
    //   debugPrint("nativeBannerAdUnit is========>>>${nativeBannerAdUnit}");
    //   debugPrint("interstitial1AdUnit is========>>>${interstitial1AdUnit}");
    // }
  }

  SplashDataFetch ()async {
    var headers = {
      'Content-Type': 'text/plain'
    };
    var request = http.Request('POST', Uri.parse('https://appmanage.matoresell.com/WebServices.php'));
    request.body = '''{"deviceId":"1","uniqPcId":"1008","appPackage":"com.prediction.prediction"}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responcebody =  await response.stream.bytesToString();

    if (response.statusCode == 200) {
      SplashData splashData = SplashData.fromJson(json.decode(responcebody));
      debugPrint("res=============>>>${response.statusCode}");
      // dataStorage.write("splashAdCounter", splashData.splashAdCounter);
      // dataStorage.write("nativeBannerAdUnit", splashData.nativeBannerAdUnit);
      // dataStorage.write("interstitial1AdUnit", splashData.interstitial1AdUnit);
      // splashAdCounter = dataStorage.read("splashAdCounter");
      // nativeBannerAdUnit = dataStorage.read("nativeBannerAdUnit");
      // interstitial1AdUnit = dataStorage.read("interstitial1AdUnit");
      splashAdCounter = 1;
      interstitial1AdUnit = "ca-app-pub-3940256099942544/1033173712";
      nativeBannerAdUnit = "ca-app-pub-3940256099942544/2247696110";
      // static String openAdId = "ca-app-pub-3940256099942544/3419835294";
      debugPrint("splashAdCounter========= is========>>>${splashAdCounter.toString()}");
      debugPrint("nativeBannerAdUnit============ is========>>>${nativeBannerAdUnit.toString()}");
      debugPrint("interstitial1AdUnit========= is========>>>${interstitial1AdUnit.toString()}");
    }
    else {
      debugPrint(response.reasonPhrase);
    }
  }

  static final AdRequest request = AdRequest(
    /*keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',*/
    nonPersonalizedAds: true,
  );

  loadShowAdsManager(){
    // clickEvent++;
    // if(clickEvent == 2){
    //   _createInterstitialAd();
    // }else if(clickEvent == 3){
    //   _showInterstitialAd();
    // }
    clickEvent++;
    if(clickEvent == (splashAdCounter == null ? 2 : splashAdCounter - 1)){
      _createInterstitialAd();
    }else if(clickEvent == (splashAdCounter ?? 3)){
      _showInterstitialAd();
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitial1AdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            _interstitialAd = ad;

            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;

          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        clickEvent = 0;
        _interstitialAd = null;
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
    );
    _interstitialAd!.show();
  }

  late NativeAd nativeAd;

  void loadNative({required Function ()callBack}){
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          debugPrint('native loaded');
          callBack();
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          debugPrint('Ad load failed (code=${error.code} message=${error.message})');       },
      ),
    );
    nativeAd.load();
  }

  Widget nativeAdsPart(double height,double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Container(
        height: height*0.27,
        width: width * 0.95,
        decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
        child: AdWidget(ad: nativeAd),
      ),
    );
  }
}