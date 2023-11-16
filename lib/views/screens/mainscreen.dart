import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/screens/applications/applications_page.dart';
import 'package:devseeker_app/views/screens/bookmarks/bookmarks_page.dart';
import 'package:devseeker_app/views/common/drawer/drawer_screen.dart';
import 'package:devseeker_app/views/screens/chat/chat_list_page.dart';
import 'package:devseeker_app/views/screens/home/home_page.dart';
import 'package:devseeker_app/views/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
            menuScreen: DrawerScreen(indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            }),
            borderRadius: 30,
            menuBackgroundColor: Color(kLightBlue.value),
            angle: 0,
            slideWidth: 230,
            mainScreen: currentScreen());
      },
    ));
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatListPage();
      case 2:
        return const BookmarksPage();
      case 3:
        return const ApplicationsPage();
      case 4:
        return const ProfilePage(
          drawer: true,
        );
      default:
        return const HomePage();
    }
  }
}
