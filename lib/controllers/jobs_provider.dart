import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:devseeker_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:devseeker_app/models/response/jobs/get_job.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/services/helpers/book_helper.dart';
import 'package:devseeker_app/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recent;
  late Future<GetJobRes> job;
  Future<List<AllBookMarks>>? bookmarks;
  String selectedSalary = '';
  String logo = '';
  List<dynamic> _salaries;

  JobsNotifier({
    List<dynamic>? salaries,
  }) : _salaries = salaries!;

  List<dynamic> get salaries => _salaries;

  set salaries(List<dynamic> newSalaries) {
    _salaries = newSalaries;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _salaries.length; i++) {
      if (i == index) {
        _salaries[i]['isSelected'] = true;
      } else {
        _salaries[i]['isSelected'] = false;
      }
    }
    notifyListeners();
  }

  void category(String newSalary) {
    selectedSalary = newSalary;
    notifyListeners();
  }

  void setLogo(String newLogo) {
    logo = newLogo;
    notifyListeners();
  }

  getJobs() {
    jobList = JobsHelper.getJobs();
  }

  getRecent() {
    recent = JobsHelper.getRecent();
  }

  String _bookmarkId = '';

  String get bookMarkId => _bookmarkId;

  set setBookmark(String newBookmark) {
    _bookmarkId = newBookmark;
    if (_bookmarkId != newBookmark) {
      _bookmarkId = newBookmark;
      notifyListeners();
    }
  }

  bool _bookmark = false;

  bool get isBookmark => _bookmark;

  set isBookmark(bool newBookmark) {
    if (_bookmark != newBookmark) {
      _bookmark = newBookmark;
      notifyListeners();
    }
  }

  getBookmark(String jobId) {
    BookMarkHelper.getBookmark(jobId).then((response) {
      if (response == null) {
        isBookmark = false;
      } else {
        isBookmark = response.status;
        setBookmark = response.bookmarkId;
      }
    });
  }

  addBookMark(BookmarkReqResModel model) {
    BookMarkHelper.addBookmarks(model).then((response) {});
  }

  deleteBookMark(String bookmark) {
    BookMarkHelper.deleteBookmarks(bookmark).then((response) {
      if (response) {
        Get.snackbar(
            "Bookmark successfully deleted", "Please check your bookmarks",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.bookmark_remove_outlined));
      }
    });
  }

  getBookMarks() {
    bookmarks = BookMarkHelper.getBookmarks();
  }

  bool _switcher = false;

  bool get isSwitched => _switcher;

  set isSwitched(bool newState) {
    if (_switcher != newState) {
      _switcher = newState;
      notifyListeners();
    }
  }
}
