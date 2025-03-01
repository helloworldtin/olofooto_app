import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/common/resources/medias.dart';
import 'package:olofooto/src/onboarding/presentation/widgets/onboarding_info.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});
  static const routeName = 'onboarding1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingInfo(
        onClick: () {
          context.goNamed(OnboardingScreen2.routeName);
        },
        imagePath: Medias.onboarding1,
        title: 'Connect with Friends\nand Family',
        subTitle: 'Connecting with Family and Friends provides a sense of'
            ' belonging and security ',
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});
  static const routeName = 'onboarding2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingInfo(
        onClick: () {
          context.goNamed(OnboardingScreen3.routeName);
        },
        imagePath: Medias.onboarding2,
        title: 'Make new friends\nwith ease',
        subTitle: 'Allowing you to make new Friends is our Number one'
            ' priority.....',
      ),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});
  static const routeName = 'onboarding3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingInfo(
        onClick: () {
          // TODO(cache): cache the user and send to sign-up
        },
        imagePath: Medias.onboarding1,
        isLast: true,
        title: 'Express yourself to\nthe world',
        subTitle: 'Let your voice be heard on the internet through the OFOFO'
            ' features on the App without restrictions',
      ),
    );
  }
}
