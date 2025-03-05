import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/errors/exception.dart';
import 'package:olofooto/core/errors/failure.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/profile/data/data_sources/profile_remote_data_src.dart';
import 'package:olofooto/src/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDataSource);
  final ProfileRemoteDataSrc _remoteDataSource;
  @override
  ResultFuture<User> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid updateUserData({
    String? fullName,
    String? gender,
    String? about,
    String? username,
  }) async {
    try {
      await _remoteDataSource.updateUserData(
        about: about,
        fullname: fullName,
        gender: gender,
        username: username,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException {
      return const Left(DartFailure());
    }
  }

  @override
  ResultVoid updateUserProfile(File profileFile) async {
    try {
      await _remoteDataSource.updateUserProfile(profileFile);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on DartException {
      return const Left(DartFailure());
    }
  }
}
