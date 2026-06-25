import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/layout/layout.dart';
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/modules/OnBoarding_Screen.dart';
import 'package:electropi/shared/network/dio_helper.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  DioHelper.init();

  String? token = CacheHelper.getString(key: 'token');
  print(
'TOKEN FOUND => $token',
);

  runApp(MyApp(startWidget: token != null ? NewsLayout() : LoginScreen()));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCubit(),

      child: MaterialApp(debugShowCheckedModeBanner: false, home: startWidget),
    );
  }
}
