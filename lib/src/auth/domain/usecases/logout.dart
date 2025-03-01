import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class Logout implements UsecasesWithoutParams<void> {
  const Logout(this._authRepository);
  final AuthRepository _authRepository;
  @override
  ResultFuture<void> call() => _authRepository.logout();
}
