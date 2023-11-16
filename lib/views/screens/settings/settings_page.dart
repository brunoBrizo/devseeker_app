import 'package:devseeker_app/views/common/exports.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReusableText(
          text: 'Settings Page',
          style: appStyle(30, Color(kDark.value), FontWeight.bold),
        ),
      ),
    );
  }
}
