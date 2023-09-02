import 'package:flutter/material.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class OnGoingContestCard extends StatelessWidget {
  final UpComingContest? contestDetails;
  const OnGoingContestCard({
    Key? key,
    this.contestDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  contestDetails?.contestName ?? '-',
                  style: AppStyles.tsSecondaryMedium16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Nifty',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Bank Nifty',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Day',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. of Seats left',
                          style: Theme.of(context).textTheme.tsRegular12,
                        ),
                        SizedBox(height: 4),
                        Text(
                          // '23',
                          '${contestDetails?.maxParticipants}',
                          style: Theme.of(context).textTheme.tsMedium14,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AppImages.contestTrophy,
                        width: 40,
                      ),
                      Text(
                        'Reward',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                      Text(
                        '${contestDetails?.payoutPercentage}% of the net P&L',
                        // '0.5% of the net P&L',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(
                        //   'Remaining',
                        //   style: Theme.of(context).textTheme.tsRegular12,
                        // ),
                        // SizedBox(height: 4),
                        // Text(
                        //   "00:00:00",
                        //   // '${contestDetails?.contestEndTime}',
                        //   style: Theme.of(context).textTheme.tsMedium14,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date & Time',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(contestDetails?.contestStartTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Date & Time',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(contestDetails?.contestEndTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entry Fees',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        // 'Free',
                        '₹ ${contestDetails?.entryFee}',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹ ${contestDetails?.portfolio?.portfolioValue}',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                    color: AppColors.success,
                  ),
                  child: Text(
                    'Start Trading',
                    style: AppStyles.tsWhiteMedium14,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                    color: AppColors.secondary,
                  ),
                  child: Text(
                    'Share',
                    style: AppStyles.tsWhiteMedium14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
