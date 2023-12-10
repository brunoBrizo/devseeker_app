import 'package:flutter/material.dart';
import 'package:devseeker_app/models/response/auth/profile_model.dart';
import 'package:devseeker_app/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileRes> getProfile() async {
    var profile = AuthHelper.getProfile();

    return profile;
  }
}
