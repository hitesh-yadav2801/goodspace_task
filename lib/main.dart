import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:goodspace_task/core/routes.dart';
import 'package:goodspace_task/presentation/screens/home_screen.dart';
import 'package:goodspace_task/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        // Other providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   // final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoodSpace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.lightBlue),
        useMaterial3: true,
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
      home: const SplashScreen(),
    );
  }
}
