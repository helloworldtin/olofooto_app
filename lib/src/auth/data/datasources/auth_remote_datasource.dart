import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:olofooto/core/common/app/cache_helper.dart';
import 'package:olofooto/core/common/models/user_model.dart';
import 'package:olofooto/core/common/singletons/cache.dart';
import 'package:olofooto/core/errors/exception.dart';
import 'package:olofooto/core/services/injections/injection_container.imports.dart';
import 'package:olofooto/core/utils/constants/network_constants.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/data/models/tokens_model.dart';

abstract interface class AuthRemoteDataSource {
  const AuthRemoteDataSource();
  Future<UserModel> registerUser({
    required String fullname,
    required String email,
    required String gender,
    required String about,
    required String username,
    required String password,
    required File profileFile,
    required String dob,
  });
  Future<void> verifyOTP({
    required String email,
    required String otp,
  });
  Future<void> login({
    required String email,
    required String password,
  });
  Future<void> sendForgotPasswordRequest(String email);

  Future<UserModel> changePasswordForgot({
    required String email,
    required String newPassword,
  });
  Future<void> getNewTokens();

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<void> logout();
  Future<void> deleteAccount();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDatasourceImpl(this._client);
  final Dio _client;

  @override
  Future<UserModel> changePasswordForgot({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _client.post<DataMap>(
        '${NetworkConstants.baseAuth}/change-password-forgot',
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
        data: {
          'email': email,
          'new_password': newPassword,
        },
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
      final user = UserModel.fromMap(data);
      await sl<CacheHelper>().cacheUserId(user.uid);
      return user;
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final response = await _client.get<DataMap>(
        '${NetworkConstants.baseAuth}/delete-user',
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<TokensModel> getNewTokens() async {
    try {
      final response = await _client.get<DataMap>(
        '${NetworkConstants.baseAuth}/get-new-tokens',
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
      return TokensModel.formMap(data);
    } on ServerException {
      rethrow;
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post<DataMap>(
        '${NetworkConstants.baseAuth}/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String,
          statusCode: response.statusCode,
        );
      }
      final token = TokensModel.formMap(data);
      final isAccessTokenCached =
          await sl<CacheHelper>().cacheAccessToken(token.accessToken);
      final isRefreshTokenCached =
          await sl<CacheHelper>().cacheRefreshToken(token.refreshToken);

      if (!(isRefreshTokenCached && isAccessTokenCached)) {
        throw Exception(); // because it throw the dart exception
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<void> logout() async {
    Cache.instance.resetAll();
  }

  @override
  Future<UserModel> registerUser({
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
      final formData = FormData.fromMap({
        'full_name': fullname,
        'email': email,
        'gender': gender,
        'about': about,
        'username': username,
        'password': password,
        'profile_file': await MultipartFile.fromFile(profileFile.path),
        'dob': dob,
      });
      final response = await _client.post<DataMap>(
        '${NetworkConstants.baseAuth}/register',
        data: formData,
      );
      final data = response.data;

      if (data == null || response.statusCode != 201) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
      final user = UserModel.fromMap(data);
      final isUserCache = await sl<CacheHelper>().cacheUserId(user.uid);
      if (!isUserCache) throw Exception();
      return user;
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException(
        errorMessage: (e.response?.data as DataMap)['message'] as String?,
        statusCode: e.response?.statusCode,
      );
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<void> sendForgotPasswordRequest(String email) async {
    //  password-forgot-request
    try {
      final response = await _client.get<DataMap>(
        '${NetworkConstants.baseAuth}/send-password-forgot-request',
        queryParameters: {
          'email': email,
        },
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _client.patch<DataMap>(
        '${NetworkConstants.baseAuth}/update-user-data',
        options: Options(
          headers: NetworkConstants.accessTokenAuthorization,
        ),
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }

  @override
  Future<void> verifyOTP({required String email, required String otp}) async {
    try {
      final response = await _client.post<DataMap>(
        '${NetworkConstants.baseAuth}/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
      );
      final data = response.data;
      if (data == null || response.statusCode != 200) {
        throw ServerException(
          errorMessage: data?['message'] as String?,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const DartException();
    }
  }
}
