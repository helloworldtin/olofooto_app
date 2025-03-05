import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';

abstract class AppTextStyles {
  static const large = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static final medium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black.withValues(alpha: .7),
  );
  static final small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black.withValues(alpha: .7),
  );
}
