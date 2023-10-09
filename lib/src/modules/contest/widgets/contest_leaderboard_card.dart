import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/data/data.dart';

class ContestLeaderboardCard extends StatelessWidget {
  final ContestLeaderboard? contestLeaderboard;
  const ContestLeaderboardCard({
    Key? key,
    this.contestLeaderboard,
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
                      style: AppStyles.tsGreyRegular12,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${contestLeaderboard?.traderFirstName!.capitalizeFirst} ${contestLeaderboard?.traderLastName!.capitalizeFirst}',
                      style: Theme.of(context).textTheme.tsMedium14,
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
                      style: AppStyles.tsGreyRegular12,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${FormatHelper.formatNumbers(contestLeaderboard?.strikeRate, showSymbol: false)}%',
                      style: Theme.of(context).textTheme.tsMedium14,
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
                      style: AppStyles.tsGreyRegular12,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${FormatHelper.formatNumbers(
                        contestLeaderboard?.contestParticipated,
                        showSymbol: false,
                        decimal: 0,
                      )}',
                      style: Theme.of(context).textTheme.tsMedium14,
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
                      style: AppStyles.tsGreyRegular12,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${FormatHelper.formatNumbers(
                        contestLeaderboard?.contestWon,
                        showSymbol: false,
                        decimal: 0,
                      )}',
                      style: Theme.of(context).textTheme.tsMedium14,
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
                style: AppStyles.tsGreyRegular12,
              ),
              Text(
                '${FormatHelper.formatNumbers(
                  contestLeaderboard?.totalPayout,
                  decimal: 0,
                )}',
                style: Theme.of(context).textTheme.tsMedium14.copyWith(
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
