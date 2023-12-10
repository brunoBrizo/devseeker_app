import 'package:http/http.dart' as https;
import 'package:devseeker_app/models/response/jobs/get_job.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsHelper {
  static var client = https.Client();
// TODO handle errors
  static Future<bool> createJob(String model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is null (e.g., request a new token or logout).
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, Config.jobs);
      var response = await client.post(
        url,
        body: model,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle different error scenarios here.
        return false;
      }
    } catch (e) {
      // Handle exceptions here (e.g., network issues, unexpected errors).
      return false;
    }
  }

  static Future<bool> updateJob(String jobId, String model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is null (e.g., request a new token or logout).
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobId");
      var response = await client.put(
        url,
        body: model,
        headers: requestHeaders,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        // Handle different error scenarios here.
        return false;
      }
    } catch (e) {
      // Handle exceptions here (e.g., network issues, unexpected errors).
      return false;
    }
  }

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }

// get job
  static Future<GetJobRes> getJob(String jobId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobId");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);

      return job;
    } else {
      throw Exception("Failed to get a job");
    }
  }

  static Future<JobsResponse> getRecent() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);

      var recent = jobsList.first;
      return recent;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }

//SEARCH
  static Future<List<JobsResponse>> searchJobs(String searchQeury) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.search}/$searchQeury");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }
}
