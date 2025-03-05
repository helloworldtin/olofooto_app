import 'dart:io';

import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/utils/typedefs.dart';

abstract interface class ProfileRepository {
  const ProfileRepository();
  ResultFuture<User> getCurrentUser();
  ResultVoid updateUserData({
    String? fullName,
    String? gender,
    String? about,
    String? username,
  });
  ResultVoid updateUserProfile(
    File profileFile,
  );
}
