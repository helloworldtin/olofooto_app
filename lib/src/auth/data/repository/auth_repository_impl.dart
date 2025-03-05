import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/errors/exception.dart';
import 'package:olofooto/core/errors/failure.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<User> changePasswordForgot({
    required String email,
    required String newPassword,
  }) async {
    try {
      final user = await _remoteDataSource.changePasswordForgot(
        email: email,
        newPassword: newPassword,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid deleteAccount() async {
    try {
      await _remoteDataSource.deleteAccount();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultFuture<void> getNewTokens() async {
    try {
      await _remoteDataSource.getNewTokens();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultFuture<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.login(email: email, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid logout() async {
    try {
      await _remoteDataSource.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultFuture<User> registerUser({
    required String fullname,
    required String email,
    required String gender,
    required String about,
    required String username,
    required String password,
    required File profileFile,
    required String dob,
  }) async {
    try {
      final user = await _remoteDataSource.registerUser(
        fullname: fullname,
        email: email,
        gender: gender,
        about: about,
        username: username,
        password: password,
        profileFile: profileFile,
        dob: dob,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid sendForgotPasswordRequest(String email) async {
    try {
      await _remoteDataSource.sendForgotPasswordRequest(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid verifyOTP({required String email, required String otp}) async {
    try {
      await _remoteDataSource.verifyOTP(email: email, otp: otp);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException catch (_) {
      return const Left(DartFailure());
    }
  }
}
