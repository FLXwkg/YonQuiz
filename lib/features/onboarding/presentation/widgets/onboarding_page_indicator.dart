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
      effect: ExpandingDotsEffect(
        activeDotColor: Colors.amber,
        dotColor: Colors.white.withOpacity(0.3),
        dotHeight: 10,
        dotWidth: 10,
        expansionFactor: 4,
        spacing: 8,
      ),
    );
  }
}
