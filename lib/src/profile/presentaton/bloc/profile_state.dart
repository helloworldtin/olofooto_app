part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class GotUserData extends ProfileState {
  const GotUserData(this.user);
  final User user;

  @override
  List<Object> get props => [user.uid];
}

final class UserProfileUpdated extends ProfileState {
  const UserProfileUpdated();
}

final class UserDataUpdated extends ProfileState {
  const UserDataUpdated();
}

final class ProfileError extends ProfileState {
  const ProfileError(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
