import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales One Piece
  static const Color primary = Color(0xFFE63946);        // Rouge pirate
  static const Color secondary = Color(0xFFF1FAEE);      // Blanc cassé
  static const Color accent = Color(0xFFFFD60A);         // Or/Jaune
  static const Color background = Color(0xFF1D3557);     // Bleu marine foncé
  static const Color surface = Color(0xFF457B9D);        // Bleu marine clair
  
  // Texte
  static const Color textPrimary = Color(0xFFF1FAEE);
  static const Color textSecondary = Color(0xFFA8DADC);
  static const Color textDark = Color(0xFF1D3557);
  
  // Status
  static const Color success = Color(0xFF06D6A0);
  static const Color error = Color(0xFFE63946);
  static const Color warning = Color(0xFFFFD60A);
  static const Color info = Color(0xFF457B9D);
  
  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFFE63946),
    Color(0xFFFF6B6B),
  ];
  
  static const List<Color> backgroundGradient = [
    Color(0xFF1D3557),
    Color(0xFF457B9D),
  ];
}