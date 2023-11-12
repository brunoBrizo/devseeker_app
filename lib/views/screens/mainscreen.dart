import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/views/common/drawer/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:devseeker_app/views/common/exports.dart';
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
            mainScreen: currentScreen(context));
      },
    ));
  }

  Widget currentScreen(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      // case 0:
      //   return const HomeScreen();
      // case 1:
      //   return const ProfileScreen();
      // case 2:
      //   return const SettingsScreen();
      // default:
      //   return const HomeScreen();
    }

    return Container();
  }
}
