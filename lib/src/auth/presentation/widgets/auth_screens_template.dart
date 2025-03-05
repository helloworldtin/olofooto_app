import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';
import 'package:olofooto/core/common/resources/style/text.dart';
import 'package:olofooto/core/common/widgets/clickable_text.dart';

class AuthScreensTemplate extends StatelessWidget {
  const AuthScreensTemplate({
    required this.onButtonPressed,
    required this.onTextButtonPresses,
    required this.topTitle,
    required this.topSubTitle,
    required this.actionTextTitle,
    required this.buttonText,
    required this.actionText,
    required this.body,
    super.key,
  });
  final VoidCallback onButtonPressed;
  final VoidCallback onTextButtonPresses;
  final String topTitle;
  final String topSubTitle;
  final String actionTextTitle;
  final String buttonText;
  final String actionText;
  final List<Widget> body;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Text(
                    topTitle,
                    style: AppTextStyles.large,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    topSubTitle,
                    style: AppTextStyles.medium,
                  ),
                  const SizedBox(height: 16),
                  ...body,
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onButtonPressed,
              child: Text(buttonText),
            ),
            const SizedBox(height: 32),
            ClickableText(
              title: actionTextTitle,
              actionText: actionText,
              onPressed: onTextButtonPresses,
              actionTextColor: AppColors.primary,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
