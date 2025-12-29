import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paschaloliver/feature/splash/onbordaing_view.dart';
import '../../../app_ground.dart';
import '../../core/constants/assets.dart';
import '../../core/network/api_service/token_meneger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuth();
  }

  Future<void> _navigateBasedOnAuth() async {
    await Future.delayed(const Duration(seconds: 5));
    await Future.delayed(const Duration(milliseconds: 200));
    bool loggedIn = await TokenManager.isLoggedIn();

    if (!mounted) return;
    if (loggedIn) {
      Get.to(() => AppGround());
    } else {
      Get.offAll(() => OnboardingScreen());
    }

    if (loggedIn) {
      Get.offAll(() => AppGround()); // must be offAll
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(Images.appLogo,height: 188,width: 160,),),
    );
  }
}
