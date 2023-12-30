import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:goodspace_task/core/constants/my_strings.dart';
import 'package:goodspace_task/core/constants/my_vars.dart';
import 'package:goodspace_task/core/navigation_menu.dart';
import 'package:goodspace_task/core/routes.dart';
import 'package:goodspace_task/presentation/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    whereToGo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(
        child: FadedScaleAnimation(
          fadeDuration: const Duration(milliseconds: 2000),
          scaleDuration: const Duration(milliseconds: 1000),
          child: Image.asset(
            "assets/images/main_logo.png",
            height: 200,
            width: 200,
          ),
        ),
      ),

    );
  }

  void whereToGo() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    var authToken = sharedPrefs.getString(MyStrings.AUTH_TOKEN_KEY);

    if (authToken != null && authToken.isNotEmpty) {
      // User is logged in
      MyVars.isLoggedIn = true;
      await Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, Routes.navigationMenu);
      });
    } else {
      // User is not logged in
      MyVars.isLoggedIn = false;
      await Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }


// void whereToGo() async {
  //   var sharedPrefs = await SharedPreferences.getInstance();
  //   sharedPrefs.get(MyStrings.AUTH_TOKEN_KEY);
  //   if(MyVars.isLoggedIn){
  //     await Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     });
  //   } else {
  //     await Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //     });
  //   }
  //
  // }
}
