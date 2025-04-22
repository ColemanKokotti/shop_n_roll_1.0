import 'package:flutter/material.dart';
import 'package:shop_n_roll/Themes/default_theme.dart';
import 'auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _backgroundController;

  late AnimationController _imageController;
  late Animation<Offset> _imageAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _imageAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.elasticOut),
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.elasticOut),
    );

    _backgroundController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _imageController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      _textController.forward();
    });

    // Controllo autenticazione utente e navigazione manuale
    Future.delayed(const Duration(milliseconds: 2000), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (!mounted) return;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ListScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = defaultTheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _imageAnimation,
              child: Image.asset(
                'assets/images/splash_screen.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _textAnimation,
              child: Text(
                "Shop 'n' Roll",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        theme.primaryColor,
                        theme.secondaryHeaderColor
                      ],
                    ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 200.0, 50.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
