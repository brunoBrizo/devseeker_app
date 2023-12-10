import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/views/common/custom_outline_btn.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            const HeightSpacer(size: 20),
            ReusableText(
                text: "Welcome To DevSeeker",
                style: appStyle(30, Color(kLight.value), FontWeight.w600)),
            const HeightSpacer(size: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "We help you find your dream job to your skillset, location and preference to build your career",
                textAlign: TextAlign.center,
                style: appStyle(14, Color(kLight.value), FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomOutlineBtn(
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('entrypoint', true);

                      Get.to(() => const MainScreen());
                    },
                    text: "Continue as guest",
                    width: width * 0.9,
                    height: hieght * 0.06,
                    color: Color(kLight.value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
