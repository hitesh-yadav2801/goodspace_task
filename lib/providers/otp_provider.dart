import 'package:flutter/material.dart';

class OTPProvider extends ChangeNotifier {
  Color borderColor1 = Colors.grey; // Initial color
  Color borderColor2 = Colors.grey;
  Color borderColor3 = Colors.grey;
  Color borderColor4 = Colors.grey;

  void setBorderColor(int index, Color color) {
    switch (index) {
      case 1:
        borderColor1 = color;
        break;
      case 2:
        borderColor2 = color;
        break;
      case 3:
        borderColor3 = color;
        break;
      case 4:
        borderColor4 = color;
        break;
    }
    notifyListeners();
  }
}
