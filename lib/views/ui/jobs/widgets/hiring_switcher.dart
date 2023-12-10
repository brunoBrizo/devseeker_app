import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:provider/provider.dart';

class HiringSwitcher extends StatelessWidget {
  const HiringSwitcher({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                  text: text,
                  style: appStyle(13, Colors.black, FontWeight.w600)),
              CupertinoSwitch(
                value: jobsNotifier.isSwitched,
                onChanged: (value) {
                  jobsNotifier.isSwitched = value;
                },
                thumbColor: Color(kDarkGrey.value),
                activeColor: Color(kOrange.value),
              )
            ],
          ),
        );
      },
    );
  }
}
