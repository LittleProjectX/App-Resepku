import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlideZoomTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final customCurve = curve ?? Curves.easeInOutCubic;

    final incomingAnimation = SlideTransition(
      // Bergeser dari kanan (X: 1.0) ke tengah (X: 0.0)
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: customCurve)),
      child: ScaleTransition(
        // Sambil membesar dari 0.85 ke 1.0
        scale: Tween<double>(
          begin: 0.50,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: customCurve)),
        child: FadeTransition(
          // Sambil memudar masuk (Fade In)
          opacity: CurvedAnimation(parent: animation, curve: customCurve),
          child: child,
        ),
      ),
    );

    return SlideTransition(
      // Bergeser dari tengah (X: 0.0) ke kiri luar (X: -1.0)
      position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0))
          .animate(
            CurvedAnimation(parent: secondaryAnimation, curve: customCurve),
          ),
      child: ScaleTransition(
        // Sambil mengecil dari 1.0 ke 0.85
        scale: Tween<double>(begin: 1.0, end: 0.50).animate(
          CurvedAnimation(parent: secondaryAnimation, curve: customCurve),
        ),
        child: FadeTransition(
          // Sambil memudar keluar (Fade Out)
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: secondaryAnimation, curve: customCurve),
          ),
          child: incomingAnimation, // Membungkus animasi Page B
        ),
      ),
    );
  }
}
