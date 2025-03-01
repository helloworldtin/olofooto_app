import 'package:equatable/equatable.dart';

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
}

class DartFailure extends Failure {
  const DartFailure({
    super.errorMessage = 'Something went wrong',
    super.statusCode = 408,
  });
}
