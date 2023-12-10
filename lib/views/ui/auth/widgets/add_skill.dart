import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/textfield.dart';

class AddSkills extends StatefulWidget {
  const AddSkills({super.key, this.onTap, required this.skill});

  final void Function()? onTap;
  final TextEditingController skill;
  @override
  State<AddSkills> createState() => _AddSkillsState();
}

class _AddSkillsState extends State<AddSkills> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Buildtextfield(
          hintText: "Add Skill",
          controller: widget.skill,
          suffixIcon: GestureDetector(
            onTap: widget.onTap,
            child: Icon(
              Entypo.upload_to_cloud,
              size: 30,
              color: Color(kOrange.value),
            ),
          ),
          onSubmitted: (value) {
            if (value!.isEmpty) {
              return "Please fill this field";
            } else {
              return null;
            }
          }),
    );
  }
}
