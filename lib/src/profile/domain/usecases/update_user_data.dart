import 'package:equatable/equatable.dart';
import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/profile/domain/repository/profile_repository.dart';

class UpdateUserData implements UsecasesWithParams<void, UpdateUserDataParams> {
  const UpdateUserData(this._repository);
  final ProfileRepository _repository;
  @override
  ResultFuture<void> call(UpdateUserDataParams params) =>
      _repository.updateUserData(
        about: params.about,
        fullName: params.fullName,
        gender: params.gender,
        username: params.username,
      );
}

class UpdateUserDataParams extends Equatable {
  const UpdateUserDataParams({
    this.fullName,
    this.gender,
    this.about,
    this.username,
  });
  final String? fullName;
  final String? gender;
  final String? about;
  final String? username;
  @override
  List<Object?> get props => [username, gender, about];
}
