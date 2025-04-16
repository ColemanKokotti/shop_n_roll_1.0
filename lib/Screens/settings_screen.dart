import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Widgets/SettingsWidgets/change_language_widget.dart';
import '../Widgets/SettingsWidgets/logout_button_widget.dart';
import '../Widgets/SettingsWidgets/profile_button_widget.dart';
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
        elevation: 0,
        title: Text(
          'Settings'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileButton(),
              SizedBox(height: 20),
              ThemeSelector(),
              SizedBox(height: 20),
              ChangeLanguageButton(),
              SizedBox(height: 20),
              LogoutWidgetButton(),
            ],
          ),
        ),
      ),
    );
  }
}