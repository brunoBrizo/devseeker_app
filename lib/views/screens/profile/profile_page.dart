import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/back_btn.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.drawer});
  final bool drawer;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          child: Padding(
            padding: EdgeInsets.all(10.0.h),
            child: widget.drawer == false
                ? const BackBtn()
                : DrawerWidget(
                    color: Color(kDark.value),
                  ),
          ),
        ),
      ),
      body: Center(
        child: ReusableText(
          text: 'Profile Page',
          style: appStyle(30, Color(kDark.value), FontWeight.bold),
        ),
      ),
    );
  }
}
