import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/width_spacer.dart';
import 'package:devseeker_app/views/ui/jobs/job_page.dart';

class VerticalTileWidget extends StatelessWidget {
  const VerticalTileWidget({super.key, required this.job});
  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: GestureDetector(
          onTap: () {
            Get.to(() => JobPage(
                  title: job.company,
                  id: job.id,
                  agentName: job.agentName,
                ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            height: hieght * 0.13,
            width: width,
            decoration: BoxDecoration(
                color: Color(kLightGrey.value),
                borderRadius: const BorderRadius.all(Radius.circular(9))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),
                        const WidthSpacer(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: job.company,
                                style: appStyle(
                                    16, Color(kDark.value), FontWeight.w600)),
                            SizedBox(
                              width: width * 0.6,
                              child: ReusableText(
                                  text: job.title,
                                  style: appStyle(16, Color(kDarkGrey.value),
                                      FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      child: Icon(
                        Ionicons.chevron_forward,
                        color: Color(kOrange.value),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 65.w),
                  child: Row(
                    children: [
                      ReusableText(
                          text: job.salary,
                          style: appStyle(
                              16, Color(kDark.value), FontWeight.w600)),
                      ReusableText(
                          text: "/${job.period}",
                          style: appStyle(
                              16, Color(kDarkGrey.value), FontWeight.w600)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
