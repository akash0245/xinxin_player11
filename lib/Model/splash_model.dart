class SplashDataResponse {
  final bool success;
  final int statusCode;
  final String message;
  final SplashData data;

  SplashDataResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SplashDataResponse.fromJson(Map<String, dynamic> json) {
    return SplashDataResponse(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: SplashData.fromJson(json['data']),
    );
  }
}

class SplashData {
  final int userId;
  final int? userType;
  final int? loginUserId;
  final bool? isCouponCodeAvailable;
  final String? couponCode;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileUrl;
  final String? openAdId;
  final String? interstitialAdId;
  final String? nativeAdId;

  SplashData({
    required this.userId,
    this.userType,
    this.loginUserId,
    this.isCouponCodeAvailable,
    this.couponCode,
    this.email,
    this.firstName,
    this.lastName,
    this.profileUrl,
    this.openAdId,
    this.interstitialAdId,
    this.nativeAdId,
  });

  factory SplashData.fromJson(Map<String, dynamic> json) {
    return SplashData(
      userId: json['userId'],
      userType: json['userType'] ?? 1,
      loginUserId: json['loginUserId'] ?? 0,
      isCouponCodeAvailable: json['isCouponCodeAvailable'] ?? false,
      couponCode: json['couponCode'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      openAdId: json['openAdId'] ?? 'ca-app-pub-3940256099942544/9257395921',
      interstitialAdId: json['interstitialAdId'] ?? 'ca-app-pub-3940256099942544/1033173712',
      nativeAdId: json['nativeAdId'] ?? '',
    );
  }
}