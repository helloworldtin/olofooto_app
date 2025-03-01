import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({
    required this.title,
    required this.actionText,
    required this.onPressed,
    super.key,
    this.actionTextColor,
  });
  final String title;
  final String actionText;
  final VoidCallback onPressed;
  final Color? actionTextColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.blackColor,
          ),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            actionText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: actionTextColor ?? const Color(0xffc4c4c4),
            ),
          ),
        ),
      ],
    );
  }
}
