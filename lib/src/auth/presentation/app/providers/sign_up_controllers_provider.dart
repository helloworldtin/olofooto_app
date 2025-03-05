import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olofooto/core/utils/core_utils.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';

class SignUpControllersProvider with ChangeNotifier {
  SignUpControllersProvider();
  final formKeySignup1 = GlobalKey<FormState>();
  final formKeySignup2 = GlobalKey<FormState>();

  File? _profileFile;

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final pageController = PageController();

  bool get isPasswordMatched =>
      passwordController.text == confirmPasswordController.text;

  File? get profileFile => _profileFile;

  String? _usernameErrorMessage;

  String? get usernameErrorMessage => _usernameErrorMessage;

  set usernameErrorMessage(String? message) {
    if (message == null || message == _usernameErrorMessage) return;
    _usernameErrorMessage = message;
    notifyListeners();
  }

  set profileFile(File? file) {
    if (file == null || file.path == _profileFile?.path) return;
    _profileFile = file;
    notifyListeners();
  }

  bool get _allFieldField {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        bioController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        profileFile != null;
  }

  void addRegisterBloc(BuildContext context) {
    if (!_allFieldField) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Please check! You forgot to some data',
      );
      return;
    }
    context.read<AuthBloc>().add(
          RegistererUserEvent(
            fullname: fullnameController.text.trim(),
            email: emailController.text.trim(),
            gender: genderController.text,
            about: bioController.text.trim(),
            username: usernameController.text.trim(),
            password: passwordController.text,
            profileFile: profileFile!,
            dob: dobController.text,
          ),
        );
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    dobController.dispose();
    genderController.dispose();
    bioController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
