import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationService {
  static void changeLocale(BuildContext context, String languageCode) {
    context.setLocale(Locale(languageCode));
  }
}