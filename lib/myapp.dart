import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc_Cubit/LanguageCubit/setting_language_cubit.dart';
import 'Bloc_Cubit/ThemeCubit/theme_cubit.dart';
import 'Bloc_Cubit/ThemeCubit/settings_theme_cubit.dart';
import 'Bloc_Cubit/LanguageCubit/language_cubit.dart';
import 'Bloc_Cubit/AuthCubit/auth_cubit.dart';
import 'Screens/splash_screen.dart';
import 'app_content.dart';
import 'main.dart';

class MyApp extends StatefulWidget {
  final AuthCubit authCubit;
  final bool showSplash;

  const MyApp({
    super.key, 
    required this.authCubit,
    this.showSplash = true,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure the app is properly initialized
      widget.authCubit.loadCredentials();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
            navigatorKey: navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: "Shop 'n' Roll",
            theme: currentTheme,
            debugShowCheckedModeBanner: false,
            home: widget.showSplash ? const SplashScreen() : const AppContent(),
          );
        },
      ),
    );
  }
}