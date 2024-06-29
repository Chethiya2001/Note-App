import 'package:app/utils/colors.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class AppHelper {
  static void showShnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(
          message,
          style: AppTextStyles.appButton,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
