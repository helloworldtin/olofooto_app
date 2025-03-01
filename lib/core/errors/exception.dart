import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({
    required this.errorMessage,
    required this.statusCode,
  });
  final String errorMessage;
  final int statusCode;

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class ServerException extends AppException {
  const ServerException({
    required super.errorMessage,
    required super.statusCode,
  });
}

class DartException extends AppException {
  const DartException({
    super.errorMessage = 'Something went wrong',
    super.statusCode = 408,
  });
}
