import 'package:olofooto/core/common/singletons/cache.dart';

abstract class NetworkConstants {
  const NetworkConstants();

  static const _baseUrl = 'http://127.0.0.1:8000/api/v1';
  static const baseAuth = '$_baseUrl/auth';
  static final accessTokenAuthorization = {
    'Authorization': 'Bearer ${(Cache.instance.accessToken) ?? ''}',
  };
  static final refreshTokenAuthorization = {
    'Authorization': 'Bearer ${(Cache.instance.refreshToken) ?? ''}',
  };
}
