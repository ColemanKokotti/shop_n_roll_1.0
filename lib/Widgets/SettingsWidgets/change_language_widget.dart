import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Bloc_Cubit/LanguageCubit/language_cubit.dart';
import '../../Bloc_Cubit/LanguageCubit/setting_language_cubit.dart';
import '../../FireBase/firebase_language_preference.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final languageOptions = ['en', 'en_US', 'hi', 'zh', 'it', 'ja', 'ru', 'de', 'fr', 'es', 'ro', 'ar'];
    final languageNames = {
      'en': 'English',
      'en_US': 'English (US)',
      'hi': 'हिंदी',
      'zh': '中文',
      'it': 'Italiano',
      'ja': '日本語',
      'ru': 'Русский',
      'de': 'Deutsch',
      'fr': 'Français',
      'es': 'Español',
      'ro': 'Română',
      'ar': 'العربية',
    };

    final languageFlags = {
      'en': 'assets/icons/united_kingdom_flag_icon.png',
      'en_US': 'assets/icons/usa_flag_icon.png',
      'hi': 'assets/icons/india_flag_icon.png',
      'zh': 'assets/icons/china_flag_icon.png',
      'it': 'assets/icons/italy_flag_icon.png',
      'ja': 'assets/icons/japan_flag_icon.png',
      'ru': 'assets/icons/russia_flag_icon.png',
      'de': 'assets/icons/germany_flag_icon.png',
      'fr': 'assets/icons/france_flag_icon.png',
      'es': 'assets/icons/spain_flag_icon.png',
      'ro': 'assets/icons/romania_flag_icon.png',
      'ar': 'assets/icons/arabian_flag_icon.png',
    };

    final LanguagePreferenceService languagePreferenceService = LanguagePreferenceService();

    String getCurrentLanguage() {
      return context.locale.languageCode;
    }

    final currentLanguage = getCurrentLanguage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Language Selector'.tr(),
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                context.read<SettingsLanguageCubit>().toggleLanguageOptions();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          languageFlags[currentLanguage]!,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          languageNames[currentLanguage]?.toUpperCase() ?? 'ENGLISH',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      context.watch<SettingsLanguageCubit>().state
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        BlocBuilder<SettingsLanguageCubit, bool>(
          builder: (context, showLanguageOptions) {
            if (showLanguageOptions) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: languageOptions.length,
                  itemBuilder: (context, index) {
                    final option = languageOptions[index];
                    final isSelected = option == currentLanguage;

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          final newLocale = Locale(option);

                          final User? currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser != null) {
                            await languagePreferenceService.saveLanguagePreference(
                                currentUser.uid,
                                option
                            );
                          }

                          context.setLocale(newLocale);
                          context.read<LanguageCubit>().selectLanguage(newLocale);
                          context.read<SettingsLanguageCubit>().toggleLanguageOptions();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    languageFlags[option]!,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    languageNames[option]?.toUpperCase() ?? option.toUpperCase(),
                                    style: TextStyle(
                                      color: isSelected ? theme.primaryColor : theme.textTheme.bodyLarge?.color,
                                      fontSize: 16.0,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: theme.primaryColor,
                                  size: 20.0,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
