import 'dart:async';

import 'package:collegence/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 3500),
      () => Navigator.pushReplacement(
        context,
        PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 800),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Card(),
            LottieBuilder.asset('assets/lotties/splash-icon.json', height: 300),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text('Collegence',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
