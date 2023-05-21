import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
