import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/modules/OnBoarding_Screen.dart';
import 'package:electropi/modules/Splash_Screen.dart';
import 'package:electropi/shared/network/dio_helper.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  DioHelper.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCubit(),

      child: const MaterialApp(
        debugShowCheckedModeBanner: false,

        home: SplashScreen(),
        // home: OnBoardingScreen(),
      ),
    );
  }
}