import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/utils/core_utils.dart';
import 'package:olofooto/core/utils/validators.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';
import 'package:olofooto/src/auth/presentation/views/sign_up_screen.dart';
import 'package:olofooto/src/auth/presentation/views/welcome_screens.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_screens_template.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_text_filed.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({required this.email, super.key});
  static const routeName = 'set-new-password';
  final String email;

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (_) => false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            CoreUtils.showLoadingOverlay(
              context,
              loadingMessage: 'Changing password and logging in',
            );
          } else if (state is AuthError) {
            CoreUtils.removeLoadingOverlay();
            CoreUtils.showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          } else if (state is ChangedPassword) {
            CoreUtils.removeLoadingOverlay();
            context.read<AuthBloc>().add(
                  LoginEvent(
                    email: widget.email,
                    password: newPasswordController.text,
                  ),
                );
          } else if (state is LoggedIn) {
            CoreUtils.removeLoadingOverlay();
            context.goNamed(WelcomeScreen.routeName, extra: false);
          }
        },
        child: Form(
          key: formKey,
          child: AuthScreensTemplate(
            topTitle: 'Pick a new Password',
            topSubTitle: 'Help secure your account',
            body: <Widget>[
              AuthTextFiled(
                fieldName: 'New Password',
                controller: newPasswordController,
                validator: Validators.passwordValidator,
                obscureText: true,
              ),
              const SizedBox(height: 8),
              AuthTextFiled(
                obscureText: true,
                fieldName: 'Confirm new Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hey retype your password';
                  } else if (value != newPasswordController.text) {
                    return "Password don't match";
                  }
                  return null;
                },
              ),
            ],
            buttonText: 'Done',
            onButtonPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                context.read<AuthBloc>().add(
                      ChangePasswordForgotEvent(
                        email: widget.email,
                        newPassword: newPasswordController.text,
                      ),
                    );
              }
            },
            actionTextTitle: 'Do not have an Account?',
            actionText: 'Sign up',
            onTextButtonPresses: () {
              context.goNamed(SignUpScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
