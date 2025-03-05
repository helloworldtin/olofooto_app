import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/profile/domain/repository/profile_repository.dart';

class GetCurrentUser implements UsecasesWithoutParams<User> {
  const GetCurrentUser(this._repository);
  final ProfileRepository _repository;

  @override
  ResultFuture<User> call() => _repository.getCurrentUser();
}
