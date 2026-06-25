// states for News App
abstract class ProjectStates {}

class ProjectInitialState extends ProjectStates {}

class ProjectBottomNavState extends ProjectStates {}

class LoginLoadingState extends ProjectStates {}

class LoginSuccessState extends ProjectStates {}

class LoginErrorState extends ProjectStates {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends ProjectStates {}

class RegisterSuccessState extends ProjectStates {}

class RegisterErrorState extends ProjectStates {
  final String error;

  RegisterErrorState(this.error);
}




// class NewsGetAllNewsLoadingState extends ProjectStates {}

// class NewsGetAllNewsSuccessState extends ProjectStates {}

// class NewsGetAllNewsErrorState extends ProjectStates {
//   late final String error;

//   NewsGetAllNewsErrorState(this.error);
// }

// class NewsGetSearchLoadingState extends ProjectStates {}

// class NewsGetSearchSuccessState extends ProjectStates {}

// class NewsGetSearchErrorState extends ProjectStates {
//   late final String error;

//   NewsGetSearchErrorState(this.error);
// }