import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';
import 'package:olofooto/core/common/resources/style/text.dart';
import 'package:olofooto/core/services/injections/injection_container.imports.dart';

class CoreUtils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBarAnimationStyle: AnimationStyle(),
        SnackBar(
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: kToolbarHeight,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Text(message),
        ),
      );
  }

  static Future<File?> pickImageFrom(ImageSource source) async {
    try {
      final imageXFile = await sl<ImagePicker>().pickImage(source: source);
      if (imageXFile == null) return null;
      return File(imageXFile.path);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<File?> showImagePickingOptions(BuildContext context) async {
    File? file;
    await showModalBottomSheet<void>(
      backgroundColor: AppColors.surface,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    padding: const EdgeInsets.all(16),
                    onPressed: () async {
                      file = await pickImageFrom(ImageSource.camera);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.camera,
                      size: 50,
                    ),
                  ),
                  Text('Camera', style: AppTextStyles.medium),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    padding: const EdgeInsets.all(16),
                    onPressed: () async {
                      file = await pickImageFrom(ImageSource.gallery);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.photo,
                      size: 50,
                    ),
                  ),
                  Text('Photos', style: AppTextStyles.medium),
                ],
              ),
            ],
          ),
        );
      },
    );
    return file;
  }

  static OverlayEntry? _overlayEntry;
  static void showLoadingOverlay(
    BuildContext context, {
    String? loadingMessage,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          color: AppColors.black.withValues(alpha: .8),
          child: Align(
            child: Container(
              margin: const EdgeInsets.all(26),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                color: AppColors.actionText,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  ),
                  Text(
                    loadingMessage ?? 'Please wait Loading...',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (_overlayEntry != null) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  static void removeLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
