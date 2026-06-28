import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/modules/Project_Screen.dart';
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
        home: const ProjectsScreen(),
      ),
    );
  }

  testWidgets(
    'Projects screen renders correctly',
    (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('My Projects'), findsOneWidget);

      expect(
        find.text('Here are your projects'),
        findsOneWidget,
      );

      expect(find.byType(TextField), findsOneWidget);
    },
  );

  testWidgets(
    'Search field accepts typing',
    (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(
        find.byType(TextField),
        'phone',
      );

      expect(find.text('phone'), findsOneWidget);
    },
  );

  testWidgets(
    'Theme button exists',
    (tester) async {
      await tester.pumpWidget(createWidget());

      expect(
        find.byIcon(Icons.dark_mode),
        findsOneWidget,
      );
    },
  );
}