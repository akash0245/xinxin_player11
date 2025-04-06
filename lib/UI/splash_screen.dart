import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/ads_controller.dart';
import '../Controller/splash_controller.dart';
import '../Utils/string_helper.dart';
import 'Dashboard/dashboard.dart';

AdsController adsController = Get.put(AdsController());

class SplashScreen extends StatelessWidget {
  final SplashController _controller = Get.put(SplashController());

  // SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  '${StringHelper.svgImgPath}/splash_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset('${StringHelper.svgImgPath}/logo.png'),
                ),
              ),
              _controller.isError.value
                  ? Positioned(
                    bottom: 40, // Adjust this value for proper positioning
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Button color
                          foregroundColor: Colors.black, // Text color
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          _controller.fetchSplashData();
                        },
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                  : SizedBox(),
            ],
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.off(() => DashBoard());
          });
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
