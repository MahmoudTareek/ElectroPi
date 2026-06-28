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

class SearchProjectLoadingState extends ProjectStates {}

class SearchProjectSuccessState extends ProjectStates {}

class SearchProjectErrorState extends ProjectStates {
  final String error;

  SearchProjectErrorState(this.error);
}

class UpdateProfileLoadingState
    extends ProjectStates {}

class UpdateProfileSuccessState
    extends ProjectStates {}

class UpdateProfileErrorState
    extends ProjectStates {

  final String error;

  UpdateProfileErrorState(
    this.error,
  );
}

class GetProjectsLoading extends ProjectStates {}

class GetProjectsSuccess extends ProjectStates {}

class GetProjectsError extends ProjectStates {
  final String error;

  GetProjectsError(this.error);
}

class GetTasksLoading extends ProjectStates {}

class GetTasksSuccess extends ProjectStates {}

class GetTasksError extends ProjectStates {
  final String error;

  GetTasksError(this.error);
}

class UpdateTaskState extends ProjectStates {}

class AddTaskLoading extends ProjectStates {}

class AddTaskSuccess extends ProjectStates {}

class AddTaskError extends ProjectStates {
  final String error;

  AddTaskError(this.error);
}