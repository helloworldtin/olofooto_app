part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class GetCurrentUserEvent extends ProfileEvent {
  const GetCurrentUserEvent();
}

final class UpdateProfileEvent extends ProfileEvent {
  const UpdateProfileEvent(this.newProfileFile);
  final File newProfileFile;
  @override
  List<Object> get props => [newProfileFile.path];
}

final class UpdateUserDataEvent extends ProfileEvent {
  const UpdateUserDataEvent({
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
  List<Object?> get props => [fullName, gender, about, username];
}
