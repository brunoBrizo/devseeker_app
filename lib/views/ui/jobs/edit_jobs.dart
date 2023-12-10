import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/models/request/jobs/create_job.dart';
import 'package:devseeker_app/services/helpers/jobs_helper.dart';
import 'package:devseeker_app/views/common/back_btn.dart';
import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/custom_outline_btn.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/ui/auth/profile.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/hiring_switcher.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/textfield.dart';
import 'package:devseeker_app/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

class EditJobs extends StatefulWidget {
  const EditJobs({
    super.key,
  });

  @override
  State<EditJobs> createState() => _EditJobsState();
}

class _EditJobsState extends State<EditJobs> {
  TextEditingController title = TextEditingController(text: editable.title);
  TextEditingController location =
      TextEditingController(text: editable.location);
  TextEditingController company = TextEditingController(text: editable.company);
  TextEditingController salary = TextEditingController(text: editable.salary);
  TextEditingController contract =
      TextEditingController(text: editable.contract);
  TextEditingController description =
      TextEditingController(text: editable.description);
  TextEditingController imageUrl = TextEditingController();
  TextEditingController requirements1 =
      TextEditingController(text: editable.requirements[0]);
  TextEditingController requirements2 =
      TextEditingController(text: editable.requirements[1]);
  TextEditingController requirements3 =
      TextEditingController(text: editable.requirements[2]);
  TextEditingController requirements4 =
      TextEditingController(text: editable.requirements[3]);
  TextEditingController requirements5 =
      TextEditingController(text: editable.requirements[4]);

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
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              height: 100,
              decoration: BoxDecoration(
                  color: Color(kOrange.value),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                      text: "Job Uploads",
                      style: appStyle(14, Colors.white, FontWeight.w600)),
                  imageUrl.text.isNotEmpty && imageUrl.text.contains('https://')
                      ? Consumer<JobsNotifier>(
                          builder: (context, jobsNotifier, child) {
                            return CircularAvata(
                                w: 20, h: 20, image: jobsNotifier.logo);
                          },
                        )
                      : const SizedBox.shrink()
                ],
              ),
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
                  child: Consumer<JobsNotifier>(
                    builder: (context, jobsNotifier, child) {
                      return ListView(
                        children: [
                          const HeightSpacer(size: 10),
                          Buildtextfield(
                              label: const Text('Job Title'),
                              hintText: "Job Title",
                              controller: title,
                              onSubmitted: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill this field";
                                } else {
                                  return null;
                                }
                              }),
                          Buildtextfield(
                              label: const Text('Company'),
                              hintText: "Company",
                              controller: company,
                              onSubmitted: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill this field";
                                } else {
                                  return null;
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.8,
                                child: Consumer<JobsNotifier>(
                                  builder: (context, jobsNotifier, child) {
                                    return Buildtextfield(
                                        label: const Text('Logo Url'),
                                        hintText: "Logo Url",
                                        controller: imageUrl,
                                        onChanged: (value) => {
                                              jobsNotifier
                                                  .setLogo(imageUrl.text)
                                            },
                                        onSubmitted: (value) {
                                          if (value!.isEmpty &&
                                              imageUrl.text
                                                  .contains('https://')) {
                                            return "Please fill this field";
                                          } else {
                                            return null;
                                          }
                                        });
                                  },
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Consumer<JobsNotifier>(
                                    builder: (context, jobsNotifier, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (imageUrl.text
                                                  .contains('https://') &&
                                              imageUrl.text.isNotEmpty) {
                                            jobsNotifier.setLogo(imageUrl.text);
                                          }
                                        },
                                        child: Icon(
                                          Entypo.upload_to_cloud,
                                          size: 30,
                                          color: Color(kOrange.value),
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          ),
                          Buildtextfield(
                              label: const Text('Location'),
                              hintText: "Location",
                              controller: location,
                              onSubmitted: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill this field";
                                } else {
                                  return null;
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ReusableText(
                                text: "Salary Options",
                                style: appStyle(
                                    12, Colors.black, FontWeight.w600)),
                          ),
                          SizedBox(
                              height: 30,
                              child: Consumer<JobsNotifier>(
                                builder: (context, jobsNotifier, child) {
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: jobsNotifier.salaries.length,
                                    itemBuilder: (context, index) {
                                      var data = jobsNotifier.salaries[index];
                                      return ChoiceChip(
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        visualDensity: VisualDensity.standard,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        label: Text(
                                          data['title'],
                                          style: appStyle(10, Colors.black,
                                              FontWeight.w500),
                                        ),
                                        selected: data['isSelected'],
                                        selectedColor: Color(kOrange.value),
                                        onSelected: (newState) {
                                          jobsNotifier.toggleCheck(index);
                                          jobsNotifier.selectedSalary =
                                              data['title'];
                                        },
                                      );
                                    },
                                  );
                                },
                              )),
                          const HeightSpacer(size: 10),
                          const HiringSwitcher(text: "Hiring Status"),
                          Buildtextfield(
                              label: const Text('Salary Range'),
                              hintText: "Salary Range",
                              controller: salary,
                              onSubmitted: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill this field";
                                } else {
                                  return null;
                                }
                              }),
                          Buildtextfield(
                              label: const Text('Description'),
                              height: 100,
                              hintText: "Description",
                              maxLines: 3,
                              controller: description,
                              onSubmitted: (value) {
                                if (value!.isEmpty && value.length < 50) {
                                  return "Description should have more than 50 characters";
                                } else {
                                  return null;
                                }
                              }),
                          ReusableText(
                              text: "Requirements",
                              style:
                                  appStyle(14, Colors.black, FontWeight.w600)),
                          const HeightSpacer(size: 10),
                          Buildtextfield(
                              label: const Text('Option 1'),
                              height: 100,
                              hintText: "Requirements",
                              maxLines: 3,
                              controller: requirements1,
                              onSubmitted: (value) {
                                if (value!.isEmpty && value.length < 50) {
                                  return "Description should have more than 50 characters";
                                } else {
                                  return null;
                                }
                              }),
                          Buildtextfield(
                              height: 100,
                              label: const Text('Option 2'),
                              hintText: "Requirements",
                              maxLines: 3,
                              controller: requirements2,
                              onSubmitted: (value) {
                                if (value!.isEmpty && value.length < 50) {
                                  return "Description should have more than 50 characters";
                                } else {
                                  return null;
                                }
                              }),
                          Buildtextfield(
                              height: 100,
                              label: const Text('Option 3'),
                              hintText: "Requirements",
                              maxLines: 3,
                              controller: requirements3,
                              onSubmitted: (value) {
                                if (value!.isEmpty && value.length < 50) {
                                  return "Description should have more than 50 characters";
                                } else {
                                  return null;
                                }
                              }),
                          Buildtextfield(
                              height: 100,
                              label: const Text('Option 4'),
                              hintText: "Requirements",
                              maxLines: 3,
                              controller: requirements4,
                              onSubmitted: (value) {
                                if (value!.isEmpty && value.length < 50) {
                                  return "Description should have more than 50 characters";
                                } else {
                                  return null;
                                }
                              }),
                          Buildtextfield(
                              height: 100,
                              label: const Text('Option 5'),
                              hintText: "Requirements",
                              maxLines: 3,
                              controller: requirements5,
                              onSubmitted: (value) {
                                if (value!.isEmpty && value.length < 50) {
                                  return "Description should have more than 50 characters";
                                } else {
                                  return null;
                                }
                              }),
                          CustomOutlineBtn(
                            width: width,
                            height: 40,
                            onTap: () {
                              if (imageUrl.text.isEmpty) {
                                imageUrl.text = editable.imageUrl;
                              }
                              CreateJobsRequest model = CreateJobsRequest(
                                  title: title.text,
                                  location: location.text,
                                  company: company.text,
                                  hiring: jobsNotifier.isSwitched,
                                  description: description.text,
                                  salary: salary.text,
                                  period: jobsNotifier.selectedSalary,
                                  contract: contract.text,
                                  imageUrl: imageUrl.text,
                                  agentId: userUid,
                                  requirements: [
                                    requirements1.text,
                                    requirements2.text,
                                    requirements3.text,
                                    requirements4.text,
                                    requirements5.text
                                  ]);

                              var newModel = createJobsRequestToJson(model);

                              JobsHelper.updateJob(editable.id, newModel);
                              Get.to(() => const MainScreen());
                            },
                            color: Color(kOrange.value),
                            color2: Colors.white,
                            text: "Upload Job",
                          ),
                        ],
                      );
                    },
                  )))
        ],
      ),
    );
  }
}
