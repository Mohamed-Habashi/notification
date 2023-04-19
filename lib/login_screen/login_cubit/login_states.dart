abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final String uId;

  LoginSuccessState(this.uId);
}
class AdminLoginLoadingState extends LoginStates{}

class AdminLoginSuccessState extends LoginStates{
  final String uId;

  AdminLoginSuccessState(this.uId);
}
class AdminLoginErrorState extends LoginStates{}
class ShowPasswordSuccessState extends LoginStates{}

class LoginErrorState extends LoginStates{}

class GetDataSuccessState extends LoginStates{}

class GoogleLoginLoadingState extends LoginStates{}

class GoogleLoginSuccessState extends LoginStates{}

class GoogleLoginErrorState extends LoginStates{}

class FaceBookLoginLoadingState extends LoginStates{}

class FaceBookLoginSuccessState extends LoginStates{}

class FaceBookLoginErrorState extends LoginStates{}

class CreateUserLoadingState extends LoginStates{}

class CreateUserSuccessState extends LoginStates{}

class CreateUserErrorState extends LoginStates{}


