import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HistoryReceiptScreen extends StatelessWidget {
  const HistoryReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'Order History'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Order history will be displayed here'.tr(),
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}