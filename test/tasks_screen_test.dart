import 'package:electropi/models/tasks_model.dart';
import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TaskCard renders correctly', (tester) async {
    final task = TaskModel(
      title: 'Build UI',
      priority: 'High',
      status: 'Pending',
      selected: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskCard(task: task, onTap: () {}),
        ),
      ),
    );

    expect(find.text('Build UI'), findsOneWidget);

    expect(find.text('High'), findsOneWidget);

    expect(find.text('Pending'), findsOneWidget);
  });

  testWidgets('Tap task works', (tester) async {
    bool pressed = false;

    final task = TaskModel(
      title: 'Task',
      priority: 'Low',
      status: 'Done',
      selected: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskCard(
            task: task,
            onTap: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector).first);

    expect(pressed, true);
  });
}