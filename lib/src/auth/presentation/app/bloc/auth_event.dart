part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class RegistererUserEvent extends AuthEvent {
  const RegistererUserEvent({
    required this.fullname,
    required this.email,
    required this.gender,
    required this.about,
    required this.username,
    required this.password,
    required this.profileFile,
    required this.dob,
  });
  final String fullname;
  final String email;
  final String gender;
  final String about;
  final String username;
  final String password;
  final File profileFile;
  final String dob;

  @override
  List<Object> get props => [
        fullname,
        email,
        gender,
        about,
        username,
      ];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class VerifyOTPEvent extends AuthEvent {
  const VerifyOTPEvent({
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;

  @override
  List<Object> get props => [email, otp];
}

class SendForgotPasswordRequestEvent extends AuthEvent {
  const SendForgotPasswordRequestEvent(this.email);
  final String email;
  @override
  List<Object> get props => [email];
}

class ChangePasswordForgotEvent extends AuthEvent {
  const ChangePasswordForgotEvent({
    required this.email,
    required this.newPassword,
  });
  final String email;
  final String newPassword;
}

class GetNewTokensEvent extends AuthEvent {
  const GetNewTokensEvent();
}
