//Cubit page for managing the state of the app and fetching functions. It uses the Dio package for network requests and Fluttertoast for displaying messages.
import 'package:dio/dio.dart';
import 'package:electropi/modules/Project_Screen.dart';
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
      // 1- هات اليوزر من الإيميل
      Response userResponse = await DioHelper.getData(
        url: 'users/search?q=$email',
      );

      List users = userResponse.data['users'];

      if (users.isEmpty) {
        emit(LoginErrorState('Email not found'));

        return;
      }

      // 2- استخرج username
      String username = users[0]['username'];

      // 3- Login بالـ username
      Response response = await DioHelper.postData(
        url: 'auth/login',

        data: {'username': username, 'password': password},
      );

      // JWT
      String token = response.data['accessToken'];

      await CacheHelper.saveString(key: 'token', value: token);

      await CacheHelper.saveString(
        key: 'username',
        value: response.data['username'],
      );

      await CacheHelper.saveString(key: 'email', value: response.data['email']);

      print('TOKEN => $token');

      emit(LoginSuccessState());
    } catch (e) {
      print(e);

      emit(LoginErrorState('Login Failed'));
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

  // List to store all news articles fetched from the API
  // List<dynamic> allNews = [];
  // void getAllNews() {
  //   emit(NewsGetAllNewsLoadingState());
  //   DioHelper.getData(
  //         url: 'v2/everything',
  //         // query: {'q': 'news', 'apiKey': apiKey},
  //       )
  //       .then((value) {
  //         print(value.data);
  //         allNews = value.data['articles'];
  //         emit(NewsGetAllNewsSuccessState());
  //       })
  //       .catchError((error) {
  //         print(error.toString());
  //         emit(NewsGetAllNewsErrorState(error.toString()));
  //       });
  // }

  // // List to store search results fetched from the API based on user keywords
  // List<dynamic> search = [];
  // void getSearch(String value) {
  //   emit(NewsGetSearchLoadingState());
  //   DioHelper.getData(
  //         url: 'v2/everything',
  //         // query: {'q': '$value', 'apiKey': apiKey},
  //       )
  //       .then((value) {
  //         search = value.data['articles'];
  //         print(search[0]['title']);
  //         emit(NewsGetSearchSuccessState());
  //       })
  //       .catchError((error) {
  //         emit(NewsGetSearchErrorState(error.toString()));
  //       });
  // }

  // // Function to fetch news articles based on a specific category from the API
  // void getNewsByCategory(String category) {
  //   emit(NewsGetAllNewsLoadingState());
  //   DioHelper.getData(
  //         url: 'v2/top-headlines',
  //         // query: {'category': category, 'country': 'us', 'apiKey': apiKey},
  //       )
  //       .then((value) {
  //         allNews = value.data['articles'];
  //         emit(NewsGetAllNewsSuccessState());
  //       })
  //       .catchError((error) {
  //         emit(NewsGetAllNewsErrorState(error.toString()));
  //       });
  // }
}
