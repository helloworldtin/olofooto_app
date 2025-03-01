import 'package:equatable/equatable.dart';

class Tokens extends Equatable {
  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });
  final String accessToken;
  final String refreshToken;
  @override
  List<Object?> get props => [accessToken, refreshToken];
}
