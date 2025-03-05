import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/common/app/cache_helper.dart';
import 'package:olofooto/core/services/injections/injection_container.imports.dart';
import 'package:olofooto/src/auth/presentation/views/sign_in_screen.dart';
import 'package:olofooto/src/auth/presentation/views/sign_up_screen.dart';

abstract class OnboardingUtils {
  static Future<void> navigateToAuthentication({
    required BuildContext context,
    bool isToSignIn = false,
  }) async {
    final navigate = context.goNamed;
    await sl<CacheHelper>().cacheFirstTimer();
    navigate(isToSignIn ? SignInScreen.routeName : SignUpScreen.routeName);
  }
}
