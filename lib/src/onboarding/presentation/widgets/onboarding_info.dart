import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/text.dart';
import 'package:olofooto/core/common/widgets/clickable_text.dart';

class OnboardingInfo extends StatelessWidget {
  const OnboardingInfo({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onClick,
    super.key,
    this.isLast = false,
  });
  final String imagePath;
  final String title;
  final String subTitle;
  final bool isLast;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Image.asset(imagePath)),
            const SizedBox(height: 40),
            Text(
              title,
              style: AppTextStyles.largeTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              subTitle,
              style: AppTextStyles.mediumTextStyle,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onClick,
              child: Text(
                isLast ? 'Continue' : 'Next',
              ),
            ),
            const SizedBox(height: 20),
            if (!isLast)
              OutlinedButton(
                onPressed: () {
                  // TODO(navigate): Navigate to the auth sign up screen
                },
                child: const Text('Skip'),
              ),
            const SizedBox(height: 30),
            ClickableText(
              title: 'Already have an account?',
              actionText: 'Sign In',
              onPressed: () {
                // TODO(navigate): Navigate to the auth sign in screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
