import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:goodspace_task/data/http_auth.dart';
import 'package:provider/provider.dart';

import '../common_widgets/otp_textfield.dart';
import '../common_widgets/primary_button.dart';

class OTPScreen extends StatefulWidget {
  late final String phoneNumber;


  String otpCode = "";// Pass the phone number from the previous screen

  OTPScreen({required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {


  final textEditingController1 = TextEditingController();
  final textEditingController2 = TextEditingController();
  final textEditingController3 = TextEditingController();
  final textEditingController4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              const Text(
                'Edit Phone Number',
                style: TextStyle(
                  color: MyColors.greyColor,
                  fontSize: 17
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: MyColors.greyColor,
                ),
                onPressed: () {
                  // Add functionality to edit phone number
                },
              ),
            ],
          )

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'OTP sent to +91',
                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: ' ${widget.phoneNumber}',
                      style: const TextStyle(fontSize: 18, color: MyColors.primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter OTP to confirm your phone',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Text(
                'You’ll receive a four digit verification code.',
                style: TextStyle(fontSize: 14, color: MyColors.greyColor),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OTPTextField(
                      controller: textEditingController1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } else if(value.isEmpty){
                          FocusScope.of(context).previousFocus();
                        }
                  }),
                  OTPTextField(
                      controller: textEditingController2,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } else if(value.isEmpty){
                          FocusScope.of(context).previousFocus();
                        }
                  }),
                  OTPTextField(
                      controller: textEditingController3,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } else if(value.isEmpty){
                          FocusScope.of(context).previousFocus();
                        }
                  }),
                  OTPTextField(
                      controller: textEditingController4,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } else if(value.isEmpty){
                          FocusScope.of(context).previousFocus();
                        }
                  }),
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  text: 'Didn\'t receive OTP?',
                  style: TextStyle(fontSize: 14, color: MyColors.greyColor),
                  children: [
                    TextSpan(
                      text: ' Resend',
                      style: TextStyle(fontSize: 14, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              // Elevated Button
              const SizedBox(height: 48.0),
              PrimaryButton(
                  title: 'Verify Phone',
                  onPressed: () {
                    String otp = "${textEditingController1.text}${textEditingController2.text}${textEditingController3.text}${textEditingController4.text}";
                    print(otp);
                    HttpServiceAuth.verifyOTP(number: widget.phoneNumber, otp: otp, countryCode: "+91", context: context);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

}
