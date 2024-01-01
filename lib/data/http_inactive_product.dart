import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:goodspace_task/core/constants/my_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/models.dart'; // Import your models here

class HttpJobDetails {
  static Future<List<Data>?> fetchJobDetails() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    try {
      String? authToken = sharedPrefs.getString(MyStrings.AUTH_TOKEN_KEY);

      print(authToken);
      print(authToken);

      // Check if authToken is not null
      if (authToken != null) {
        var headers = {
          'Authorization': authToken,
        };

        http.Response response = await http.get(
          Uri.parse(
              'https://api.ourgoodspace.com/api/d2/member/dashboard/feed?limit=10&page=0'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);

          JobModel jobModel = JobModel.fromJson(jsonResponse);

          // Now you can access jobModel.data to get the list of job details
          List<Data>? jobDetails = jobModel.data;

          // Successful response, return the list of job details
          return jobDetails;
        } else {
          // Handle error
          print('Request failed with status: ${response.statusCode}');
          print('Reason: ${response.reasonPhrase}');
          return null;
        }
      } else {
        // Handle case where authToken is null
        print('Auth token is null');
        return null;
      }
    } catch (e) {
      // Handle general exceptions
      print('Error occurred: $e');
      return null;
    }
  }
}
