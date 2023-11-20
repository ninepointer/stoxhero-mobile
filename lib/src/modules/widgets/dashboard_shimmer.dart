import 'package:flutter/material.dart';

import '../../core/core.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({Key? key}) : super(key: key);

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
          LargeCardShimmer(),
          CustomCardShimmer(),
          Row(
            children: [
              Expanded(child: MediumCardShimmer()),
              SizedBox(width: 8),
              Expanded(child: MediumCardShimmer()),
              SizedBox(width: 8),
              Expanded(child: MediumCardShimmer()),
            ],
          ),
          LargeCardShimmer(),
          CustomCardShimmer(),
          LargeCardShimmer(),
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
