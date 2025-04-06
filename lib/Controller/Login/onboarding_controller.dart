import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prediction/Utils/storage_service.dart';
import 'package:prediction/Utils/string_helper.dart';

import '../../UI/Login/authentication.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad,  // Smoother transition
      );

    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    debugPrint('completeOnboarding called');
    final storage = StorageService();
    storage.write(StringHelper.isFirstOpen, false);
    Get.offAll(()=>AuthScreen()); // Replace with your home screen route
  }
}