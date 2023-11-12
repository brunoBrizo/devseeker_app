import 'package:flutter/material.dart';
import 'package:devseeker_app/views/common/exports.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReusableText(
            text: "Welcome",
            style: appStyle(18, Color(kDark.value), FontWeight.bold)),
      ),
    );
  }
}
