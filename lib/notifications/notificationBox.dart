import 'package:flutter/material.dart';

class NotificationDialogBox extends StatefulWidget {
  const NotificationDialogBox({super.key});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
        
      ),
      backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
            
          ),
        ),
    );
  }
}
