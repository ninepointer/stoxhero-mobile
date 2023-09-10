import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class ContestLeaderboardCard extends StatelessWidget {
  final String? name;
  final num? strikeRate;
  final num? contestParticipated;
  final num? contestWon;
  final num? totalPayout;
  const ContestLeaderboardCard({
    Key? key,
    this.name,
    this.strikeRate,
    this.contestParticipated,
    this.contestWon,
    this.totalPayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonCard(
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 4,
        ),
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
                      style: AppStyles.tsGreyRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      name ?? '-',
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
                      style: AppStyles.tsGreyRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${FormatHelper.formatNumbers(strikeRate, showSymbol: false)}%',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contests Participated',
                      style: AppStyles.tsGreyRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${FormatHelper.formatNumbers(
                        contestParticipated,
                        showSymbol: false,
                        decimal: 0,
                      )}',
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
                      'Contests Won',
                      style: AppStyles.tsGreyRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${FormatHelper.formatNumbers(
                        contestWon,
                        showSymbol: false,
                        decimal: 0,
                      )}',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cash Earned',
                style: AppStyles.tsGreyRegular14,
              ),
              Text(
                '${FormatHelper.formatNumbers(
                  totalPayout,
                  decimal: 0,
                )}',
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
