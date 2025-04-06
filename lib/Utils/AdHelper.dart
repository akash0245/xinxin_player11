import 'dart:io';

import '../UI/splash_screen.dart';
import 'string_helper.dart';


class AdHelper {

  static String get interstitial1AdUnitId {
    if (Platform.isAndroid) {
      return adsController.interstitial1AdUnit == null ? StringHelper.interstitialAdId: adsController.interstitial1AdUnit.toString();
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return adsController.nativeBannerAdUnit == null ? StringHelper.nativeAdId : adsController.nativeBannerAdUnit.toString();
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw new UnsupportedError("Unsupported platform");
  }
}