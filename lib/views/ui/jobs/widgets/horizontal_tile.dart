import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/common/width_spacer.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, this.onTap, required this.job});

  final void Function()? onTap;
  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: width * 0.7,
            height: hieght * 0.27,
            decoration: BoxDecoration(
                color: Color(kLightGrey.value),
                image: const DecorationImage(
                    image: AssetImage('assets/images/jobs.png'),
                    fit: BoxFit.contain,
                    opacity: 0.35)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(job.imageUrl),
                    ),
                    const WidthSpacer(width: 15),
                    Container(
                      width: 160,
                      padding: EdgeInsets.only(left: 20, right: 20.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: ReusableText(
                          text: job.company,
                          style: appStyle(
                              22, Color(kDark.value), FontWeight.w600)),
                    ),
                  ],
                ),
                const HeightSpacer(size: 15),
                ReusableText(
                    text: job.title,
                    style: appStyle(20, Color(kDark.value), FontWeight.w600)),
                ReusableText(
                    text: job.location,
                    style:
                        appStyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                const HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ReusableText(
                            text: job.salary,
                            style: appStyle(
                                20, Color(kDark.value), FontWeight.w600)),
                        ReusableText(
                            text: "/${job.period}",
                            style: appStyle(
                                18, Color(kDarkGrey.value), FontWeight.w600)),
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kLight.value),
                      child: const Icon(Ionicons.chevron_forward),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
