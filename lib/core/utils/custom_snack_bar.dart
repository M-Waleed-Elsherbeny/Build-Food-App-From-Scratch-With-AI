import 'package:flutter/material.dart';
import 'package:food_app/core/widgets/app_toast.dart';

void customSnackBar(BuildContext context,
    {required String message, bool isError = true}) {
  if (isError) {
    AppToast.showError(context, message);
  } else {
    AppToast.showSuccess(context, message);
  }
}
