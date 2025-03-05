import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:olofooto/core/common/entities/user.dart';
import 'package:olofooto/src/profile/domain/usecases/get_current_user.dart';
import 'package:olofooto/src/profile/domain/usecases/update_profile.dart';
import 'package:olofooto/src/profile/domain/usecases/update_user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetCurrentUser getCurrentUser,
    required UpdateUserData updateUserData,
    required UpdateProfile updateProfile,
  })  : _getCurrentUser = getCurrentUser,
        _updateProfile = updateProfile,
        _updateUserData = updateUserData,
        super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      emit(const ProfileLoading());
    });
    on<GetCurrentUserEvent>(_getCurrentUserHandler);
    on<UpdateProfileEvent>(_updateProfileHandler);
    on<UpdateUserDataEvent>(_updateUserDataHandler);
  }
  Future<void> _getCurrentUserHandler(
    GetCurrentUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await _getCurrentUser();
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (user) => emit(GotUserData(user)),
    );
  }

  Future<void> _updateUserDataHandler(
    UpdateUserDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await _updateUserData(
      UpdateUserDataParams(
        about: event.about,
        fullName: event.fullName,
        gender: event.gender,
        username: event.username,
      ),
    );
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (_) => emit(const UserDataUpdated()),
    );
  }

  Future<void> _updateProfileHandler(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await _updateProfile(
      event.newProfileFile,
    );
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (_) => emit(const UserProfileUpdated()),
    );
  }

  final GetCurrentUser _getCurrentUser;
  final UpdateUserData _updateUserData;
  final UpdateProfile _updateProfile;
}
