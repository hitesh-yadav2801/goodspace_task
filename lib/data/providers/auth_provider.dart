import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:goodspace_task/core/constants/my_strings.dart';
import 'package:goodspace_task/core/constants/my_vars.dart';
import 'package:goodspace_task/core/routes.dart';
import 'package:goodspace_task/data/http_inactive_product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? errorMessage;
  String? authToken;

  //bool get isLoggedIn => authToken != null;
  bool get isLoading => _isLoading;

  Future<void> getOTP({required String number, required String countryCode}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://api.ourgoodspace.com/api/d2/auth/v2/login'),
        headers: {
          'device-id': '863999058647156',
          'device-type': 'android',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "number": number,
          "countryCode": countryCode,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful OTP request
        print('OTP sent successfully');
      } else {
        errorMessage = 'Failed to get OTP: ${response.reasonPhrase}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOTP({
    required String number,
    required String countryCode,
    required String otp,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://api.ourgoodspace.com/api/d2/auth/verifyotp'),
        headers: {
          'device-id': '863999058647156',
          'device-type': 'android',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "number": number,
          "countryCode": "+91",
          "otp": otp,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        authToken = responseData['data']['token'];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString(MyStrings.AUTH_TOKEN_KEY, authToken!);
        print("hello${prefs.getString(MyStrings.AUTH_TOKEN_KEY)}");
        MyVars.isLoggedIn = true;
        // Update your global authentication state here
        await HttpJobDetails.fetchJobDetails();
        Navigator.pushReplacementNamed(context, Routes.navigationMenu);
      } else {
        errorMessage = 'Verification failed: ${response.reasonPhrase}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
