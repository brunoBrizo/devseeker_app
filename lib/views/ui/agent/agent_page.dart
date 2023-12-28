import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/agents_provider.dart';
import 'package:devseeker_app/models/response/agent/get_agent.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/common/reusable_text.dart';
import 'package:devseeker_app/views/ui/agent/widgets/uploaded_jobs.dart';
import 'package:devseeker_app/views/ui/auth/profile.dart';
import 'package:provider/provider.dart';

class AgentDetails extends StatelessWidget {
  const AgentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF171717),
        appBar: AppBar(
          backgroundColor: const Color(0xFF171717),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                AntDesign.leftcircleo,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 5, left: 25, right: 0),
                height: 140,
                decoration: const BoxDecoration(
                    color: Color(0xFF3281E3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Consumer<AgentsNotifier>(
                      builder: (context, agentsNotifier, child) {
                        var agent = agentsNotifier.agent;
                        var agencyInfo =
                            agentsNotifier.getAgencyInfo(agent.uid);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: "Company",
                                        style: appStyle(10, Colors.white54,
                                            FontWeight.w600),
                                      ),
                                      ReusableText(
                                        text: 'Address',
                                        style: appStyle(10, Colors.white54,
                                            FontWeight.normal),
                                      ),
                                      ReusableText(
                                        text: 'Working hours',
                                        style: appStyle(10, Colors.white54,
                                            FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      height: 60,
                                      width: 1,
                                      color: Colors.amberAccent,
                                    ),
                                  ),
                                  FutureBuilder<GetAgent>(
                                      future: agencyInfo,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox.shrink();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              "Error ${snapshot.error}");
                                        }
                                        var agent = snapshot.data;
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: agent!.company,
                                              style: appStyle(
                                                10,
                                                Colors.white,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            ReusableText(
                                              text: agent.hqAddress,
                                              style: appStyle(10, Colors.white,
                                                  FontWeight.normal),
                                            ),
                                            ReusableText(
                                              text: agent.workingHrs,
                                              style: appStyle(10, Colors.white,
                                                  FontWeight.normal),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CircularAvata(w: 40, h: 40, image: agent.profile),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 85,
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
                  child: const UploadedJobs()),
            ),
          ],
        ));
  }
}
