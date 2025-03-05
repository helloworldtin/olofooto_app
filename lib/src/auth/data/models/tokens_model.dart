import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/entities/tokens.dart';

class TokensModel extends Tokens {
  const TokensModel({
    required super.accessToken,
    required super.refreshToken,
  });
  factory TokensModel.formMap(DataMap map) {
    return TokensModel(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }
}
