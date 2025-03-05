import 'package:flutter/material.dart';
import 'package:olofooto/core/common/singletons/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._preferences);
  final SharedPreferences _preferences;
  static const userIdKey = 'user-id';
  static const accessTokenKey = 'access-token';
  static const refreshTokenKey = 'refresh-token';
  static const isFirstTimerKey = 'first-timer-key';

  Future<bool> cacheUserId(String userId) async {
    try {
      final result = await _preferences.setString(userIdKey, userId);
      Cache.instance.userId = userId;
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> cacheAccessToken(String accessToken) async {
    try {
      final result = await _preferences.setString(accessTokenKey, accessToken);
      Cache.instance.accessToken = accessToken;
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> cacheRefreshToken(String refreshToken) async {
    try {
      final result =
          await _preferences.setString(refreshTokenKey, refreshToken);
      Cache.instance.refreshToken = refreshToken;
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> cacheFirstTimer() async {
    await _preferences.setBool(isFirstTimerKey, false);
  }

  bool get isFirstTimer => _preferences.getBool(isFirstTimerKey) ?? true;
  String get getInitialRoute {
    if (!isFirstTimer && Cache.instance.allCached) {
      return '/home';
    } else if (!isFirstTimer) {
      return '/signin';
    } else {
      return '/';
    }
  }
}
