import 'package:bloc_test/bloc_test.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});

    await CacheHelper.init();
  });

  group('ProjectCubit Tests', () {
    late ProjectCubit cubit;

    setUp(() {
      cubit = ProjectCubit();
    });

    tearDown(() {
      cubit.close();
    });

    blocTest<ProjectCubit, ProjectStates>(
      'changeBottomNavBar',
      build: () => cubit,
      act: (cubit) {
        cubit.changeBottomNavBar(1);
      },
      expect: () => [isA<ProjectBottomNavState>()],
    );

    blocTest<ProjectCubit, ProjectStates>(
      'changeTheme',
      build: () => cubit,
      act: (cubit) {
        cubit.changeTheme();
      },
      expect: () => [isA<ChangeThemeState>()],
    );

    blocTest<ProjectCubit, ProjectStates>(
      'addTask',
      build: () => cubit,
      act: (cubit) {
        cubit.addTask(title: 'Task', priority: 'High', status: 'Pending');
      },
      expect: () => [isA<UpdateTaskState>()],
    );
  });
}