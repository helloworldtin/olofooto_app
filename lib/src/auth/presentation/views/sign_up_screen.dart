import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/common/widgets/profile_avatar.dart';
import 'package:olofooto/core/utils/core_utils.dart';
import 'package:olofooto/core/utils/validators.dart';
import 'package:olofooto/src/auth/presentation/app/bloc/auth_bloc.dart';
import 'package:olofooto/src/auth/presentation/app/providers/sign_up_controllers_provider.dart';
import 'package:olofooto/src/auth/presentation/utils/auth_utils.dart';
import 'package:olofooto/src/auth/presentation/views/otp_screen.dart';
import 'package:olofooto/src/auth/presentation/views/sign_in_screen.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_dropdown_button.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_screens_template.dart';
import 'package:olofooto/src/auth/presentation/widgets/auth_text_filed.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final ctrlProvider = context.read<SignUpControllersProvider>();
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (_) => false,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: ctrlProvider.pageController,
        children: <Widget>[
          Form(
            key: ctrlProvider.formKeySignup1,
            child: AuthScreensTemplate(
              topTitle: 'Personal Information',
              topSubTitle: 'Please fill the following',
              body: [
                AuthTextFiled(
                  fieldName: 'Fullname',
                  controller: ctrlProvider.fullnameController,
                  validator: Validators.fullNameValidator,
                ),
                const SizedBox(height: 8),
                AuthTextFiled(
                  fieldName: 'Email Address',
                  controller: ctrlProvider.emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: Validators.emailValidator,
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: AuthTextFiled(
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        readOnly: true,
                        onTap: () {
                          AuthUtils.showDatePicker(
                            context: context,
                            onDateTimeChanged: (datetime) {
                              final date = datetime.toString().split(' ')[0];
                              ctrlProvider.dobController.text = date;
                            },
                          );
                        },
                        fieldName: 'Date of Birth',
                        controller: ctrlProvider.dobController,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Please choose the data';
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: AuthDropdownButton(
                        onChanged: (gender) {
                          if (gender != null || gender!.isNotEmpty) {
                            ctrlProvider.genderController.text = gender;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AuthTextFiled(
                  textInputAction: TextInputAction.done,
                  fieldName: 'About',
                  controller: ctrlProvider.bioController,
                  validator: Validators.bioValidator,
                  maxLines: 2,
                ),
              ],
              onButtonPressed: () {
                if (ctrlProvider.formKeySignup1.currentState?.validate() ??
                    false) {
                  ctrlProvider.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }
              },
              buttonText: 'Next',
              actionTextTitle: 'Already have an account?',
              actionText: 'Sign  In',
              onTextButtonPresses: () {
                context.goNamed(SignInScreen.routeName);
              },
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                CoreUtils.showLoadingOverlay(
                  context,
                  loadingMessage: 'Creating Account',
                );
              } else if (state is AuthError) {
                CoreUtils.removeLoadingOverlay();
                CoreUtils.showSnackBar(
                  context: context,
                  message: state.errorMessage,
                );
              } else if (state is UserCreated) {
                CoreUtils.removeLoadingOverlay();
                context.read<AuthBloc>().add(
                      LoginEvent(
                        email: state.user.email,
                        password: ctrlProvider.passwordController.text,
                      ),
                    );
              } else if (state is LoggedIn) {
                final otpParams = OtpScreenParams(
                  email: ctrlProvider.emailController.text,
                  isFromSignUp: true,
                );
                CoreUtils.removeLoadingOverlay();
                context.goNamed(
                  OtpScreen.routeName,
                  extra: otpParams.toMap(),
                );
              }
            },
            child: Form(
              key: ctrlProvider.formKeySignup2,
              child: AuthScreensTemplate(
                topTitle: 'Select a Username',
                topSubTitle: 'Help secure your account',
                body: <Widget>[
                  Consumer<SignUpControllersProvider>(
                    builder: (context, ctr, child) {
                      return ProfileAvatar(
                        imageToShow: ctr.profileFile,
                        underneathText: 'Pick or Click a profile image',
                        onSelectImagePressed: () async {
                          final image = await CoreUtils.showImagePickingOptions(
                            context,
                          );
                          ctrlProvider.profileFile = image;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  AuthTextFiled(
                    fieldName: 'username',
                    validator: Validators.usernameValidator,
                    controller: ctrlProvider.usernameController,
                  ),
                  const SizedBox(height: 8),
                  AuthTextFiled(
                    fieldName: 'Password',
                    obscureText: true,
                    validator: Validators.passwordValidator,
                    controller: ctrlProvider.passwordController,
                  ),
                  const SizedBox(height: 8),
                  AuthTextFiled(
                    fieldName: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (!ctrlProvider.isPasswordMatched) {
                        return "Password don't match";
                      }
                      return null;
                    },
                    controller: ctrlProvider.confirmPasswordController,
                  ),
                ],
                buttonText: 'Done',
                onButtonPressed: () {
                  if (ctrlProvider.formKeySignup2.currentState?.validate() ??
                      false) {
                    ctrlProvider.addRegisterBloc(context);
                  }
                },
                actionTextTitle: 'Already have an account?',
                actionText: 'Sign In',
                onTextButtonPresses: () {
                  context.goNamed(SignInScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
