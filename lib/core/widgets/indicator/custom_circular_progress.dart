import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_svg/flutter_svg.dart";

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset("assets/svg/circle_1.svg")
            .animate(
              autoPlay: true,
              onPlay: (controller) => controller.repeat(),
            )
            .rotate(duration: const Duration(milliseconds: 1200)),
        SvgPicture.asset("assets/svg/circle_2.svg")
            .animate(
              autoPlay: true,
              onPlay: (controller) => controller.repeat(),
            )
            .rotate(
              duration: const Duration(milliseconds: 1200),
              begin: 1,
              end: 0,
            ),
        SvgPicture.asset("assets/svg/circle_3.svg")
            .animate(
              autoPlay: true,
              onPlay: (controller) => controller.repeat(),
            )
            .rotate(duration: const Duration(milliseconds: 1200)),
      ],
    );
  }
}
