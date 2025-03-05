import 'dart:io';

import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/utils/typedefs.dart';

abstract interface class AuthRepository {
  const AuthRepository();
  // using string for dob gender because we are giving to select value
  // not to type
  ResultFuture<User> registerUser({
    required String fullname,
    required String email,
    required String gender,
    required String about,
    required String username,
    required String password,
    required File profileFile,
    required String dob,
  });
  ResultVoid verifyOTP({
    required String email,
    required String otp,
  });
  ResultVoid login({
    required String email,
    required String password,
  });
  ResultVoid sendForgotPasswordRequest(String email);

  ResultFuture<User> changePasswordForgot({
    required String email,
    required String newPassword,
  });
  ResultVoid getNewTokens();

  ResultVoid updatePassword({
    required String oldPassword,
    required String newPassword,
  });
  ResultVoid logout();
  ResultVoid deleteAccount();
}
