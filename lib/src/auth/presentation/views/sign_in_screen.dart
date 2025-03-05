import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/utils/core_utils.dart';
import 'package:olofooto/core/utils/validators.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';

import 'package:olofooto/src/auth/presentation/views/forgot_password_screen.dart';
import 'package:olofooto/src/auth/presentation/views/sign_up_screen.dart';
import 'package:olofooto/src/auth/presentation/views/welcome_screens.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_screens_template.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_text_filed.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = 'signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        notificationPredicate: (_) => false,
      ),
      body: Form(
        key: formKey,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              CoreUtils.showLoadingOverlay(
                context,
                loadingMessage: 'Logging In...',
              );
            } else if (state is LoggedIn) {
              CoreUtils.removeLoadingOverlay();

              context.goNamed(WelcomeScreen.routeName, extra: false);
            } else if (state is AuthError) {
              CoreUtils.removeLoadingOverlay();
              CoreUtils.showSnackBar(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          child: AuthScreensTemplate(
            topTitle: 'Sign In',
            topSubTitle: 'Enter your credentials',
            body: [
              AuthTextFiled(
                fieldName: 'Email',
                controller: emailController,
                validator: Validators.emailValidator,
              ),
              const SizedBox(height: 8),
              AuthTextFiled(
                fieldName: 'Password',
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.goNamed(ForgotPasswordScreen.routeName);
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
            ],
            onButtonPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                context.read<AuthBloc>().add(
                      LoginEvent(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
              }
            },
            buttonText: 'Done',
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
