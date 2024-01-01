import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:goodspace_task/core/routes.dart';
import 'package:goodspace_task/presentation/common_widgets/custom_textfield.dart';
import 'package:goodspace_task/presentation/common_widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../data/providers/auth_provider.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var phoneController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rich text "Find Work Opportunity"
              RichText(
                text: const TextSpan(
                  text: 'FIND ',
                  style: TextStyle(
                    color: MyColors.greyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'WORK ',
                      style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'OPPORTUNITIES',
                      style: TextStyle(
                        color: MyColors.greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),

              // Image
              const SizedBox(height: 16.0),
              Image.asset(
                'assets/images/login_image.png',
                width: screenWidth,
                height: 260
              ),

              // Text "Please enter your phone number to sign in GoodSpace account"
              const SizedBox(height: 60.0),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please enter your phone number to sign in ',
                      style: TextStyle(fontSize: 16.0, color: MyColors.greyColor, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'GoodSpace',
                      style: TextStyle(fontSize: 16.0, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' account.',
                      style: TextStyle(fontSize: 16.0, color: MyColors.greyColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),


              // Text field with Indian flag icon
              const SizedBox(height: 16.0),

              CustomPhoneNumberField(initialCountryCode: 'IN', hintText: 'Please enter mobile no.', controller: phoneController),


              // Text "You will receive a 4 digit OTP"
              const SizedBox(height: 16.0),
              RichText(
                text: const TextSpan(
                  text: 'You will receive a ',
                  style: TextStyle(fontSize: 16.0, color: MyColors.greyColor),
                  children: [
                    TextSpan(
                      text: '4 digit OTP',
                      style: TextStyle(fontSize: 16.0, color: MyColors.primaryColor),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Elevated Button
              const SizedBox(height: 48.0),
              PrimaryButton(
                title: 'Get OTP',
                onPressed: () async {
                  try {
                    await authProvider.getOTP(
                      number: phoneController.text,
                      countryCode: '+91',
                    );
                    Navigator.pushReplacementNamed(context, Routes.otp, arguments: {'phoneNumber': phoneController.text});
                  } catch (error) {
                    // Display error message to the user
                    print(error); // For debugging
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error sending OTP: $error')),
                    );
                  }
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}

