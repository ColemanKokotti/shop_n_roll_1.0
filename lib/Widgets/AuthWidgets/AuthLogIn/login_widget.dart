import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/AuthCubit/auth_cubit.dart';
import '../../../Bloc_Cubit/AuthCubit/auth_state.dart';
import '../animated_text_widget.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.read<AuthCubit>().loadCredentials();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthUpdate) {

          if (state.email != null) {
            emailController.text = state.email!;
          }
          if (state.password != null) {
            passwordController.text = state.password!;
          }
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Center(child: const AnimatedTextWidget()),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: theme.appBarTheme.foregroundColor,
                        fontSize: theme.textTheme.labelLarge?.fontSize),
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  onChanged: (value) => context.read<AuthCubit>().updateEmail(value),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  obscureText: context.read<AuthCubit>().obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: theme.appBarTheme.foregroundColor,
                        fontSize: theme.textTheme.labelLarge?.fontSize),
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: IconButton(
                      icon: Icon(context.read<AuthCubit>().obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        context.read<AuthCubit>().toggleObscureText();
                      },
                    ),
                  ),
                  onChanged: (value) => context.read<AuthCubit>().updatePassword(value),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: context.read<AuthCubit>().rememberMe,
                      onChanged: (value) {
                        context.read<AuthCubit>().updateRememberMe(value!);
                      },
                    ),
                    Text('Remember me').tr(),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().saveCredentials();
                    context.read<AuthCubit>().login(
                      emailController.text,
                      passwordController.text,
                      context
                    );
                  },
                  style: theme.elevatedButtonTheme.style,
                  child: Text('Login').tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
