import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/core/utils/typedefs.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.email,
    required super.fullname,
    required super.profileUrl,
    required super.username,
    required super.dob,
    required super.createdAt,
    required super.updatedAt,
    required super.gender,
    required super.about,
  });
  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fullname: map['full_name'] as String,
      profileUrl: map['profile_url'] as String,
      username: map['username'] as String,
      dob: map['dob'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      gender: map['gender'] as String,
      about: map['about'] as String,
    );
  }
}
