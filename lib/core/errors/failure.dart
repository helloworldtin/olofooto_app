import 'package:equatable/equatable.dart';
import 'package:olofooto/core/errors/exception.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.errorMessage,
    required this.statusCode,
  });
  final String errorMessage;
  final int statusCode;

  String errorWithCode() {
    return '$statusCode: $errorMessage';
  }

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.errorMessage,
    required super.statusCode,
  });
  factory ServerFailure.fromException(AppException e) {
    return ServerFailure(
      errorMessage: e.errorMessage ?? 'Internal server Error',
      statusCode: e.statusCode ?? 500,
    );
  }
}

class DartFailure extends Failure {
  const DartFailure()
      : super(errorMessage: 'something went wrong', statusCode: 405);
}
