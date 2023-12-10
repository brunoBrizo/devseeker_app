import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/ui/jobs/popular_jobs_list.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            text: "Jobs",
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(AntDesign.leftcircleo),
            )),
      ),
      body: const PopularJobList(),
    );
  }
}
