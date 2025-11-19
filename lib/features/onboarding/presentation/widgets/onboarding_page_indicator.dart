import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const OnboardingPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const WormEffect(
        activeDotColor: Colors.amber,
        dotColor: Colors.white24,
        dotHeight: 12,
        dotWidth: 12,
        spacing: 16,
      ),
    );
  }
}
