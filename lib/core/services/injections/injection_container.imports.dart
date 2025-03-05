import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olofooto/core/common/app/cache_helper.dart';
import 'package:olofooto/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:olofooto/src/auth/data/repository/auth_repository_impl.dart';
import 'package:olofooto/src/auth/domain/repository/auth_repository.dart';
import 'package:olofooto/src/auth/domain/usecases/change_password_forgot.dart';
import 'package:olofooto/src/auth/domain/usecases/get_new_tokens.dart';
import 'package:olofooto/src/auth/domain/usecases/login.dart';
import 'package:olofooto/src/auth/domain/usecases/register_user.dart';
import 'package:olofooto/src/auth/domain/usecases/send_forgot_password_request.dart';
import 'package:olofooto/src/auth/domain/usecases/verify_otp.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.dart';
