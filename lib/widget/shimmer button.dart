import 'package:flutter/material.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;

  ShimmerActionButton({
    required this.isLoading,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            padding:
                EdgeInsetsDirectional.all(SizeConfigs.getPercentageWidth(4)),
            decoration: boxDecorationRoundedWithShadow(8,
                backgroundColor: Colors.green),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: onPressed,
              child: Text(
                "Accept",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                label,
                style: TextStyle(color: Colors.amber),
              ),
            ),
          );
  }
}

//  child: Container(
//               height: 50.0,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),


