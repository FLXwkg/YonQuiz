import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_item.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🎨 Conteneur visuel avec l'icône
          _buildVisualContainer(),

          const SizedBox(height: 48),

          // 📝 Titre
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 20),

          // 📖 Description
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Conteneur visuel avec effet glassmorphism
  Widget _buildVisualContainer() {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Background effect
            Positioned.fill(
              child: CustomPaint(
                painter: _WavesPainter(),
              ),
            ),

            // Icône principale
            Center(
              child: _buildIcon(),
            ),
          ],
        ),
      ),
    );
  }

  /// Icône selon le type d'écran
  Widget _buildIcon() {
    IconData iconData;
    Color iconColor;

    if (item.imagePath.contains('onboarding1')) {
      iconData = Icons.groups_rounded;
      iconColor = Colors.amber;
    } else if (item.imagePath.contains('onboarding2')) {
      iconData = Icons.quiz_rounded;
      iconColor = Colors.lightBlueAccent;
    } else {
      iconData = Icons.emoji_events_rounded;
      iconColor = Colors.orangeAccent;
    }

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iconColor.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Icon(
        iconData,
        size: 100,
        color: iconColor,
      ),
    );
  }
}

/// Painter pour l'effet vagues en arrière-plan
class _WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.6,
      size.width * 0.5,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
