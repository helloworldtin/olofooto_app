import 'package:equatable/equatable.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class UpdatePassword implements UsecasesWithParams<void, UpdatePasswordParams> {
  const UpdatePassword(this._authRepository);
  final AuthRepository _authRepository;
  @override
  ResultFuture<void> call(UpdatePasswordParams params) =>
      _authRepository.updatePassword(
        oldPassword: params.oldPassword,
        newPassword: params.newPassword,
      );
}

class UpdatePasswordParams extends Equatable {
  const UpdatePasswordParams({
    required this.newPassword,
    required this.oldPassword,
  });
  final String newPassword;
  final String oldPassword;

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
