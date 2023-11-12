import 'package:flutter/material.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/views/screens/onboarding/widget/page_one.dart';
import 'package:devseeker_app/views/screens/onboarding/widget/page_three.dart';
import 'package:devseeker_app/views/screens/onboarding/widget/page_two.dart';

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
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [PageOne(), PageTwo(), PageThree()],
          ),
          const Positioned(child: Center()),
          const Positioned(child: Center())
        ],
      ),
    );
  }
}
