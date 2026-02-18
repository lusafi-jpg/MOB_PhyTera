import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF64FFDA); // Neon Green
  static const Color background = Color(0xFF0A192F); // Navy Blue
  static const Color surface = Color(0xFF112240); // Lighter Navy
  static const Color card = Color(0xFF233554); // Card Background

  // Text
  static const Color textPrimary = Color(0xFFCCD6F6); // Lightest Slate
  static const Color textSecondary = Color(0xFF8892B0); // Slate

  // Functional
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF69F0AE);
  static const Color warning = Color(0xFFFFD740);
  static const Color info = Color(0xFF40C4FF);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF1DE9B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
