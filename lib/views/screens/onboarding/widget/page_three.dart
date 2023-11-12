import 'package:devseeker_app/views/common/custom_outline_btn.dart';
import 'package:devseeker_app/views/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:get/get.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: width,
          height: height,
          color: Color(kLightBlue.value),
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.7,
                  child: Image.asset('assets/images/page3.png')),
              const SizedBox(
                height: 10,
              ),
              ReusableText(
                text: 'Welcome to DevSeeker',
                style: appStyle(28, Color(kLight.value), FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomOutlineBtn(
                  text: 'Continue as guest',
                  color: Color(kLight.value),
                  height: height * 0.05,
                  width: width * 0.9,
                  onTap: () {
                    Get.to(() => const Mainscreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
