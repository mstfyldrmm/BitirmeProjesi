import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_attendance_project/screen/giris.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const Giris(),
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lottie/animation-1.json",
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            'E-Yoklama',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? ColorScheme.light().primary
          : ColorScheme.dark().onPrimary,
      duration: 5000,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250,
    );
  }
}
