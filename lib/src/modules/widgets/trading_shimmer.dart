import 'package:flutter/material.dart';

import '../../core/core.dart';

class TradingShimmer extends StatelessWidget {
  const TradingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8).copyWith(bottom: 100),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: SmallCardShimmer()),
              SizedBox(width: 8),
              Expanded(child: SmallCardShimmer()),
              SizedBox(width: 8),
              Expanded(child: SmallCardShimmer()),
            ],
          ),
          Row(
            children: [
              Expanded(child: SmallCardShimmer()),
              SizedBox(width: 8),
              Expanded(child: SmallCardShimmer()),
            ],
          ),
          CustomCardShimmer(),
          CustomCardShimmer(height: 120),
          CustomCardShimmer(height: 120),
          CustomCardShimmer(),
          CustomCardShimmer(height: 120),
          CustomCardShimmer(height: 120),
          CustomCardShimmer(),
          Row(
            children: [
              Expanded(child: CustomCardShimmer(height: 40)),
              SizedBox(width: 8),
              Expanded(child: CustomCardShimmer(height: 40)),
            ],
          ),
          Row(
            children: [
              Expanded(child: CustomCardShimmer(height: 40)),
              SizedBox(width: 8),
              Expanded(child: CustomCardShimmer(height: 40)),
            ],
          ),
        ],
      ),
    );
  }
}
