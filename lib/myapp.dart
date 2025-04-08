import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc_Cubit/LanguageCubit/setting_language_cubit.dart';
import 'Bloc_Cubit/ThemeCubit/theme_cubit.dart';
import 'Bloc_Cubit/ThemeCubit/settings_theme_cubit.dart';
import 'Bloc_Cubit/LanguageCubit/language_cubit.dart';
import 'Bloc_Cubit/AuthCubit/auth_cubit.dart';
import 'Screens/splash_screen.dart';

class MyApp extends StatefulWidget {
  final AuthCubit authCubit;

  const MyApp({super.key, required this.authCubit});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _themeCubit = ThemeCubit();
  }

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _themeCubit,
        ),
        BlocProvider(
          create: (context) => SettingsThemeCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsLanguageCubit(),
        ),
        BlocProvider.value(
          value: widget.authCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, currentTheme) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: "Shop 'n' Roll",
            theme: currentTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}