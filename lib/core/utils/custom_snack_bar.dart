import 'package:flutter/material.dart';
import 'package:food_app/core/theme/colors_manager.dart';

void customSnackBar(BuildContext context,
        {required String message, bool isError = true}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? ColorsManager.error : ColorsManager.success,
        behavior: SnackBarBehavior.floating,
        elevation: 50,
        showCloseIcon: true,
        closeIconColor: ColorsManager.surfaceCream,
      ),
    );
