import 'package:dio/dio.dart';
import 'package:electropi/models/projects_model.dart';
import 'package:electropi/models/tasks_model.dart';
import 'package:electropi/modules/Project_Screen.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electropi/cubit/states.dart';
import 'package:electropi/modules/profile_screen.dart';
import 'package:electropi/shared/network/dio_helper.dart';

class ProjectCubit extends Cubit<ProjectStates> {
  ProjectCubit() : super(ProjectInitialState());

  static ProjectCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];

  List<Widget> screen = [ProjectsScreen(), ProfileScreen()];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ProjectBottomNavState());
  }

  Future login({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      String? savedEmail = CacheHelper.getString(key: 'email');

      String? savedPassword = CacheHelper.getString(key: 'password');

      if (savedEmail == email) {
        if (savedPassword != password) {
          emit(LoginErrorState('Incorrect password'));

          return;
        }

        emit(LoginSuccessState());

        return;
      }

      Response userResponse = await DioHelper.getData(
        url: 'users/search?q=$email',
      );

      List users = userResponse.data['users'];

      if (users.isEmpty) {
        emit(LoginErrorState('Email not found'));

        return;
      }

      var user = users.first;

      try {
        Response response = await DioHelper.postData(
          url: 'auth/login',

          data: {'username': user['username'], 'password': password},
        );

        await CacheHelper.saveString(
          key: 'token',

          value: response.data['accessToken'],
        );

        await CacheHelper.saveString(key: 'username', value: user['username']);

        await CacheHelper.saveString(key: 'email', value: user['email']);

        emit(LoginSuccessState());
      } on DioException {
        emit(LoginErrorState('Incorrect password'));
      }
    } catch (_) {
      emit(LoginErrorState('Something went wrong'));
    }
  }

  Future register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    try {
      Response response = await DioHelper.getData(url: 'users/search?q=$email');

      List users = response.data['users'];

      bool emailExists = users.any(
        (user) => user['email'].toString().toLowerCase() == email.toLowerCase(),
      );

      if (emailExists) {
        emit(RegisterErrorState('This email is already registered'));
        return;
      }

      await CacheHelper.saveString(key: 'username', value: username);

      await CacheHelper.saveString(key: 'email', value: email);

      await CacheHelper.saveString(key: 'password', value: password);

      emit(RegisterSuccessState());
    } on DioException catch (e) {
      emit(
        RegisterErrorState(
          e.response?.data?['message'] ??
              'Registration failed. Please try again.',
        ),
      );
    } catch (_) {
      emit(RegisterErrorState('Something went wrong'));
    }
  }

  Future updateProfile({
    required String username,
    required String email,
  }) async {
    emit(UpdateProfileLoadingState());
    try {
      String? token = CacheHelper.getString(key: 'token');
      if (token != null) {
        try {
          await DioHelper.putData(
            url: 'users/1',
            data: {"username": username, "email": email},
          );
        } catch (_) {}
      }
      await CacheHelper.saveString(key: 'username', value: username);
      await CacheHelper.saveString(key: 'email', value: email);
      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  List<ProjectModel> filteredProjects = [];

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
        return project.title.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
    emit(SearchProjectSuccessState());
  }

  List<ProjectModel> projects = [];
  List<TaskModel> projectTasks = [];

  Future getProjects() async {
    emit(GetProjectsLoading());

    try {
      var response = await DioHelper.getDataProjects(url: 'posts');

      List data = response.data['posts'];

      List<ProjectModel> validProjects = [];

      for (var item in data) {
        try {
          var tasksResponse = await DioHelper.getDataProjects(
            url: 'todos/user/${item['userId']}',
          );

          if ((tasksResponse.data['todos'] as List).isNotEmpty) {
            validProjects.add(ProjectModel.fromJson(item));
          }
        } catch (_) {}
      }

      projects = validProjects;

      filteredProjects = List.from(projects);

      emit(GetProjectsSuccess());
    } on DioException {
      emit(GetProjectsError('Failed to load projects'));
    } catch (_) {
      emit(GetProjectsError('Unexpected error'));
    }
  }

  Future getProjectTasks(int userId) async {
    emit(GetTasksLoading());
    try {
      var response = await DioHelper.getDataProjects(url: 'todos/user/$userId');
      projectTasks = (response.data['todos'] as List)
          .map((e) => TaskModel.fromJson(e))
          .toList();
      emit(GetTasksSuccess());
    } catch (e) {
      emit(GetTasksError(e.toString()));
    }
  }

  void toggleTask(int index) {
    projectTasks[index].selected = !projectTasks[index].selected;
    projectTasks[index].status = projectTasks[index].selected
        ? 'Done'
        : 'In Progress';
    emit(UpdateTaskState());
  }

  void addTask({
    required String title,
    required String priority,
    required String status,
  }) {
    projectTasks.insert(
      0,
      TaskModel(
        title: title,
        priority: priority,
        status: status,
        selected: false,
      ),
    );
    emit(UpdateTaskState());
  }

  bool isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
  void changeTheme() {
    isDark = !isDark;
    CacheHelper.saveBoolean(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }
}
