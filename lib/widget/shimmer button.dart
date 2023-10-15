import 'package:flutter/material.dart';
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
        ? Container()
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label,
              //  style: TextStyle(color: Colors.amber),
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

// Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: ElevatedButton(
//               onPressed: onPressed,
//               child: Text(
//                 label,
//                 style: TextStyle(color: Colors.amber),
//               ),
//             ),
//           )