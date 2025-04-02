import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/ThemeCubit/settings_theme_cubit.dart';
import '../../Bloc_Cubit/ThemeCubit/theme_cubit.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  Map<String, Color> getThemeColors() {
    return {
      'default': Color(0xFF009688),
      'light': Colors.blue,
      'dark': Colors.grey[800]!,
      'pastel': Color(0xFFFFB6C1),
      'vintage': Color(0xFF795548),
      'earthy': Color(0xFF6D4C41),
      'ocean': Color(0xFF0277BD),
      'cyberpunk': Color(0xFF00FFD1),
      'godofwar': Color(0xFF8B0000),
      'pokemon' :  Color(0xFFFF0000),
      'honkaistarrail' : Color(0xFF4A6CFF),
      'warframe':  Color(0xFF00A8CC),
      'witcher':Color(0xFFB22222),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeOptions = [
      'default',
      'light',
      'dark',
      'pastel',
      'vintage',
      'earthy',
      'ocean',
      'cyberpunk',
      'godofwar',
      'pokemon',
      'honkaistarrail',
      'warframe',
      'witcher'
    ];
    final themeColors = getThemeColors();

    String getCurrentTheme() {
      final currentThemeData = context.watch<ThemeCubit>().state;
      for (var entry in themeMap.entries) {
        if (entry.value == currentThemeData) {
          return entry.key;
        }
      }
      return 'default';
    }

    final currentTheme = getCurrentTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Theme Selector'.tr(),
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
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                context.read<SettingsThemeCubit>().toggleThemeOptions();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: themeColors[currentTheme],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          currentTheme.toUpperCase(),
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      context.watch<SettingsThemeCubit>().state
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
        BlocBuilder<SettingsThemeCubit, bool>(
          builder: (context, showThemeOptions) {
            if (showThemeOptions) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: themeOptions.length,
                  itemBuilder: (context, index) {
                    final option = themeOptions[index];
                    final isSelected = option == currentTheme;

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print('ThemeSelector: Selezionato tema: $option');
                          context.read<ThemeCubit>().selectTheme(option);
                          context.read<SettingsThemeCubit>().toggleThemeOptions();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: themeColors[option],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    option.toUpperCase(),
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
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}