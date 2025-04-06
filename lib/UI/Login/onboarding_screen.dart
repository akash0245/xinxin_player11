import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Controller/Login/onboarding_controller.dart';
import '../../Model/onboarding_model.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      title: "Predict. Compete. Win!",
      description: "Guess match outcomes, challenge friends, and earn rewards!",
      image: "assets/images/stadium-cricket.png", // Replace with your image
    ),
    OnboardingModel(
      title: "How It Works",
      description: "Predict winners, top scorers, or match stats. Earn points!",
      image: "assets/images/stadium-cricket.png",
    ),
    OnboardingModel(
      title: "Win Prizes & Stay Updated!",
      description: "Top predictors get rewards. Enable notifications!",
      image: "assets/images/stadium-cricket.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for Onboarding Slides
          PageView.builder(
            controller: controller.pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) => controller.currentPage.value = index,
            itemBuilder: (context, index) {
              return SingleOnboardingPage(
                model: onboardingData[index],
              );
            },
          ),

          // Skip Button (Top-Right)
          Positioned(
            top: 50,
            right: 20,
            child: Obx(
                  () => AnimatedOpacity(
                    opacity: controller.currentPage.value != 2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: TextButton(
                      onPressed: controller.skipOnboarding,
                      child: const Text(
                        "SKIP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
            ),
          ),

          // Dot Indicators (Bottom-Center)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: onboardingData.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.green,
                  dotColor: Colors.white54,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,  // Makes active dot wider
                ),
              ),
            ),
          ),

          // Next Button (Bottom-Right)
          Positioned(
            bottom: 40,
            right: 20,
            child: Obx(
                  () => GestureDetector(
                    onTap: controller.nextPage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: controller.currentPage.value == 2 ? 150 : 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: controller.currentPage.value == 2
                            ? const Text(
                          "GET STARTED",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleOnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const SingleOnboardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(model.image, height: 300),

        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            model.image,
            fit: BoxFit.cover,  // Ensures image covers full screen
          ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                model.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),

        if (model.title == "Predict. Compete. Win!")
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/animations/cricket_ball.json',
              width: 200,
              height: 200,
            ),
          ),
      ],
    );
  }
}