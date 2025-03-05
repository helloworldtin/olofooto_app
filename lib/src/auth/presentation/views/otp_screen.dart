import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';
import 'package:olofooto/core/common/widgets/clickable_text.dart';
import 'package:olofooto/core/utils/core_utils.dart';
import 'package:olofooto/core/utils/typedefs.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';
import 'package:olofooto/src/auth/presentation/app/providers/otp_timer_provider.dart';
import 'package:olofooto/src/auth/presentation/views/sign_up_screen.dart';
import 'package:olofooto/src/auth/presentation/views/welcome_screens.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_screens_template.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.optParams,
    super.key,
  });
  static const routeName = 'opt-screen';

  final OtpScreenParams optParams;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpParams = widget.optParams;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            CoreUtils.showLoadingOverlay(
              context,
              loadingMessage: 'Verifying OTP....',
            );
          } else if (state is OTPVerified) {
            CoreUtils.removeLoadingOverlay();
            if (otpParams.screenTogo != null) {
              context.goNamed(otpParams.screenTogo!, extra: otpParams.extra);
            } else {
              context.goNamed(
                WelcomeScreen.routeName,
                extra: otpParams.isFromSignUp,
              );
            }
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
            topTitle: 'OTP sent',
            topSubTitle: 'Enter the OTP sent to you',
            body: [
              Pinput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'OTP is in yout inbox please check.';
                  }
                  return null;
                },
                controller: otpController,
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                autofocus: true,
                defaultPinTheme: PinTheme(
                  width: 70,
                  height: 60,
                  margin: const EdgeInsets.only(right: 20),
                  textStyle: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<OtpTimerProvider>(
                builder: (context, provider, _) {
                  return ClickableText(
                    mainAxisAlignment: MainAxisAlignment.start,
                    title: "Didn't receive any code?",
                    actionText: provider.counter == 1
                        ? 'Resend'
                        : 'Resend in ${provider.counter}',
                    onPressed: () {
                      if (provider.canResend) {
                        provider.startTimer();
                      } else {
                        context.read<AuthBloc>().add(
                              VerifyOTPEvent(
                                email: otpParams.email,
                                otp: otpController.text,
                              ),
                            );
                      }
                    },
                    actionTextColor: AppColors.red,
                  );
                },
              ),
            ],
            onButtonPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                context.read<AuthBloc>().add(
                      VerifyOTPEvent(
                        email: otpParams.email,
                        otp: otpController.text,
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

class OtpScreenParams {
  const OtpScreenParams({
    required this.email,
    this.screenTogo,
    this.extra,
    this.isFromSignUp = false,
  });

  factory OtpScreenParams.fromMap(DataMap map) {
    return OtpScreenParams(
      email: map['email'] as String,
      screenTogo: map['screenTogo'] as String?,
      isFromSignUp: map['isFromSignUp'] as bool,
      extra: map['extra'] as Object?,
    );
  }
  final String email;
  final String? screenTogo;
  final bool isFromSignUp;
  final Object? extra;

  DataMap toMap() {
    return {
      'email': email,
      'screenTogo': screenTogo,
      'isFromSignUp': isFromSignUp,
      'extra': extra,
    };
  }
}
