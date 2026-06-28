import 'dart:async';

import 'package:electropi/shared/components.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 3));

    final onboardingDone = CacheHelper.getBool(key: 'onboarding_done') ?? false;

    final token = CacheHelper.getString(key: 'token');

    String route;

    if (!onboardingDone) {
      route = '/onboarding';
    } else if (token != null && token.isNotEmpty) {
      route = '/layout';
    } else {
      route = '/login';
    }

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;

    final height = size.height;

    return Scaffold(
      backgroundColor: primaryColor,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .08),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/images/Logo.png',

                  color: Colors.white,

                  width: width * .45,

                  height: width * .45,

                  fit: BoxFit.contain,
                ),

                SizedBox(height: height * .06),

                SizedBox(
                  width: width * .65,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: const LinearProgressIndicator(
                      minHeight: 8,

                      backgroundColor: Colors.white24,

                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: height * .025),

                Text(
                  "Loading...",

                  style: TextStyle(
                    color: Colors.white,

                    fontSize: width < 360 ? 16 : 18,

                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}