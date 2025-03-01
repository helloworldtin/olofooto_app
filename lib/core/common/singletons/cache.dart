class Cache {
  Cache._internal();
  static final instance = Cache._internal();
  String? _userId;
  String? _accessToken;
  String? _refreshToken;

  String? get userId => _userId;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

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
