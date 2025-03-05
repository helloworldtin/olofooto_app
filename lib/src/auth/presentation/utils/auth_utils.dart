import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';

abstract class AuthUtils {
  static void showDatePicker({
    required BuildContext context,
    required void Function(DateTime) onDateTimeChanged,
  }) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            backgroundColor: AppColors.surface,
            onDateTimeChanged: onDateTimeChanged,
            initialDateTime: DateTime.now(),
            maximumYear: DateTime.now().year,
            minimumYear: 1900,
            dateOrder: DatePickerDateOrder.ymd,
          ),
        );
      },
    );
  }
}
