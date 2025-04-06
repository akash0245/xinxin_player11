
import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prediction/UI/Login/onboarding_screen.dart';
import 'package:prediction/UI/Dashboard/dashboard.dart';
import 'package:prediction/Utils/string_helper.dart';
import 'package:prediction/Utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../Model/splash_model.dart';
import '../Utils/storage_service.dart';
import '../main.dart';

class SplashController extends GetxController {
  final _storage = StorageService();
  SplashData? splashData;

  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  var fcmToken = '';
  AppOpenAd? appOpenAd;

  var deviceId = '';
  var deviceType = '';
  var brand = '';
  var model = '';
  var device = '';
  var manufacturer = '';
  var osVersion = '';
  var appVersionName = '';
  var appVersionCode = '';
  var utmReferrer = '';
  String storedDeviceId = '';
  int userId = 0;
  late bool isFirstOpen;
  late bool isSplashAdShow;


  @override
  void onInit() {
    super.onInit();
    debugPrint("Splash is called----------------");
    initialLoad();
  }

  initialLoad() async{
    await _initDeviceInfo();
    await _fetchPackageInfo();
    await _initNotifications();
    fetchSplashData();
  }

  Future<void> _initDeviceInfo() async {

    userId = _storage.read(StringHelper.userId, defaultValue: 0);
    storedDeviceId = _storage.read(StringHelper.deviceId, defaultValue: '');
    isFirstOpen = _storage.read(StringHelper.isFirstOpen, defaultValue: true);
    isSplashAdShow = _storage.read(StringHelper.isSplashAdShow, defaultValue: false);

    debugPrint('userId: $userId');
    debugPrint('storedDeviceId: $storedDeviceId');
    debugPrint('isFirstOpen: $isFirstOpen');
    debugPrint('isSplashAdShow: $isSplashAdShow');

    if(!isFirstOpen && isSplashAdShow && !Utils.isPremiumUser()){
      //Load OpenAdd
      loadOpenAd();
    }

    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceType = "android";
        brand = androidInfo.brand;
        model = androidInfo.model;
        deviceId = storedDeviceId.isNotEmpty ? storedDeviceId: androidInfo.id;
        device = androidInfo.device;
        manufacturer = androidInfo.manufacturer;
        osVersion = 'Android ${androidInfo.version.release}';
        debugPrint('Android sdkInt: ${androidInfo.version.sdkInt}');
      }
      else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceType = "apple";
        brand = iosInfo.name;
        model = iosInfo.model;
        deviceId = storedDeviceId.isNotEmpty ? storedDeviceId: iosInfo.identifierForVendor ?? Uuid().v4();
        device = iosInfo.name;
        manufacturer = 'Apple';
        osVersion = 'iOS ${iosInfo.systemVersion}';
      }
    } catch (e) {
      debugPrint('_initDeviceInfo error: ${e.toString()}');
      errorMessage.value = 'Failed to get device info: $e';
    }
  }

  Future<void> _fetchPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersionName = packageInfo.version;
      appVersionCode = packageInfo.buildNumber;
    } catch (e) {
      debugPrint('_fetchPackageInfo error: ${e.toString()}');
      errorMessage.value = 'Failed to get package info: $e';
    }
  }

  Future<void> _initNotifications() async {

    // Request Notification Permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Notification permission granted");
    } else {
      debugPrint("Notification permission denied");
    }

    // Get FCM Token

    var token = await _firebaseMessaging.getToken();

    if (token != null) {
      fcmToken = token;
      debugPrint("FCM Token: $token");
    }

    // Handle Foreground Notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // notificationMessage.value = message.notification?.title ?? "New Notification";
      Get.snackbar("Notification", message.notification?.title ?? 'Notification Title');
    });

    // Handle Background & Terminated Messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // notificationMessage.value = message.notification?.title ?? "Notification Clicked!";
      Get.snackbar("Opened Notification", message.notification?.title ?? 'Notification Clicked');
    });


    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      final InitializationSettings initializationSettings =
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      );

      // Request permissions
      if (Platform.isIOS) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    } catch (e) {
      debugPrint('_initNotifications error: ${e.toString()}');
      errorMessage.value = 'Failed to initialize notifications: $e';
    }
  }

  void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    // Handle notification tap
    debugPrint('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
  }

  void loadOpenAd() {
    debugPrint('loadOpenAd called on splash: ${_storage.read(StringHelper.openAdId)}');

    AppOpenAd.load(
      adUnitId: _storage.read(StringHelper.openAdId),
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded');
          appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (appOpenAd != null) {
      appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          isLoading(false);
          ad.dispose();
          appOpenAd = null;
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
          isLoading(false);
          ad.dispose();
          appOpenAd = null;
        },
        onAdShowedFullScreenContent: (ad) {
          debugPrint('$ad onAdShowedFullScreenContent.');
        },
        onAdImpression: (ad){
          debugPrint('$ad onAdImpression');
        },
        onAdClicked: (ad){
          debugPrint('$ad onAdClicked');
        },
        onAdWillDismissFullScreenContent: (ad){
          debugPrint('$ad onAdWillDismissFullScreenContent');
        },
      );
      appOpenAd!.show();
    } else{
      Get.offAll(()=>DashBoard());
    }
  }

  Future<void> fetchSplashData() async {
    try {
      isLoading(true);
      errorMessage('');

      await apiCall(
          endPoint: 'splash_data',
          body: {
            "userId": userId.toString(),
            "fcmToken": fcmToken,
            "deviceId": deviceId,
            "eDeviceType": deviceType,
            "brand": brand,
            "model": model,
            "device": device,
            "manufacturer": manufacturer,
            "osVersion": osVersion,
            "appVersionName": appVersionName,
            "utmReferrer": utmReferrer
          },
          header: ApiUrl.reqHeader,
          apiType: ApiType.POST,
          isMultiRequest: false,
          onSuccess: (data, status, statusCode) {
            debugPrint('after api call status: $status statusCode: $statusCode');

            if (status) {

              final splashResponse = SplashDataResponse.fromJson(data);

              splashData = splashResponse.data;
              _storage.write(StringHelper.userId, userId != 0 ? userId : splashData!.userId);
              _storage.write(StringHelper.userType, splashData!.userType);
              _storage.write(StringHelper.loginUserId, splashData!.loginUserId);
              _storage.write(StringHelper.firstName, splashData!.firstName);
              _storage.write(StringHelper.email, splashData!.email);
              _storage.write(StringHelper.lastName, splashData!.lastName);
              _storage.write(StringHelper.profileUrl, splashData!.profileUrl);
              _storage.write(StringHelper.deviceId, deviceId);

              _storage.write(StringHelper.openAdId, splashData!.openAdId);
              _storage.write(StringHelper.interstitialAdId, splashData!.interstitialAdId);
              _storage.write(StringHelper.nativeAdId, splashData!.nativeAdId);

              if(isFirstOpen){
                _storage.write(StringHelper.isSplashAdShow, !isSplashAdShow);
                Get.offAll(()=>OnboardingScreen());
              } else if (isSplashAdShow){
                _storage.write(StringHelper.isSplashAdShow, !isSplashAdShow);
                showAdIfAvailable();
              } else{
                _storage.write(StringHelper.isSplashAdShow, true);
                Get.offAll(()=>DashBoard());
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
      // isLoading(false);
    }
  }

  @override
  void onClose() {
    appOpenAd?.dispose();
    super.onClose();
  }
}
