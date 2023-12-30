import 'package:flutter/material.dart';
import "package:percent_indicator/linear_percent_indicator.dart";

class ProgressBar extends StatelessWidget {
  double percentWatched = 0;
  ProgressBar({required this.percentWatched});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.symmetric(horizontal: 2),
      lineHeight: 4,
      barRadius: Radius.circular(10),
      percent: percentWatched,
      progressColor: Colors.white,
      backgroundColor: Colors.grey[600],
    );
  }
}
