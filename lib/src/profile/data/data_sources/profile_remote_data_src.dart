import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:olofooto/core/common/models/user_model.dart';
import 'package:olofooto/core/errors/exception.dart';
import 'package:olofooto/core/utils/constants/network_constants.dart';
import 'package:olofooto/core/utils/network_utils.dart';
import 'package:olofooto/core/utils/typedefs.dart';

abstract interface class ProfileRemoteDataSrc {
  const ProfileRemoteDataSrc();
  Future<UserModel> getCurrentUser();
  Future<void> updateUserData({
    String? fullname,
    String? gender,
    String? about,
    String? username,
  });
  Future<void> updateUserProfile(
    File profileFile,
  );
}

class ProfileRemoteDataSrcImpl implements ProfileRemoteDataSrc {
  const ProfileRemoteDataSrcImpl(this._client);
  final Dio _client;
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _client.get<DataMap>(
        '${NetworkConstants.baseAuth}/current-user',
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
      );
      NetworkUtils.validResponse(response, 200);
      return UserModel.fromMap(response.data!);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e) {
      log(e.toString());
      throw const DartException();
    }
  }

  @override
  Future<void> updateUserData({
    String? fullname,
    String? gender,
    String? about,
    String? username,
  }) async {
    try {
      final response = await _client.patch<DataMap>(
        '${NetworkConstants.baseAuth}/update-user-data',
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
        data: {
          'full_name': fullname,
          'gender': gender,
          'about': about,
          'username': username,
        },
      );
      NetworkUtils.validResponse(response, 200);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e) {
      log(e.toString());
      throw const DartException();
    }
  }

  @override
  Future<void> updateUserProfile(File newProfileFile) async {
    try {
      final formData = FormData.fromMap({
        'new_profile_file': await MultipartFile.fromFile(newProfileFile.path),
      });
      final response = await _client.patch<DataMap>(
        '${NetworkConstants.baseAuth}/update-profile',
        data: formData,
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
      );
      NetworkUtils.validResponse(response, 200);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e) {
      log(e.toString());
      throw const DartException();
    }
  }
}
