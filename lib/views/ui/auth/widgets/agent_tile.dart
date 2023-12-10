import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/models/response/agent/get_agent.dart';
import 'package:devseeker_app/services/helpers/agents_helper.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/common/reusable_text.dart';
import 'package:devseeker_app/views/ui/agent/edit_agent_info.dart';
import 'package:devseeker_app/views/ui/auth/widgets/edit_button.dart';

class AgentTile extends StatelessWidget {
  const AgentTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Color(kLightGrey.value),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Company",
                            style: appStyle(10, Colors.black, FontWeight.w600),
                          ),
                          ReusableText(
                            text: 'Address',
                            style: appStyle(10, Colors.black, FontWeight.w600),
                          ),
                          ReusableText(
                            text: 'Working hours',
                            style: appStyle(10, Colors.black, FontWeight.w600),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 60,
                          width: 1,
                          color: Colors.amberAccent,
                        ),
                      ),
                      FutureBuilder<GetAgent>(
                          future: AngenciesHelper.getAgencyInfo(userUid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox.shrink();
                            } else if (snapshot.hasError) {
                              return Text("Error ${snapshot.error}");
                            }
                            var agent = snapshot.data;
                            agentInfo = agent;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: agent!.company,
                                  style: appStyle(
                                      10, Colors.black, FontWeight.normal),
                                ),
                                ReusableText(
                                  text: agent.hqAddress,
                                  style: appStyle(
                                      10, Colors.black, FontWeight.normal),
                                ),
                                ReusableText(
                                  text: agent.workingHrs,
                                  style: appStyle(
                                      10, Colors.black, FontWeight.normal),
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            )),
        Positioned(
            right: 0.w,
            child: EditButton(
              onTap: () {
                Get.to(() => const EditAgency());
              },
            ))
      ],
    );
  }
}
