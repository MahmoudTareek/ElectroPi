import 'package:bloc_test/bloc_test.dart';
import 'package:electropi/cubit/cubit.dart';
import 'package:electropi/cubit/states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login Cubit Test', () {

    late ProjectCubit cubit;

    setUp(() {
      cubit = ProjectCubit();
    });

    tearDown(() {
      cubit.close();
    });

    blocTest<ProjectCubit, ProjectStates>(
      'emit LoginLoading → LoginError if credentials empty',

      build: () => cubit,

      act: (cubit) async {
        await cubit.login(
          email: '',
          password: '',
        );
      },

      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>(),
      ],
    );
  });
}