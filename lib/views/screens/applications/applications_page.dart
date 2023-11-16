import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          child: Padding(
            padding: EdgeInsets.all(10.0.h),
            child: DrawerWidget(
              color: Color(kDark.value),
            ),
          ),
        ),
      ),
      body: Center(
        child: ReusableText(
          text: 'Applications Page',
          style: appStyle(30, Color(kDark.value), FontWeight.bold),
        ),
      ),
    );
  }
}
