import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class SendForgotPasswordRequest implements UsecasesWithParams<void, String> {
  const SendForgotPasswordRequest(this._authRepository);
  final AuthRepository _authRepository;
  @override
  ResultFuture<void> call(String email) =>
      _authRepository.sendForgotPasswordRequest(email);
}
