import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/layout/layout.dart';
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/modules/OnBoarding_Screen.dart';
import 'package:electropi/modules/Profile_Screen.dart';
import 'package:electropi/modules/Project_Details_Screen.dart';
import 'package:electropi/modules/Registration_Screen.dart';
import 'package:electropi/modules/Splash_Screen.dart';
import 'package:electropi/shared/network/dio_helper.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCubit(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashRoute',

        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/layout': (context) => ProjectLayout(),
          '/onboarding': (context) => OnBoardingScreen(),
          '/profile': (context) => ProfileScreen(),
          '/projectDetails': (context) {
            final title = ModalRoute.of(context)!.settings.arguments as String?;
            return ProjectDetailsScreen(projectTitle: title);
          },
        },

        home: const SplashScreen(),
        // home: OnBoardingScreen(),
      ),
    );
  }
}
