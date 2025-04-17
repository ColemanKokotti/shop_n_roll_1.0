import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FireBase/firebase_options.dart';
import 'Bloc_Cubit/AuthCubit/auth_cubit.dart';
import 'FireBase/auth_service.dart';
import 'FireBase/account_service.dart';
import 'Bloc_Cubit/ThemeCubit/theme_cubit.dart';
import 'FireBase/theme_preference_service.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authService = AuthService(FirebaseAuth.instance);
  final accountService = AccountService();
  final themeCubit = ThemeCubit();
  final themePreferenceService = ThemePreferenceService();

  final authCubit = AuthCubit(
      authService,
      accountService,
      themeCubit,
      themePreferenceService
  );

  runApp(
      EasyLocalization(
        supportedLocales: [
          Locale('en'), Locale('it'), Locale('ja'),
          Locale('ru'), Locale('de'), Locale('fr'),
          Locale('es'), Locale("ro"), Locale('ar'),
          Locale('hi'),Locale('zh')
        ],
        path: 'assets/translation',
        fallbackLocale: Locale('en'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authCubit),
            BlocProvider.value(value: themeCubit),
          ],
          child: MyApp(authCubit: authCubit),
        ),
      )
  );
}
