import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/ui/pages/on_boarding.dart';
import 'package:client/utils/secure_storage.dart';
import 'package:client/ui/pages/login.dart';
import 'package:client/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () async {
      String? showIntro = await SecureStorage().storage.read(key: "show_intro");
      String? autoLogin = await SecureStorage().storage.read(key: "auto_login");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (showIntro == "1"
              ? const TDLSOnBoardingPage()
              : autoLogin == "1"
                  ? const TDLSHomePage()
                  : const TDLSLoginPage()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _controller.value,
              child: Image.asset('assets/images/splash.png',
                  width: 40.w, height: 80.h),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
