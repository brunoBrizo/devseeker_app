import 'package:flutter/material.dart';

class OnBoardNotifier extends ChangeNotifier {
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  set isLastPage(bool newState) {
    _isLastPage = newState;
    notifyListeners();
  }
}
