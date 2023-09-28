import 'package:flutter/material.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:provider/provider.dart';

class Click extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenState = Provider.of<UserScreenProvider>(context);

    return ElevatedButton(
      onPressed: () {
        screenState.setLoading(true);
      },
      child: null,
    );
  }
}
