import 'package:http/http.dart' as https;
import 'package:devseeker_app/models/request/agents/agents.dart';
import 'package:devseeker_app/models/response/agent/get_agent.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AngenciesHelper {
  static var client = https.Client();

  static Future<List<Agents>> getsAgents() async {
    var url = Uri.https(Config.apiUrl, Config.getAgents);
    var response = await client.get(
      url,
    );

    if (response.statusCode == 200) {
      var agents = agentsFromJson(response.body);
      return agents;
    } else {
      throw Exception('Failed to load agents');
    }
  }

  static Future<List<JobsResponse>> getJobs(String agentId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.job}/agent/$agentId");
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

  static Future<bool> createAgent(model) async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

      var url = Uri.https(Config.apiUrl, Config.getAgents);
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: model,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // TODO: Handle different error scenarios here, log errors, etc.
        return false;
      }
    } catch (e) {
      // Handle exceptions here (e.g., network issues, unexpected errors).
      return false;
    }
  }

  static Future<bool> updateAgentInfo(String model) async {
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

      var url = Uri.https(Config.apiUrl, Config.getAgents);
      var response = await client.put(
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

  static Future<GetAgent> getAgencyInfo(String uid) async {
    final Uri url = Uri.https(Config.apiUrl, "${Config.getAgents}/$uid");

    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      final response = await https.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        final job = getAgentFromJson(response.body);
        return job;
      } else {
        throw Exception("Failed to get agent");
      }
    } catch (error) {
      throw Exception("Failed to get agent: $error");
    }
  }
}
