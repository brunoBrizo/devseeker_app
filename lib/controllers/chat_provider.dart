import 'package:flutter/material.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/services/firebase_services.dart';

class ChatNotifier extends ChangeNotifier {
  final FirebaseServices _services = FirebaseServices();

  bool _focused = false;

  bool get isFocused => _focused;

  set isFocused(bool newState) {
    if (_focused != newState) {
      _focused = newState;
      notifyListeners();
    }
  }

  onlineStatus(bool isLoggedIn, ZoomNotifier zoomNotifier) {
    if (isLoggedIn == true && zoomNotifier.currentIndex == 1) {
      _services.createStatus();
    }
  }

  offlineStatus(bool isLoggedIn, ZoomNotifier zoomNotifier) {
    if (isLoggedIn == false && zoomNotifier.currentIndex != 1 ||
        isLoggedIn == true && zoomNotifier.currentIndex != 1) {
      _services.offlineStatus();
    }
  }
}
