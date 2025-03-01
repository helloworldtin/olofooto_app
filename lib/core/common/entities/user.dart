import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    required this.email,
    required this.fullname,
    required this.profileUrl,
    required this.username,
    required this.dob,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.about,
  });
  final String uid;
  final String email;
  final String fullname;
  final String profileUrl;
  final String username;
  final String dob;
  final String createdAt;
  final String updatedAt;
  final String gender;
  final String about;

  @override
  List<Object?> get props => [uid];
}
