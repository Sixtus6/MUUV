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
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
           
          )
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shimmer Action Button Example'),
        ),
        body: Center(
          child: ShimmerActionButton(
            isLoading: true, // Set to true to display shimmer effect
            onPressed: () {
              // Handle button press
              print('Button pressed!');
            },
            label: 'Press me',
          ),
        ),
      ),
    );
  }
}
