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
        : ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
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

class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  void _togglePress() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _togglePress();
      },
      onTapUp: (_) {
        _togglePress();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blue.withOpacity(0.5) : Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Press Me',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
