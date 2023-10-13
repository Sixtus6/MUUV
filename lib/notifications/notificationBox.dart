import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';

class NotificationDialogBox extends StatefulWidget {
  const NotificationDialogBox({super.key});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: ColorConfig.white),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset("assets/icon/driver.png"),
          SizedBox(
            height: 10,
          ),
          Text("New Ride Requesr",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red)),

                  SizedBox(  height: 80,)
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: ColorConfig.primary,

                  )

                  Row(
                    children: [
          Image.asset("assets/icon/driver.png", width: 30, height: 30,),
          SizedBox(width: 10,),
Text(
  widget.userRequestDetails!.originAddress!,
  style: TextStyle(color: ColorConfig.secondary),
)                                           
                    ],
                  )
        ]),
      ),
    );
  }
}
