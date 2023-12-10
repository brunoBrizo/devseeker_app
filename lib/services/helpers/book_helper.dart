import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:devseeker_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:devseeker_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:devseeker_app/models/response/bookmarks/bookmark.dart';
import 'package:devseeker_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();

  static Future<BookMark> addBookmarks(BookmarkReqResModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      var bookmark = bookMarkFromJson(response.body);
      return bookmark;
    } else {
      throw Exception('Failed to add bookmarks');
    }
  }

  static Future<bool> deleteBookmarks(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}/$jobId");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<AllBookMarks>> getBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var bookmarks = allBookMarksFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }

// TODO: handle errors
  static Future<BookMark?> getBookmark(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is null (e.g., request a new token or logout).
        return null;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "${Config.singleBookmarkUrl}$jobId");
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var bookmark = bookMarkFromJson(response.body);
        return bookmark;
      } else {
        // Handle different error scenarios here (e.g., log errors).
        return null;
      }
    } catch (e) {
      // Handle exceptions here (e.g., network issues, unexpected errors).
      return null;
    }
  }
}
