import 'package:flutter/material.dart';


class ContestPerformanceCard extends StatelessWidget {
  const ContestPerformanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#99 Friday Titans - 17th Nov'),
                Text('17th Nov 2023'),
            ],),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rank: #19'),
              Text('Earnings: Rs. 13'),
              Text('Type: StoxHero'),
            ],
          ),
        ],),
      ),
    );
  }
}