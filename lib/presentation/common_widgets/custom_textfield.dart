import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneNumberField extends StatelessWidget {
  final String initialCountryCode;
  final String hintText;
  final TextEditingController controller;

  CustomPhoneNumberField({
    Key? key,
    required this.initialCountryCode,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  // Define a function to handle country changes
  void onCountryChanged(String newCountryCode, String? newCountryName) {
    print('Selected Country Code: $newCountryCode');
    // You can add additional logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: const TextStyle(color: MyColors.greyColor),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      //onCountryChanged: onCountryChanged, // Assign the callback function
      initialCountryCode: initialCountryCode,
      controller: controller,
    );
  }
}
