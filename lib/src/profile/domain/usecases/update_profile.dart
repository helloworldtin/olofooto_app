import 'dart:io';

import 'package:olofooto/core/usecase/usecase.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/profile/domain/repository/profile_repository.dart';

class UpdateProfile implements UsecasesWithParams<void, File> {
  const UpdateProfile(this._repository);
  final ProfileRepository _repository;

  @override
  ResultFuture<void> call(File newProfileFile) =>
      _repository.updateUserProfile(newProfileFile);
}
