import 'package:flutter/material.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/common/reusable_text.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Color(kOrange.value),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(9), bottomLeft: Radius.circular(9))),
        child: ReusableText(
            text: "  Edit  ",
            style: appStyle(12, Color(kLight.value), FontWeight.w500)),
      ),
    );
  }
}
