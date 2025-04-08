import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Widgets/SettingsWidgets/change_language_widget.dart';
import '../Widgets/SettingsWidgets/logout_button_widget.dart';
import '../Widgets/SettingsWidgets/theme_selector_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: theme.appBarTheme.elevation,
        title: Text(
          'Settings'.tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ThemeSelector(),
                SizedBox(height: 20),
                ChangeLanguageButton(),
                SizedBox(height: 20),
                LogoutWidgetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}