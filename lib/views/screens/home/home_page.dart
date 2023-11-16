import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/heading_widget.dart';
import 'package:devseeker_app/views/common/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/views/screens/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const ProfilePage(drawer: false));
                  },
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 25.h,
                        width: 25.w,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ],
            child: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: DrawerWidget(
                color: Color(kDark.value),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search \n Find & Apply',
                    style: appStyle(38, Color(kDark.value), FontWeight.bold),
                  ),
                  SizedBox(height: 20.h),
                  SearchWidget(
                    onTap: () {},
                  ),
                  SizedBox(height: 25.h),
                  const HeadingWidget(text: "Popular Jobs"),
                  SizedBox(height: 25.h),
                  const HeadingWidget(text: "Recently Posted"),
                ],
              ),
            ),
          ),
        ));
  }
}
