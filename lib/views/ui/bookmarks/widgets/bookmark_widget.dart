import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/width_spacer.dart';
import 'package:devseeker_app/views/ui/jobs/job_page.dart';

class BookMarkTileWidget extends StatelessWidget {
  const BookMarkTileWidget({super.key, required this.job});
  final AllBookMarks job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobPage(
                title: job.job.company,
                id: job.job.id,
                agentName: job.job.agentName,
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: hieght * 0.1,
          width: width,
          decoration: BoxDecoration(
              color: Color(kLightGrey.value),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
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
                        radius: 25,
                        backgroundImage: NetworkImage(job.job.imageUrl),
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: job.job.company,
                              style: appStyle(
                                  12, Color(kDark.value), FontWeight.w500)),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                                text: job.job.title,
                                style: appStyle(12, Color(kDarkGrey.value),
                                    FontWeight.normal)),
                          ),
                          ReusableText(
                              text: "${job.job.salary}  ${job.job.period}",
                              style: appStyle(
                                  12, Color(kDarkGrey.value), FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(kOrange.value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
