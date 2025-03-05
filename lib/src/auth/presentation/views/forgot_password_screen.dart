import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/utils/core_utils.dart';
import 'package:olofooto/core/utils/validators.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';
import 'package:olofooto/src/auth/presentation/views/otp_screen.dart';
import 'package:olofooto/src/auth/presentation/views/set_new_password_screen.dart';
import 'package:olofooto/src/auth/presentation/views/sign_up_screen.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_screens_template.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_text_filed.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = 'forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
              loadingMessage: 'Sending OTP to your mail..',
            );
          } else if (state is SentForgotPasswordRequest) {
            final otpParams = OtpScreenParams(
              email: emailController.text,
              screenTogo: SetNewPasswordScreen.routeName,
              extra: emailController.text,
            );
            CoreUtils.removeLoadingOverlay();
            context.goNamed(
              OtpScreen.routeName,
              extra: otpParams.toMap(),
            );
          } else if (state is AuthError) {
            CoreUtils.removeLoadingOverlay();
            CoreUtils.showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        child: Form(
          key: formKey,
          child: AuthScreensTemplate(
            topTitle: 'Forgot Password',
            topSubTitle: "Let's help recover your account",
            body: [
              AuthTextFiled(
                fieldName: 'Email',
                controller: emailController,
                validator: Validators.emailValidator,
              ),
            ],
            onButtonPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                context.read<AuthBloc>().add(
                      SendForgotPasswordRequestEvent(emailController.text),
                    );
              }
            },
            buttonText: 'Next',
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
