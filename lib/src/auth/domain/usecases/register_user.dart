import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class RegisterUser implements UsecasesWithParams<User, RegisterUserParams> {
  const RegisterUser(this._authRepository);
  final AuthRepository _authRepository;
  @override
  ResultFuture<User> call(RegisterUserParams params) async =>
      _authRepository.registerUser(
        fullname: params.fullname,
        email: params.email,
        gender: params.gender,
        about: params.about,
        username: params.username,
        password: params.password,
        profileFile: params.profileFile,
        dob: params.dob,
      );
}

class RegisterUserParams extends Equatable {
  const RegisterUserParams({
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
  List<Object?> get props => [email, fullname, about, password];
}
