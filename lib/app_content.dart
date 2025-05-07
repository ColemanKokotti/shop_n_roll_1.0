import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc_Cubit/AuthCubit/auth_cubit.dart';
import 'Bloc_Cubit/AuthCubit/auth_state.dart';
import 'Screens/list_screen.dart';
import 'Screens/auth_screen.dart';

class AppContent extends StatelessWidget {
  const AppContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const ListScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
