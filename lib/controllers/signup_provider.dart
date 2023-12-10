import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/services/helpers/auth_helper.dart';
import 'package:devseeker_app/views/ui/auth/login.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool _loader = false;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool get loader => _loader;

  set setLoader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = signupFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  upSignup(String model) {
    AuthHelper.signup(model).then(
      (response) {
        if (response) {
          setLoader = false;
          Get.offAll(() => const LoginPage(),
              transition: Transition.fade,
              duration: const Duration(seconds: 2));
        } else {
          setLoader = false;
          Get.snackbar("Sign up Failed", "Please Check your credentials",
              colorText: Color(kLight.value),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.add_alert));
        }
      },
    );
  }
}
