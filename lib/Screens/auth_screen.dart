import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc_Cubit/AuthCubit/auth_cubit.dart';
import '../Bloc_Cubit/AuthCubit/auth_state.dart';
import '../Bloc_Cubit/ThemeCubit/theme_cubit.dart';
import '../FireBase/auth_service.dart';
import '../FireBase/account_service.dart';
import '../FireBase/theme_preference_service.dart';
import '../Widgets/AuthWidgets/auth_form_widget.dart';
import 'list_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => AuthCubit(
          AuthService(FirebaseAuth.instance),
          AccountService(),
          context.read<ThemeCubit>(),
          ThemePreferenceService()
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              'Authentication'.tr(),
              style: TextStyle(color: theme.appBarTheme.foregroundColor)
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ListScreen()),
                );
              }

            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AuthAuthenticated) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome, ${state.user.email ?? "User"}'.tr(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                } else {
                  return const AuthForm();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
