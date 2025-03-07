import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class GetNewTokens implements UsecasesWithoutParams<void> {
  const GetNewTokens(this._authRepository);
  final AuthRepository _authRepository;
  @override
  ResultFuture<void> call() => _authRepository.getNewTokens();
}
