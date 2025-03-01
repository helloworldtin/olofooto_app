import 'package:flutter/material.dart';
import 'package:olofooto/core/common/singletons/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._preferences);
  final SharedPreferences _preferences;
  static const _userIdKey = 'user-id';
  static const _accessTokenKey = 'access-token';
  static const _refreshTokenKey = 'refresh-token';
  static const _isFirstTimerKey = 'first-timer-key';

  Future<bool> cacheUserId(String userId) async {
    try {
      final result = await _preferences.setString(_userIdKey, userId);
      Cache.instance.userId = userId;
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> cacheAccessToken(String accessToken) async {
    try {
      final result = await _preferences.setString(_accessTokenKey, accessToken);
      Cache.instance.accessToken = accessToken;
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> cacheRefreshAndAccessToken(String refreshToken) async {
    try {
      final result =
          await _preferences.setString(_refreshTokenKey, refreshToken);
      Cache.instance.refreshToken = refreshToken;
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> cacheFirstTimer() async {
    await _preferences.setBool(_isFirstTimerKey, false);
  }

  bool get isFirstTimer => _preferences.getBool(_isFirstTimerKey) ?? true;
}
