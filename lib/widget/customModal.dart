import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomModalContainer extends StatelessWidget {
  const CustomModalContainer({
    super.key,
    required this.image,
    required this.address,
    required this.header,
    required,
  });

  final String image;
  final String address;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          // padding: EdgeInsets.all(10),
          child: Image.asset(
            image,
            color: ColorConfig.primary,
          ),
        ),
        SizeConfigs.getPercentageWidth(2).toInt().width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: ColorConfig.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              address,
              style: TextStyle(
                color: ColorConfig.secondary,
                fontSize: 13,
              ),
            ),
          ],
        )
      ],
    );
  }
}
