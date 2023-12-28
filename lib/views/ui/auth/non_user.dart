import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/common/custom_outline_btn.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/common/reusable_text.dart';
import 'package:devseeker_app/views/common/styled_container.dart';
import 'package:devseeker_app/views/ui/auth/login.dart';

class NonUser extends StatelessWidget {
  const NonUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return buildStyleContainer(
      context,
      Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(99)),
            child: Image.asset(
              'assets/images/devSeeker.png',
              width: 200.w,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
          const HeightSpacer(
            size: 20,
          ),
          ReusableText(
              text: 'To access the content of this page proceed to login',
              style: appStyle(12, Color(kDarkGrey.value), FontWeight.normal)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: CustomOutlineBtn(
              width: width,
              height: 40,
              color: Color(kOrange.value),
              onTap: () {
                Get.offAll(() => const LoginPage());
              },
              text: "Proceed to Login",
            ),
          )
        ],
      ),
    );
  }
}
