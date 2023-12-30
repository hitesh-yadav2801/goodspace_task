import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const OTPTextField({Key? key, required this.onChanged, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          counter: const Offstage(), // Hide the character count
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
