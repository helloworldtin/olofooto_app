import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';
import 'package:olofooto/core/common/resources/style/text.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.underneathText,
    required this.onSelectImagePressed,
    super.key,
    this.imageToShow,
  });
  final File? imageToShow;
  final String underneathText;
  final VoidCallback onSelectImagePressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage:
                imageToShow != null ? FileImage(imageToShow!) : null,
            radius: 50,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  bottom: -1,
                  right: -1,
                  child: IconButton.filled(
                    onPressed: onSelectImagePressed,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Choose Your profile',
              style: AppTextStyles.medium,
            ),
          ),
        ],
      ),
    );
  }
}
