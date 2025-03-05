import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';
import 'package:olofooto/core/common/resources/style/text.dart';

class AuthTextFiled extends StatelessWidget {
  const AuthTextFiled({
    required this.fieldName,
    this.controller,
    super.key,
    this.maxLines,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });
  final String fieldName;
  final TextEditingController? controller;
  final int? maxLines;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          fieldName,
          style: AppTextStyles.small,
        ),
        TextFormField(
          obscureText: obscureText,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          textAlign: textAlign,
          onTap: onTap,
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            errorMaxLines: 3,
            suffixIcon: suffixIcon,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.red,
                width: .5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: .5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: AppColors.surface,
          ),
        ),
      ],
    );
  }
}
