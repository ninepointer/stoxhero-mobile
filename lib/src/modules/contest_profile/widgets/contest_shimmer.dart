import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ContestShimmer extends StatelessWidget {
  const ContestShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8).copyWith(bottom: 100),
      child: Column(
        children: [
          LargeCardShimmer(),
          CustomCardShimmer(),
          MediumCardShimmer(),
          CustomCardShimmer(),
          MediumCardShimmer(),
          MediumCardShimmer(),
          MediumCardShimmer(),
          MediumCardShimmer(),
        ],
      ),
    );
  }
}
