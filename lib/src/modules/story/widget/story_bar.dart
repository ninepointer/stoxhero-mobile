import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class StoryBar extends StatelessWidget {
  List<double> percentWatched = [];
  StoryBar({required this.percentWatched});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[0]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[1]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[2]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[3]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[4]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[5]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[6]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[7]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[8]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[9]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[10]),
          ),
          Expanded(
            child: ProgressBar(percentWatched: percentWatched[11]),
          ),
          // Expanded(
          //   child: ProgressBar(percentWatched: percentWatched[6]),
          // ),
        ],
      ),
    );
  }
}