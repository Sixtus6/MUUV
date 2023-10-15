import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';



import 'package:flutter/material.dart';

class ShimmerInkButton extends StatelessWidget {
  final bool isLoading;
  final Function onPressed;
  final String label;

  ShimmerInkButton({required this.isLoading, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoading ? ShimmerEffect() : InkButton(onPressed: onPressed, label: label),
        isLoading
            ? Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.transparent,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}


class InkButton extends StatelessWidget {
  final Function onPressed;
  final String label;

  InkButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      splashColor: Colors.blueAccent.withOpacity(0.5),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blue,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}


class ShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade300,
      child: Container(
        color: Colors.grey.shade300,
      ),
    );
  }
}

