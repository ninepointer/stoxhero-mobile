import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class ContestLeaderboardCard extends StatelessWidget {
  const ContestLeaderboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonCard(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trader Name',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Anvesh Shetty',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Strike Rate',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '49.35%',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contest Participated',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '77',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Contest Won',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '38',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cash Earned',
                style: Theme.of(context).textTheme.tsRegular14,
              ),
              Text(
                '₹39,295',
                style: Theme.of(context).textTheme.tsMedium16.copyWith(
                      color: AppColors.success,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
