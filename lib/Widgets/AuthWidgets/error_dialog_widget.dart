import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../Themes/default_theme.dart';

class ErrorDialog {
  ErrorDialog(BuildContext context, String errorMessage) {
    final theme = defaultTheme ;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          'Login Error'.tr(),
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          errorMessage.tr(),
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'.tr()),
          ),
        ],
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
