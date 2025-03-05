import 'package:equatable/equatable.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class VerifyOtp implements UsecasesWithParams<void, VerifyOptParams> {
  const VerifyOtp(this._repository);
  final AuthRepository _repository;
  @override
  ResultFuture<void> call(VerifyOptParams params) =>
      _repository.verifyOTP(email: params.email, otp: params.otp);
}

class VerifyOptParams extends Equatable {
  const VerifyOptParams({required this.email, required this.otp});
  final String email;
  final String otp;
  @override
  List<Object?> get props => [email, otp];
}
