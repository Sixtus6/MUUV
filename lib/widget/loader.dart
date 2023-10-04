import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Shimmer.fromColors(
          baseColor: ColorConfig.scaffold,
          highlightColor: ColorConfig.white,
          child: Container(
            color: ColorConfig.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(90.0),
          child: Lottie.asset("assets/lottie/loader1.json"),
        )
      ],
    );
  }
}
