import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_strings.dart';
import 'package:goodspace_task/core/constants/my_vars.dart';
import 'package:goodspace_task/core/routes.dart';
import 'package:goodspace_task/data/http_inactive_product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpServiceAuth {
  static const String baseUrl = 'https://api.ourgoodspace.com/api/d2/auth/v2';

  static Future<http.Response> getOTP({required String number, required String countryCode}) async {
    try {
      Map<String, String> headers = {
        'device-id': '863999058647156',
        'device-type': 'android',
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> body = {
        "number": number,
        "countryCode": '+91',
      };

      var request = http.Request(
          'POST', Uri.parse('https://api.ourgoodspace.com/api/d2/auth/v2/login'));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      final http.StreamedResponse streamedResponse = await request.send();

      // Convert StreamedResponse to Response
      final http.Response response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Success');
        // print(await response.stream.bytesToString());
      } else {
        print('Failed');
        print(response.reasonPhrase);
      }

      return response;
    } catch (e) {
      print('Caught error: $e');
      return http.Response('Error occurred: $e', 500); // Return an error response
    }
  }



  static Future<http.Response> verifyOTP({required String number, required String countryCode, required String otp, required BuildContext context,}) async {
    Map<String, String> headers = {
      'device-id': '863999058647156',
      'device-type': 'android',
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> body = {
      "number": number,
      "countryCode": "+91",
      "otp": otp,
      // "utmTracking": null,
      // "inviteId": null,
    };
    // print(jsonEncode(body));

    try {
      http.Response response = await http.post(
        Uri.parse('https://api.ourgoodspace.com/api/d2/auth/verifyotp'), // Update the API endpoint
        headers: headers,
        body: jsonEncode(body),
      );
      // print(response.statusCode);
      // print(response.reasonPhrase);
      // print(response.headers);
      // print(response.body);
      // print(response);
      // print(jsonDecode(response.body));

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String authToken = responseData['data']['token'];

        print(authToken);

        // Store the auth token in shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(MyStrings.AUTH_TOKEN_KEY, authToken);
        MyVars.isLoggedIn = true;
        await HttpJobDetails.fetchJobDetails();
        Navigator.pushReplacementNamed(context, Routes.navigationMenu);
        //print(response.body);
      } else {

        print('Verification Failed');
        print(response.reasonPhrase);
      }
      return response;
    } catch (e) {
      print('Caught error: $e');
      return http.Response('Error occurred: $e', 500); // Return an error response
    }
  }



}
