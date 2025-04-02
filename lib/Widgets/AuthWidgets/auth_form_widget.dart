import 'package:flutter/material.dart';
import '../../Themes/default_theme.dart';
import 'AuthLogIn/login_widget.dart';
import 'AuthSignIn/signup_widget.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = defaultTheme;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: theme.appBarTheme.backgroundColor,
            child: TabBar(
              labelColor: theme.appBarTheme.foregroundColor,
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Registration'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                LoginWidget(),
                SingUpWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
