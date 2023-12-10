import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/ui/auth/profile.dart';

Widget chatRightItem(String type, String message, String profile) {
  return Stack(
    children: [
      Container(
        padding:
            EdgeInsets.only(top: 10.w, left: 15.w, right: 0.w, bottom: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.w),
                child: Container(
                    margin: EdgeInsets.only(right: 10.w, top: 0.w),
                    padding: EdgeInsets.only(
                      top: 10.w,
                      left: 10.w,
                      right: 10.w,
                    ),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3281E3),
                            Color.fromARGB(255, 131, 182, 245),
                          ],
                          transform: GradientRotation(120),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: type == "text"
                        ? Text(
                            message,
                            style:
                                appStyle(12, Colors.white, FontWeight.normal),
                          )
                        : ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 90.w,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // TODO: check this
                                // Get.toNamed(AppRoutes.Photoimgview,
                                //     parameters: {"url": item.content??""});
                              },
                              child: CachedNetworkImage(
                                imageUrl: message,
                              ),
                            ),
                          )))
          ],
        ),
      ),
      Positioned(right: 0, child: CircularAvata(w: 20, h: 20, image: profile)),
    ],
  );
}
