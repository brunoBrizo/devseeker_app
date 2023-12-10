import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/controllers/agents_provider.dart';
import 'package:devseeker_app/controllers/chat_provider.dart';
import 'package:devseeker_app/controllers/image_provider.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/controllers/onboarding_provider.dart';
import 'package:devseeker_app/controllers/profile_provider.dart';
import 'package:devseeker_app/controllers/signup_provider.dart';
import 'package:devseeker_app/controllers/skills_provider.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/firebase_options.dart';
import 'package:devseeker_app/views/ui/mainscreen.dart';
import 'package:devseeker_app/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget defaultHome = const OnBoardingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final entrypoint = prefs.getBool('entrypoint') ?? false;

  if (entrypoint == true) {
    defaultHome = const MainScreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => AgentsNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => ChatNotifier()),
    ChangeNotifierProvider(
        create: (context) => JobsNotifier(salaries: salaries)),
    ChangeNotifierProvider(create: (context) => ImageUpoader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
    ChangeNotifierProvider(create: (context) => AddSkillNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
          title: 'DevSeeker',
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
