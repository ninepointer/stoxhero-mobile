import 'package:flutter/material.dart';

import '../../../app/app.dart';

class CompletedCollegeContestCard extends GetView<CollegeContestController> {
  final String? id;
  final CompletedCollegeContest? contest;
  final CompletedContestPnl? completedContestPnl;
  const CompletedCollegeContestCard({
    Key? key,
    this.contest,
    this.completedContestPnl,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    contest?.contestName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              Visibility(
                visible: contest?.featured == true,
                child: Container(
                  padding: EdgeInsets.all(18),
                  foregroundDecoration: CommonTriangleCard(
                    badgeColor: AppColors.success,
                    badgeSize: 62,
                    textSpan: TextSpan(
                      text: 'Featured',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Visibility(
                visible: contest?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Nifty",
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: contest?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Bank Nifty",
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: contest?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Finnifty",
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  contest?.contestExpiry ?? '',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  contest?.contestStatus ?? '',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Started On',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatDateTimeToIST(contest?.contestStartTime),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AppImages.contestTrophy,
                        width: 36,
                      ),
                      Text(
                        'Reward',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      GestureDetector(
                        onTap: () {
                          // if (contest?.payoutType == 'Reward')
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: CollegeRewardTableBottomSheet(
                              completedContest: contest,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // if (contest?.payoutType == 'Reward') ...[
                            //   Text(
                            //     'Rewards worth ${controller.calculateTotalReward(contest?.rewards)},Click to know more.',
                            //     style: Theme.of(context).textTheme.tsMedium12,
                            //     textAlign: TextAlign.center,
                            //   )
                            // ],
                            // if (contest?.payoutType != 'Reward') ...[
                            Text(
                              '${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L',
                              style: Theme.of(context).textTheme.tsMedium12,
                            ),
                            if (contest?.payoutCapPercentage != null && contest?.payoutCapPercentage != 0)
                              Text(
                                ' (Upto ${controller.getPaidCapAmount(
                                  contest?.entryFee == 0
                                      ? completedContestPnl?.portfolioValue ?? 0
                                      : contest?.entryFee ?? 0,
                                  contest?.payoutCapPercentage ?? 0,
                                )}) Click to know more.',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            // ]
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Ended On',
                          style: AppStyles.tsGreyMedium12,
                          textAlign: TextAlign.end,
                          softWrap: false,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatDateTimeToIST(contest?.contestEndTime),
                          style: Theme.of(context).textTheme.tsMedium12,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Entry Fee',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          SizedBox(height: 4),
                          Text(
                            contest?.entryFee == 0
                                ? 'Free'
                                : FormatHelper.formatNumbers(
                                    contest?.entryFee,
                                    decimal: 0,
                                  ),
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Virtual Margin Money',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          SizedBox(height: 4),
                          Text(
                            FormatHelper.formatNumbers(
                              completedContestPnl?.portfolioValue,
                              decimal: 0,
                            ),
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Net P&L (Profit & Loss)',
                              style: AppStyles.tsGreyMedium12,
                            ),
                            SizedBox(height: 4),
                            Text(
                              FormatHelper.formatNumbers(completedContestPnl?.npnl, decimal: 0),
                              style: Theme.of(context).textTheme.tsMedium12.copyWith(
                                    color: (completedContestPnl?.npnl ?? 0) >= 0 ? AppColors.success : AppColors.danger,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Payout',
                              style: AppStyles.tsGreyMedium12,
                            ),
                            SizedBox(height: 4),
                            Text(
                              FormatHelper.formatNumbers(completedContestPnl?.payoutAmount),
                              style: Theme.of(context).textTheme.tsMedium12.copyWith(
                                    color: (completedContestPnl?.payoutAmount ?? 0) >= 0
                                        ? AppColors.success
                                        : AppColors.danger,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.completedCollegeContest(contest);
                  controller.getCompletedContestLeaderboardList(contest?.id);
                  Get.to(() => CollegeCompletedContestLeaderboard());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                    color: AppColors.primary.withOpacity(.25),
                  ),
                  child: Text(
                    'Leadboard',
                    style: AppStyles.tsSecondaryMedium12.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.completedCollegeContest(contest);
                  controller.getContestOrderList(contest?.id);
                  Get.to(() => CompletedCollegeContestOrdersListView());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(.25),
                  ),
                  child: Text(
                    'Order Book',
                    style: AppStyles.tsSecondaryMedium12.copyWith(
                      color: AppColors.secondary.shade600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.completedCollegeContest(contest);
                  controller.downloadFile();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Certificate',
                    style: AppStyles.tsSecondaryMedium12.copyWith(
                      color: AppColors.success,
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
