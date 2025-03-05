import 'package:olofooto/core/common/app/cache_helper.dart';
import 'package:olofooto/core/services/injections/injection_container.imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  Cache._internal();
  static final instance = Cache._internal();
  String? _userId;
  String? _accessToken;
  String? _refreshToken;

  String? get userId {
    if (_userId != null) return _userId;
    final localUserId =
        sl<SharedPreferences>().getString(CacheHelper.userIdKey);
    _userId = localUserId;
    return localUserId;
  }

  String? get accessToken {
    if (_accessToken != null) return _accessToken;
    final localAccessToken =
        sl<SharedPreferences>().getString(CacheHelper.accessTokenKey);
    _accessToken = localAccessToken;
    return localAccessToken;
  }

  String? get refreshToken {
    if (_refreshToken != null) return _refreshToken;
    final localRefreshToken =
        sl<SharedPreferences>().getString(CacheHelper.refreshTokenKey);
    _refreshToken = localRefreshToken;
    return localRefreshToken;
  }

  bool get allCached => refreshToken != null && accessToken != null;

  set userId(String? userId) {
    if (userId != null && userId == _userId) return;
    _userId = userId;
  }

  set accessToken(String? accessToken) {
    if (accessToken != null && accessToken == _accessToken) return;
    _accessToken = accessToken;
  }

  set refreshToken(String? refreshToken) {
    if (refreshToken != null && refreshToken == _refreshToken) return;
    _refreshToken = refreshToken;
  }

  void resetAll() {
    _userId = null;
    _accessToken = null;
    _refreshToken = null;
  }
}
