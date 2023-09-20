import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.text,
    this.color = const Color(0xFF8572e8),
  });
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConfig.secondary,
              fontSize: 15),
        ),
        Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
          margin: EdgeInsets.only(top: SizeConfigs.getPercentageWidth(1)),
          height: SizeConfigs.getPercentageWidth(1),
          width: SizeConfigs.getPercentageWidth(12),
        )
      ],
    );
  }
}
