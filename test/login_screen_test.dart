import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});

    await CacheHelper.init();
  });

  Widget createWidget() {
    return BlocProvider(
      create: (_) => ProjectCubit(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  testWidgets(
    'Login screen renders correctly',
    (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Hello'), findsOneWidget);

      expect(find.text('Again!'), findsOneWidget);

      expect(find.text('Login'), findsOneWidget);
    },
  );

  testWidgets(
    'typing email and password',
    (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'test@mail.com',
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Password123',
      );

      expect(find.text('test@mail.com'), findsOneWidget);

      expect(find.text('Password123'), findsOneWidget);
    },
  );
}