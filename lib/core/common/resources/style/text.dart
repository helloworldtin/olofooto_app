import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';

abstract class AppTextStyles {
  static const largeTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static final mediumTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withValues(alpha: .7),
  );
  static final smallTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withValues(alpha: .7),
  );
}
