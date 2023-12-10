import 'package:flutter/material.dart';

class AddSkillNotifier extends ChangeNotifier {
  bool _addSkill = false;

  bool get addSkill => _addSkill;

  set addSkill(bool newIndex) {
    _addSkill = newIndex;
    notifyListeners();
  }

  String _addSkillId = '';

  String get addSkillId => _addSkillId;

  void setSkill(String newSkill) {
    _addSkillId = newSkill;
    notifyListeners();
  }
}
