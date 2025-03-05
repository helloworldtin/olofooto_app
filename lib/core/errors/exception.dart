import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:olofooto/core/utils/typedefs.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({
    this.errorMessage = 'Internal server Error',
    this.statusCode = 500,
  });
  final String? errorMessage;
  final int? statusCode;

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class ServerException extends AppException {
  const ServerException({
    required super.errorMessage,
    required super.statusCode,
  });
  factory ServerException.fromDioException(DioException e) {
    final data = e.response?.data as DataMap?;
    return ServerException(
      errorMessage: data?['message'] as String?,
      statusCode: e.response?.statusCode,
    );
  }
}

class DartException extends AppException {
  const DartException({
    super.errorMessage = 'Something went wrong',
    super.statusCode = 408,
  });
}
