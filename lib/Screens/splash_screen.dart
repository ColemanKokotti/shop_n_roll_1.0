import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_n_roll/Themes/default_theme.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

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
    _backgroundAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeOut),
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

    return AnimatedSplashScreen(
      duration: 3500,
      splash: AnimatedBuilder(
        animation: Listenable.merge([_backgroundAnimation, _imageAnimation, _textAnimation]),
        builder: (context, child) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 5000),
                curve: Curves.easeOutQuart,
                left: _backgroundAnimation.value * 0,
                right: (1 - _backgroundAnimation.value) * MediaQuery.of(context).size.width,
                top: 0,
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Center(
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
            ],
          );
        },
      ),
      nextScreen: const AuthScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: theme.scaffoldBackgroundColor,
      splashIconSize: double.infinity,
      centered: true,
      animationDuration: const Duration(milliseconds: 1500),
    );
  }
}
