import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialise le controller
    Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          // 🌊 Background dégradé océanique
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F2027), // Bleu nuit profond
                  Color(0xFF203A43), // Bleu océan
                  Color(0xFF2C5364), // Bleu mer
                ],
              ),
            ),
          ),

          // 🌊 Vagues animées en arrière-plan
          const Positioned.fill(
            child: AnimatedWavesWidget(),
          ),

          // 🏴‍☠️ Contenu principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo bateau avec animation
                ZoomIn(
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.sailing,
                      size: 120,
                      color: Colors.amber,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Titre
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  delay: const Duration(milliseconds: 500),
                  child: const Text(
                    'YON QUIZ',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Sous-titre
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  delay: const Duration(milliseconds: 1000),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      '⚓ Teste tes connaissances One Piece ⚓',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Loading indicator avec animation
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  delay: const Duration(milliseconds: 1500),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.amber,
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Chargement...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🌊 Widget des vagues animées
class AnimatedWavesWidget extends StatefulWidget {
  const AnimatedWavesWidget({super.key});

  @override
  State<AnimatedWavesWidget> createState() => _AnimatedWavesWidgetState();
}

class _AnimatedWavesWidgetState extends State<AnimatedWavesWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();

    // 3 contrôleurs pour 3 vagues à vitesses différentes
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vague 1 (fond)
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                animationValue: _controller1.value,
                color: Colors.white.withOpacity(0.05),
                waveHeight: 40,
              ),
              size: Size.infinite,
            );
          },
        ),

        // Vague 2 (milieu)
        AnimatedBuilder(
          animation: _controller2,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                animationValue: _controller2.value,
                color: Colors.white.withOpacity(0.08),
                waveHeight: 30,
              ),
              size: Size.infinite,
            );
          },
        ),

        // Vague 3 (avant)
        AnimatedBuilder(
          animation: _controller3,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                animationValue: _controller3.value,
                color: Colors.white.withOpacity(0.1),
                waveHeight: 25,
              ),
              size: Size.infinite,
            );
          },
        ),
      ],
    );
  }
}

/// 🎨 Painter pour dessiner les vagues
class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final double waveHeight;

  WavePainter({
    required this.animationValue,
    required this.color,
    required this.waveHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Point de départ
    path.moveTo(0, size.height * 0.7);

    // Créer une vague sinusoïdale
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        size.height * 0.7 +
            waveHeight * 
            (0.5 + 0.5 * _sin((i / size.width * 2 * 3.14159) + (animationValue * 2 * 3.14159))),
      );
    }

    // Fermer le path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  double _sin(double value) {
    // Fonction sinus simplifiée
    return (value % (2 * 3.14159)) / (2 * 3.14159) * 2 - 1;
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
