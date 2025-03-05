part of 'router.imports.dart';

final routerConfig = GoRouter(
  initialLocation: sl<CacheHelper>().getInitialRoute,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: OnboardingScreen1.routeName,
      builder: (_, __) {
        return const OnboardingScreen1();
      },
      routes: [
        GoRoute(
          path: 'onboarding2',
          name: OnboardingScreen2.routeName,
          builder: (_, __) {
            return const OnboardingScreen2();
          },
        ),
        GoRoute(
          path: 'onboarding3',
          name: OnboardingScreen3.routeName,
          builder: (_, __) {
            return const OnboardingScreen3();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/signup',
      name: SignUpScreen.routeName,
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SignUpControllersProvider(),
            ),
            BlocProvider(create: (_) => sl<AuthBloc>()),
          ],
          child: const SignUpScreen(),
        );
      },
    ),
    GoRoute(
      path: '/signin',
      name: SignInScreen.routeName,
      builder: (_, __) {
        return BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'forgot-password',
          name: ForgotPasswordScreen.routeName,
          builder: (_, __) {
            return BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const ForgotPasswordScreen(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'set-new-password',
              name: SetNewPasswordScreen.routeName,
              builder: (_, state) {
                return BlocProvider(
                  create: (context) => sl<AuthBloc>(),
                  child: SetNewPasswordScreen(
                    email: state.extra! as String,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/welcome',
      name: WelcomeScreen.routeName,
      builder: (_, state) {
        final isSignUp = state.extra! as bool;
        return WelcomeScreen(
          isSignup: isSignUp,
        );
      },
    ),
    GoRoute(
      path: '/verify-top',
      name: OtpScreen.routeName,
      builder: (_, state) {
        final data = state.extra! as DataMap;
        return MultiBlocProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => OtpTimerProvider()..startTimer(),
            ),
            BlocProvider(create: (_) => sl<AuthBloc>()),
          ],
          child: OtpScreen(
            optParams: OtpScreenParams.fromMap(data),
          ),
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return DashboardScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: HomeView.routeName,
              builder: (_, __) {
                return const HomeView();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: ProfileView.routeName,
              builder: (_, __) {
                return const ProfileView();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
