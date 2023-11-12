import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:devseeker_app/models/request/auth/login_model.dart';
import 'package:devseeker_app/models/request/auth/profile_update_model.dart';
import 'package:devseeker_app/models/request/auth/signup_model.dart';
import 'package:devseeker_app/models/response/auth/login_res_model.dart';
import 'package:devseeker_app/models/response/auth/profile_model.dart';
import 'package:devseeker_app/services/config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();
}
