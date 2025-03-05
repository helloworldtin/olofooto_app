import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';

class AuthDropdownButton extends StatelessWidget {
  const AuthDropdownButton({super.key, this.onChanged});
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        const Text('Gender'),
        DropdownButtonFormField<String>(
          alignment: Alignment.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please choose your gender';
            }
            return null;
          },
          borderRadius: BorderRadius.circular(10),
          dropdownColor: AppColors.surface,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'female',
              child: Text('Female'),
            ),
            DropdownMenuItem(
              value: 'other',
              child: Text('Others'),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
