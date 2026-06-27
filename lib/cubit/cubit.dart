//Cubit page for managing the state of the app and fetching functions. It uses the Dio package for network requests and Fluttertoast for displaying messages.
import 'package:dio/dio.dart';
import 'package:electropi/models/projects_model.dart';
import 'package:electropi/modules/Project_Screen.dart';
import 'package:electropi/shared/components.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:electropi/cubit/states.dart';
// import 'package:electropi/modules/bookmarks/bookmarks_screen.dart';
import 'package:electropi/modules/profile_screen.dart';
// import 'package:electropi/modules/search/search_screen.dart';
import 'package:electropi/shared/network/dio_helper.dart';

// final String apiKey = dotenv.env['API_KEY'] ?? '';

class ProjectCubit extends Cubit<ProjectStates> {
  ProjectCubit() : super(ProjectInitialState());

  static ProjectCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // Bottom Navigation Bar Items and corresponding screens for the app's main navigation
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.explore_outlined),
    //   label: 'Explore',
    // ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.bookmark_outline),
    //   label: 'Bookmarks',
    // ),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];

  List<Widget> screen = [
    ProjectsScreen(),
    // SearchScreen(),
    // BookmarksScreen(),
    ProfileScreen(),
  ];

  // Function to change the current index of the bottom navigation bar and emit a state change
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ProjectBottomNavState());
  }

  Future login({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      // Local user
      String? savedEmail = CacheHelper.getString(key: 'email');

      String? savedPassword = CacheHelper.getString(key: 'password');

      if (savedEmail == email && savedPassword == password) {
        emit(LoginSuccessState());

        return;
      }

      // DummyJSON users
      Response userResponse = await DioHelper.getData(
        url: 'users/search?q=$email',
      );

      List users = userResponse.data['users'];

      if (users.isEmpty) {
        emit(LoginErrorState('Invalid credentials'));

        return;
      }

      String username = users[0]['username'];

      Response response = await DioHelper.postData(
        url: 'auth/login',
        data: {'username': username, 'password': password},
      );

      await CacheHelper.saveString(
        key: 'token',
        value: response.data['accessToken'],
      );

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    try {
      await CacheHelper.saveString(key: 'username', value: username);

      await CacheHelper.saveString(key: 'email', value: email);

      await CacheHelper.saveString(key: 'password', value: password);

      print('REGISTER SUCCESS');

      print(CacheHelper.getString(key: 'username'));

      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  Future updateProfile({
  required String username,
  required String email,
}) async {

  emit(UpdateProfileLoadingState());

  try {

    String? token =
        CacheHelper.getString(
      key: 'token',
    );

    // لو داخل من API
    if (token != null) {

      try {

        await DioHelper.putData(
          url: 'users/1',
          data: {
            "username": username,
            "email": email,
          },
        );

      } catch (_) {}

    }

    // حدث محلي عشان يظهر
    await CacheHelper.saveString(
      key: 'username',
      value: username,
    );

    await CacheHelper.saveString(
      key: 'email',
      value: email,
    );

    emit(UpdateProfileSuccessState());

  } catch (e) {

    emit(
      UpdateProfileErrorState(
        e.toString(),
      ),
    );
  }
}

  List<Widget> filteredProjects = [];
  void initProjects() {
    filteredProjects = List.from(projects);

    emit(SearchProjectSuccessState());
  }

  void searchProjects(String value) {
    emit(SearchProjectLoadingState());
    if (value.isEmpty) {
      filteredProjects = List.from(projects);
    } else {
      filteredProjects = projects.where((project) {
        return (project as ProjectCard).title.toLowerCase().contains(
          value.toLowerCase(),
        );
      }).toList();
    }

    emit(SearchProjectSuccessState());
  }
}
