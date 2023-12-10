import 'package:flutter/material.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/ui/applicatons/widgets/applied_jobs.dart';
import 'package:devseeker_app/views/ui/auth/non_user.dart';
import 'package:provider/provider.dart';

class AppliedJobsPage extends StatelessWidget {
  const AppliedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool loggedIn = Provider.of<LoginNotifier>(context).loggedIn;
    return Scaffold(
        backgroundColor: const Color(0xFF3281E3),
        appBar: AppBar(
          backgroundColor: const Color(0xFF3281E3),
          elevation: 0,
          title: ReusableText(
              text: !loggedIn ? "" : "Applied Jobs",
              style: appStyle(16, Colors.white, FontWeight.w600)),
          leading: const Padding(
            padding: EdgeInsets.all(12.0),
            child: DrawerWidget(color: Colors.white),
          ),
        ),
        body: loggedIn == false
            ? const NonUser()
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color(0xFFEFFFFC),
                        ),
                        child: const AppliedJob()),
                  ),
                ],
              ));
  }
}
