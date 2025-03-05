part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class UserCreated extends AuthState {
  const UserCreated(this.user);
  final User user;

  @override
  List<Object> get props => [user.uid];
}

final class LoggedIn extends AuthState {
  const LoggedIn();
}

final class OTPVerified extends AuthState {
  const OTPVerified();
}

final class SentForgotPasswordRequest extends AuthState {
  const SentForgotPasswordRequest();
}

final class ChangedPassword extends AuthState {
  const ChangedPassword(this.user);
  final User user;

  @override
  List<Object> get props => [user.uid];
}

final class GotTokens extends AuthState {
  const GotTokens();
}

final class AuthError extends AuthState {
  const AuthError(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
