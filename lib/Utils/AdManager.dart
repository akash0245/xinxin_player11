import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static AppOpenAd? _appOpenAd;  // Application na splash pa6i batavva mate 1 j var aano use karelo chhe
  static InterstitialAd? _interstitialAd;
  static bool _isAppOpenAdLoaded = false;
  static bool _isShowingAppOpenAd = false;
  static bool _isInterstitialAdLoaded = false;

  /// Load App Open Ad
  static void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx',
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAppOpenAdLoaded = true;
          debugPrint("App Open Ad Loaded");
        },
        onAdFailedToLoad: (error) {
          _isAppOpenAdLoaded = false;
          debugPrint("App Open Ad Failed to Load: ${error.message}");
        },
      ),
    );
  }

  /// Show App Open Ad (if loaded)
  static void showAppOpenAd({required Function onAdClosed}) {

    if (_isShowingAppOpenAd) {
      debugPrint('Tried to show ad while already showing an ad.');
      onAdClosed();
      return;
    }

    if (_isAppOpenAdLoaded && _appOpenAd != null) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          _isShowingAppOpenAd = true;
          debugPrint('$ad onAdShowedFullScreenContent');
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isAppOpenAdLoaded = false;
          _isShowingAppOpenAd = false;
          _appOpenAd = null;
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isAppOpenAdLoaded = false;
          _isShowingAppOpenAd = false;
          _appOpenAd = null;
          onAdClosed();
        },
      );
      _appOpenAd!.show();
    } else {
      onAdClosed();
    }
  }

  /// Load Interstitial Ad
  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
          debugPrint("Interstitial Ad Loaded");
        },
        onAdFailedToLoad: (error) {
          _isInterstitialAdLoaded = false;
          debugPrint("Interstitial Ad Failed to Load: ${error.message}");
        },
      ),
    );
  }

  /// Show Interstitial Ad (if loaded)
  static void showInterstitialAd({required Function onAdClosed}) {
    if (_isInterstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdImpression: (ad){
          debugPrint("Interstitial Ad Impression: ${ad.adUnitId}");
          debugPrint("Interstitial Ad Impression: ${ad.responseInfo.toString()}");
        },
        onAdClicked: (ad){
          debugPrint("Interstitial Ad Clicked: ${ad.adUnitId}");
          debugPrint("Interstitial Ad Clicked: ${ad.responseInfo.toString()}");
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isInterstitialAdLoaded = false;
          _interstitialAd = null;
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isInterstitialAdLoaded = false;
          _interstitialAd = null;
          onAdClosed();
        },
      );
      _interstitialAd!.show();
    } else {
      onAdClosed();
    }
  }
}
