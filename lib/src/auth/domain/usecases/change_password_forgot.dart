import 'package:equatable/equatable.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class ChangePasswordForgot
    implements UsecasesWithParams<void, ChangePasswordForgotParams> {
  const ChangePasswordForgot(this._authRepository);
  final AuthRepository _authRepository;
  @override
  ResultFuture<void> call(ChangePasswordForgotParams params) =>
      _authRepository.changePasswordForgot(
        email: params.email,
        newPassword: params.newPassword,
      );
}

class ChangePasswordForgotParams extends Equatable {
  const ChangePasswordForgotParams({
    required this.email,
    required this.newPassword,
  });
  final String email;
  final String newPassword;
  @override
  List<Object?> get props => [email, newPassword];
}
