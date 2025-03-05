import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olofooto/core/common/resources/medias.dart';
import 'package:olofooto/core/common/resources/style/text.dart';
import 'package:olofooto/src/home/presentation/views/home_view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    required this.isSignup,
    super.key,
  });
  final bool isSignup;
  static const routeName = 'welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(Medias.welcome),
            ),
            const SizedBox(height: 16),
            Text(
              isSignup ? 'Welcome' : 'Welcome Back',
              style: AppTextStyles.large,
            ),
            const SizedBox(height: 42),
            ElevatedButton(
              onPressed: () {
                context.goNamed(HomeView.routeName);
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
