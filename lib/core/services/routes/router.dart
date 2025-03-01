part of 'router.imports.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: OnboardingScreen1.routeName,
      builder: (context, state) {
        return const OnboardingScreen1();
      },
      routes: [
        GoRoute(
          path: 'onboarding2',
          name: OnboardingScreen2.routeName,
          builder: (context, state) {
            return const OnboardingScreen2();
          },
        ),
        GoRoute(
          path: 'onboarding3',
          name: OnboardingScreen3.routeName,
          builder: (context, state) {
            return const OnboardingScreen3();
          },
        ),
      ],
    ),
  ],
);
