import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/src/auth/domain/usecases/change_password_forgot.dart';
import 'package:olofooto/src/auth/domain/usecases/get_new_tokens.dart';
import 'package:olofooto/src/auth/domain/usecases/login.dart';
import 'package:olofooto/src/auth/domain/usecases/register_user.dart';
import 'package:olofooto/src/auth/domain/usecases/send_forgot_password_request.dart';
import 'package:olofooto/src/auth/domain/usecases/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RegisterUser registerUser,
    required Login login,
    required VerifyOtp verifyOtp,
    required SendForgotPasswordRequest sendForgotPasswordRequest,
    required ChangePasswordForgot changePasswordForgot,
    required GetNewTokens getNewTokens,
  })  : _registerUser = registerUser,
        _login = login,
        _sendForgotPasswordRequest = sendForgotPasswordRequest,
        _verifyOtp = verifyOtp,
        _changePasswordForgot = changePasswordForgot,
        _getNewTokens = getNewTokens,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<RegistererUserEvent>(_registererUserEventHandler);
    on<LoginEvent>(_loginEventHandler);
    on<VerifyOTPEvent>(_verifyOtpHandler);
    on<SendForgotPasswordRequestEvent>(_sendForgotPasswordRequestHandler);
    on<ChangePasswordForgotEvent>(_changePasswordForgotHandler);
    on<GetNewTokensEvent>(_getNewTokensHandler);
  }
  Future<void> _registererUserEventHandler(
    RegistererUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _registerUser(
      RegisterUserParams(
        fullname: event.fullname,
        email: event.email,
        gender: event.gender,
        about: event.about,
        username: event.username,
        password: event.password,
        profileFile: event.profileFile,
        dob: event.dob,
      ),
    );
    return result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(UserCreated(user)),
    );
  }

  Future<void> _loginEventHandler(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (tokens) => emit(const LoggedIn()),
    );
  }

  Future<void> _verifyOtpHandler(
    VerifyOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result =
        await _verifyOtp(VerifyOptParams(email: event.email, otp: event.otp));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const OTPVerified()),
    );
  }

  Future<void> _sendForgotPasswordRequestHandler(
    SendForgotPasswordRequestEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _sendForgotPasswordRequest(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const SentForgotPasswordRequest()),
    );
  }

  Future<void> _changePasswordForgotHandler(
    ChangePasswordForgotEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _changePasswordForgot(
      ChangePasswordForgotParams(
        email: event.email,
        newPassword: event.newPassword,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(ChangedPassword(user)),
    );
  }

  Future<void> _getNewTokensHandler(
    GetNewTokensEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getNewTokens();
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(const GotTokens()),
    );
  }

  final RegisterUser _registerUser;
  final Login _login;
  final VerifyOtp _verifyOtp;
  final SendForgotPasswordRequest _sendForgotPasswordRequest;
  final ChangePasswordForgot _changePasswordForgot;
  final GetNewTokens _getNewTokens;
}
