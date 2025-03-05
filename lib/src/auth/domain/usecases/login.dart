import 'package:equatable/equatable.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';

class Login implements UsecasesWithParams<void, LoginParams> {
  const Login(this._repository);
  final AuthRepository _repository;
  @override
  ResultFuture<void> call(LoginParams params) =>
      _repository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}
