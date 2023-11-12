import 'package:devseeker_app/controllers/onboarding_provider.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:flutter/material.dart';
import 'package:devseeker_app/views/screens/onboarding/widget/page_one.dart';
import 'package:devseeker_app/views/screens/onboarding/widget/page_three.dart';
import 'package:devseeker_app/views/screens/onboarding/widget/page_two.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context, onBoardNotifier, child) {
          return Stack(
            children: [
              PageView(
                controller: pageController,
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                onPageChanged: (page) => onBoardNotifier.isLastPage = page == 2,
                children: const [PageOne(), PageTwo(), PageThree()],
              ),
              onBoardNotifier.isLastPage
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: height * 0.045,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: WormEffect(
                            dotColor: Color(kLight.value),
                            activeDotColor: Color(kOrange.value),
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 10,
                          ),
                        ),
                      ),
                    ),
              onBoardNotifier.isLastPage
                  ? const SizedBox.shrink()
                  : Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 30.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pageController.jumpToPage(2);
                                },
                                child: ReusableText(
                                  text: 'Skip',
                                  style: appStyle(16, Color(kLight.value),
                                      FontWeight.normal),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                },
                                child: ReusableText(
                                  text: 'Next',
                                  style: appStyle(16, Color(kLight.value),
                                      FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
