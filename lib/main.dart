import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paschaloliver/feature/auth/view/account_type_view.dart';
import 'package:paschaloliver/feature/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paschal Oliver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}



