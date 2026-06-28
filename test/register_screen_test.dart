import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/modules/Registration_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidget() {
    return BlocProvider(
      create: (_) => ProjectCubit(),
      child: MaterialApp(home: RegisterScreen()),
    );
  }

  testWidgets('Register screen renders', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text('Create'), findsOneWidget);

    expect(find.text('Account'), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(3));
  });

  testWidgets('Register validation works', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Register').last);

    await tester.pump();

    expect(find.text('Enter your name'), findsOneWidget);

    expect(find.text('Email is required'), findsOneWidget);
  });
}