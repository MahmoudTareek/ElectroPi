import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/layout/layout.dart';
import 'package:electropi/models/projects_model.dart';
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/modules/OnBoarding_Screen.dart';
import 'package:electropi/modules/Profile_Screen.dart';
import 'package:electropi/modules/Project_Details_Screen.dart';
import 'package:electropi/modules/Project_Screen.dart';
import 'package:electropi/modules/Registration_Screen.dart';
import 'package:electropi/modules/Splash_Screen.dart';
import 'package:electropi/shared/network/dio_helper.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:electropi/shared/page_transition.dart';
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
      create: (_) => ProjectCubit()..getProjects(),
      child: BlocBuilder<ProjectCubit, ProjectStates>(
        builder: (context, state) {
          var cubit = ProjectCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,

              scaffoldBackgroundColor: Colors.white,

              cardColor: Colors.white,

              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black),
              ),
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,

              scaffoldBackgroundColor: const Color(0xff121212),

              cardColor: const Color(0xff1E1E1E),

              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
              ),

              inputDecorationTheme: InputDecorationTheme(
                filled: true,

                fillColor: Color(0xff1E1E1E),
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/login':
                  return AppPageRoute(child: const LoginScreen());

                case '/register':
                  return AppPageRoute(child: const RegisterScreen());

                case '/layout':
                  return AppPageRoute(child: ProjectLayout());

                case '/project':
                  return AppPageRoute(child: ProjectsScreen());

                default:
                  return AppPageRoute(child: const LoginScreen());
              }
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
