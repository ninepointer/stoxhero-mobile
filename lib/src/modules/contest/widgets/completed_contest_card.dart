import 'package:flutter/material.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class CompletedContestCard extends StatelessWidget {
  final CompletedContest? contestDetails;
  const CompletedContestCard({
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
          decoration: BoxDecoration(
            color: AppColors.netural.shade900,
          ),
          child: Row(
            children: [
              Text(
                contestDetails?.contestName ?? '-',
                style: AppStyles.tsSecondaryMedium16,
              ),
              // Spacer(),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: AppColors.warning.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Text(
              //     'NIFTY',
              //     style: AppStyles.tsPrimaryMedium14.copyWith(
              //       color: AppColors.warning,
              //     ),
              //   ),
              // ),
              // SizedBox(width: 12),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: AppColors.info.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Text(
              //     'DAY',
              //     style: AppStyles.tsPrimaryMedium14.copyWith(
              //       color: AppColors.info,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date & Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatDateTimeToIST(contestDetails?.contestStartTime),
                        style: AppStyles.tsWhiteMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Date & Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '10 July, 3:20 PM',
                        style: AppStyles.tsWhiteMedium12,
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
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Free',
                        style: AppStyles.tsWhiteRegular14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹ 5,00,000',
                        style: AppStyles.tsWhiteRegular14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.contestTrophy,
                      height: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Reward',
                      style: AppStyles.tsPrimaryMedium14.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '0.5% of the net P&L',
                      style: AppStyles.tsPrimaryMedium14.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
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
                    color: AppColors.secondary.withOpacity(0.1),
                  ),
                  child: Text(
                    'View Orders',
                    style: AppStyles.tsPrimaryMedium14.copyWith(
                      color: AppColors.secondary,
                    ),
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
