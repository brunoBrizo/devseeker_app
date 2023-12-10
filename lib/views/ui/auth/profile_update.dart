import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/image_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/models/request/auth/profile_update_model.dart';
import 'package:devseeker_app/views/common/back_btn.dart';
import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/custom_btn.dart';
import 'package:devseeker_app/views/common/custom_textfield.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({
    super.key,
  });

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(text: "Update Profile", child: BackBtn()),
      ),
      body: Consumer<LoginNotifier>(
        builder: (context, loginNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                      text: "Personal Details",
                      style: appStyle(25, Color(kDark.value), FontWeight.bold)),
                  Consumer<ImageUpoader>(
                    builder: (context, imageUploader, child) {
                      return imageUploader.imageFil.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                imageUploader.pickImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(kLightBlue.value),
                                // backgroundImage: ,
                                child: const Center(
                                  child: Icon(Icons.photo_filter_rounded),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                imageUploader.imageFil.clear();
                                setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(kLightBlue.value),
                                backgroundImage:
                                    FileImage(File(imageUploader.imageFil[0])),
                              ),
                            );
                    },
                  )
                ],
              ),
              const HeightSpacer(size: 20),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: location,
                    hintText: "Location",
                    keyboardType: TextInputType.text,
                    validator: (location) {
                      if (location!.isEmpty) {
                        return "Please enter a valid location";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: phone,
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone!.isEmpty) {
                        return "Please enter a valid phone";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  ReusableText(
                      text: "Professional Skills",
                      style: appStyle(30, Color(kDark.value), FontWeight.bold)),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill0,
                    hintText: "Proffessional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill0) {
                      if (skill0!.isEmpty) {
                        return "Please enter a valid phone";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill1,
                    hintText: "Proffessional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill1) {
                      if (skill1!.isEmpty) {
                        return "Please enter a valid phone";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill2,
                    hintText: "Proffessional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill2) {
                      if (skill2!.isEmpty) {
                        return "Please enter a valid phone";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill3,
                    hintText: "Proffessional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill3) {
                      if (skill3!.isEmpty) {
                        return "Please enter a valid phone";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill4,
                    hintText: "Proffessional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill4) {
                      if (skill4!.isEmpty) {
                        return "Please enter a valid phone";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  Consumer<ImageUpoader>(
                    builder: (context, imageUploada, child) {
                      return CustomButton(
                          onTap: () {
                            if (imageUploada.imageFil.isEmpty &&
                                imageUploada.imageUrl == null) {
                              Get.snackbar("Image Missing",
                                  "Please upload an image to proceed",
                                  colorText: Color(kLight.value),
                                  backgroundColor: Color(kLightBlue.value),
                                  icon: const Icon(Icons.add_alert));
                            } else {
                              ProfileUpdateReq model = ProfileUpdateReq(
                                  location: location.text,
                                  phone: phone.text,
                                  profile: imageUploada.imageUrl.toString(),
                                  skills: [
                                    skill0.text,
                                    skill1.text,
                                    skill2.text,
                                    skill3.text,
                                    skill4.text,
                                  ]);

                              loginNotifier.updateProfile(model);
                            }
                          },
                          text: "Update Profile");
                    },
                  )
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}
