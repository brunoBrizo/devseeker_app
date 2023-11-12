import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/models/request/auth/login_model.dart';
import 'package:devseeker_app/models/request/auth/profile_update_model.dart';
import 'package:devseeker_app/services/helpers/auth_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {}
