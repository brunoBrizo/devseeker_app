import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:devseeker_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:devseeker_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:devseeker_app/models/response/bookmarks/bookmark.dart';
import 'package:devseeker_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();
}
