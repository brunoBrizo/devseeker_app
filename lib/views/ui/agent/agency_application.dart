import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/models/request/agents/create_agent.dart';
import 'package:devseeker_app/services/helpers/agents_helper.dart';
import 'package:devseeker_app/views/common/back_btn.dart';
import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/custom_outline_btn.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/textfield.dart';
import 'package:devseeker_app/views/ui/mainscreen.dart';

class AgencyApplication extends StatefulWidget {
  const AgencyApplication({super.key});

  @override
  State<AgencyApplication> createState() => _AgencyApplicationState();
}

class _AgencyApplicationState extends State<AgencyApplication> {
  TextEditingController company = TextEditingController();
  TextEditingController hqAddress = TextEditingController();
  TextEditingController workingHrs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(text: "", child: BackBtn()),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              height: 100,
              decoration: BoxDecoration(
                  color: Color(kOrange.value),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: ReusableText(
                  text: "Agent Application",
                  style: appStyle(16, Colors.white, FontWeight.w600)),
            ),
          ),
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color(0xFFFBFBFB),
                ),
                child: ListView(
                  children: [
                    const HeightSpacer(size: 10),
                    Buildtextfield(
                        hintText: "Company Name",
                        controller: company,
                        onSubmitted: (value) {
                          if (value!.isEmpty) {
                            return "Please fill this field";
                          } else {
                            return null;
                          }
                        }),
                    Buildtextfield(
                        hintText: "HQ Address",
                        controller: hqAddress,
                        onSubmitted: (value) {
                          if (value!.isEmpty) {
                            return "Please fill this field";
                          } else {
                            return null;
                          }
                        }),
                    Buildtextfield(
                        hintText: "Working Hours",
                        controller: workingHrs,
                        onSubmitted: (value) {
                          if (value!.isEmpty) {
                            return "Please fill this field";
                          } else {
                            return null;
                          }
                        }),
                    const HeightSpacer(size: 20),
                    CustomOutlineBtn(
                      width: width,
                      height: 40,
                      onTap: () {
                        CreateAgent model = CreateAgent(
                            uid: userUid,
                            company: company.text,
                            hqAddress: hqAddress.text,
                            workingHrs: workingHrs.text);

                        var newModel = createAgentToJson(model);

                        AngenciesHelper.createAgent(newModel);
                        Get.to(() => const MainScreen());
                      },
                      color: Color(kOrange.value),
                      color2: Colors.white,
                      text: "Submit Application",
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
