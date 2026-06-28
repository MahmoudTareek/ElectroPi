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

    final bool onboardingDone =
        CacheHelper.getBool(key: 'onboarding_done') ?? false;

    final String? token = CacheHelper.getString(key: 'token');

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
    return Scaffold(
      backgroundColor: primaryColor,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              /// IMAGE
              Image.asset(
                'assets/images/Logo.png',

                color: Colors.white,

                width: 180,

                height: 180,

                fit: BoxFit.contain,
              ),
              const SizedBox(height: 50),

              /// LOADING
              ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: const LinearProgressIndicator(
                  minHeight: 8,

                  backgroundColor: Colors.white24,

                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Loading...",

                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
