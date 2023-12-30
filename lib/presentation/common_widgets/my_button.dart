import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key, required this.title, required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          minimumSize: const Size(0, 36),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          )),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
