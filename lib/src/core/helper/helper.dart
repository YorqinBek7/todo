import 'package:flutter/material.dart';
import 'package:todo/src/core/colors/colors.dart';

class Helper {
  //ERROR SNACKBAR
  static void showErrorSnackbar({
    required BuildContext context,
    String errorMessage = 'Something went wrong',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.C_EE2B00.withOpacity(.8),
        content: Text(errorMessage),
      ),
    );
  }

//SUCCESS SNACKBAR
  static void showSuccessSnackbar({
    required BuildContext context,
    required String errorMessage,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.C_008000.withOpacity(.8),
        content: Text(errorMessage),
      ),
    );
  }
}
