import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/views/common/exports.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboard,
    this.suffixIcon,
    this.obscureText,
    this.onEditingComplete,
    this.search,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onEditingComplete;
  final void Function()? search;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(bottom: 5),
      height: 45,
      color: Color(kLightGrey.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Ionicons.chevron_back_circle,
              color: Color(kOrange.value),
              size: 30.h,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: width * 0.73,
            child: TextField(
                keyboardType: keyboard,
                obscureText: obscureText ?? false,
                onEditingComplete: onEditingComplete,
                decoration: InputDecoration(
                    hintText: hintText,
                    suffixIcon: suffixIcon,
                    isDense: true,
                    suffixIconColor: Color(kLight.value),
                    hintStyle:
                        appStyle(14, Color(kDarkGrey.value), FontWeight.w400),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.red, width: 0.5),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey, width: 0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    border: InputBorder.none),
                controller: controller,
                cursorHeight: 20,
                style: appStyle(14, Color(kDark.value), FontWeight.w500),
                onSubmitted: validator),
          ),
          GestureDetector(
            onTap: onEditingComplete,
            child: Icon(
              Ionicons.search_circle,
              color: Color(kOrange.value),
              size: 35.h,
            ),
          )
        ],
      ),
    );
  }
}
