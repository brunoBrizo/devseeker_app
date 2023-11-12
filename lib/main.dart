import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/controllers/image_provider.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/controllers/onboarding_provider.dart';
import 'package:devseeker_app/controllers/profile_provider.dart';
import 'package:devseeker_app/controllers/signup_provider.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/views/screens/mainscreen.dart';
import 'package:devseeker_app/views/screens/onboarding/onboarding_screen.dart';

Widget defaultHome = const OnboardingScreen();

///TODO: Hook the app to firebase using firebase cli
void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ChangeNotifierProvider(create: (context) => ImageUploader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dbestech JobHub',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kLight.value),
            iconTheme: IconThemeData(color: Color(kDark.value)),
            primarySwatch: Colors.grey,
          ),
          home: defaultHome,
        );
      },
    );
  }
}
