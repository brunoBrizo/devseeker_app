// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/chat_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/heading_widget.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/common/search.dart';
import 'package:devseeker_app/views/common/vertical_shimmer.dart';
import 'package:devseeker_app/views/common/vertical_tile.dart';
import 'package:devseeker_app/views/ui/auth/profile.dart';
import 'package:devseeker_app/views/ui/chat/chat_list.dart';
import 'package:devseeker_app/views/ui/chat/chat_page.dart';
import 'package:devseeker_app/views/ui/home/widgets/popular_jobs.dart';
import 'package:devseeker_app/views/ui/home/widgets/recent_jobs.dart';
import 'package:devseeker_app/views/ui/jobs/job_page.dart';
import 'package:devseeker_app/views/ui/jobs/jobs_list.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:devseeker_app/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    loginNotifier.getPrefs();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12.h),
              child: GestureDetector(
                  onTap: () {
                    Get.to(() => const ProfilePage(
                          drawer: false,
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      width: 25.w,
                      height: 25.h,
                      fit: BoxFit.cover,
                      imageUrl:
                          "https://d326fntlu7tb1e.cloudfront.net/uploads/bdec9d7d-0544-4fc4-823d-3b898f6dbbbf-vinci_03.jpeg",
                    ),
                  )),
            )
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search \nFind & Apply",
                  style: appStyle(38, Color(kDark.value), FontWeight.bold),
                ),
                const HeightSpacer(size: 30),
                SearchWidget(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                ),
                const HeightSpacer(size: 25),
                HeadingWidget(
                  text: "Popular Jobs",
                  onTap: () {
                    Get.to(() => const JobListPage());
                  },
                ),
                const HeightSpacer(size: 15),
                const PopularJobs(),
                const HeightSpacer(size: 15),
                HeadingWidget(
                  text: "Recently Posted",
                  onTap: () {
                    Get.to(() => const JobListPage());
                  },
                ),
                const HeightSpacer(size: 15),
                const RecentJobs(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
