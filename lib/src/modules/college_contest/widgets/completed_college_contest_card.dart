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

  num calculateReward(fee) {
    num capvalue = (fee * (contest?.payoutCapPercentage ?? 0)) / 100;
    num netpnl = completedContestPnl?.npnl ?? 0;
    num tempReward = netpnl * (contest?.payoutPercentage ?? 0) / 100;
    num reward = tempReward > capvalue ? capvalue : tempReward;
    return reward > 0 ? reward : 0;
  }

  num calculateContestTDS() {
    num tds = controller.readSetting.value.tdsPercentage ?? 0;
    num entryFee = contest?.entryFee ?? 0;
    num portfolioValue = contest?.portfolio?.portfolioValue ?? 0;

    num rewardAmount =
        calculateReward(entryFee == 0 ? portfolioValue : entryFee);

    num winingAmount = rewardAmount - entryFee;
    num tdsAmount = winingAmount * tds / 100;

    return tdsAmount > 0 ? tdsAmount : 0;
  }

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
                  // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: Text(
                    contest?.contestName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              Container(
                height: 15, // Adjust the height as needed
                child: InkWell(
                  onTap: () {
                    BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: CollegeRewardTableBottomSheet(
                        completedContest: contest,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.info,
                      size: 20.0,
                      color: Colors.grey, // Icon color
                    ),
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
              ),
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
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    "Nifty",
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Visibility(
                visible: contest?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  // decoration: BoxDecoration(
                  //   color: AppColors.secondary,
                  //   borderRadius: BorderRadius.circular(100),
                  // ),
                  child: Text(
                    "Bank Nifty",
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Visibility(
                visible: contest?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    "Finnifty",
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  contest?.contestExpiry ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
              SizedBox(width: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  contest?.contestStatus ?? '',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.contestTrophy,
              width: 30,
              height: 20,
            ),

            Text(
              '${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L',
              style: Theme.of(context).textTheme.tsMedium12,
            ),
            if (contest?.payoutCapPercentage != null &&
                contest?.payoutCapPercentage != 0)
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
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Text(
                  'Started:',
                  style: Theme.of(context).textTheme.tsGreyMedium12,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  FormatHelper.formatDateTimeWithoutYearToIST(
                      contest?.contestStartTime),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Rubik'),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Ended:',
                  style: Theme.of(context).textTheme.tsGreyMedium12,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  FormatHelper.formatDateTimeWithoutYearToIST(
                      contest?.contestEndTime),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Rubik'),
                ),
              ],
            ),
          ]),
        ),
        SizedBox(
          height: 4,
        ),
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
                        'Virtual Margin',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                          completedContestPnl?.portfolioValue,
                          decimal: 0,
                        ),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Completed',
                        // style: Theme.of(context).textTheme.tsMedium12,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Entry Fee',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
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
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Net P&L: ',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          // SizedBox(width: 2),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            (completedContestPnl?.npnl ?? 0) > 0
                                ? '+${FormatHelper.formatNumbers(completedContestPnl?.npnl, decimal: 0)}'
                                : '${FormatHelper.formatNumbers(completedContestPnl?.npnl, decimal: 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .tsMedium12
                                .copyWith(
                                  color: (completedContestPnl?.npnl ?? 0) >= 0
                                      ? AppColors.success
                                      : AppColors.danger,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'TDS:',
                            style: Theme.of(context).textTheme.tsGreyMedium12,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            FormatHelper.formatNumbers(
                                calculateContestTDS().toString(),
                                decimal: 2),
                            // Text(
                            //  (completedContestPnl?.payoutAmount??0)>0?((completedContestPnl?.payoutAmount??0)*30/100):,
                            style: Theme.of(context)
                                .textTheme
                                .tsBlackMedium12
                                .copyWith(color: AppColors.success),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Reward:',
                            style: Theme.of(context).textTheme.tsGreyMedium12,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            FormatHelper.formatNumbers(
                                calculateReward(
                                  contest?.entryFee == 0
                                      ? contest?.portfolio?.portfolioValue ?? 0
                                      : contest?.entryFee ?? 0,
                                ).toString(),
                                decimal: 2),
                            style: Theme.of(context)
                                .textTheme
                                .tsBlackMedium12
                                .copyWith(color: AppColors.success),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Rank: ',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          // SizedBox(width: 2),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            completedContestPnl?.rank?.toString() ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .tsMedium12
                                .copyWith(color: AppColors.success),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Payout:',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          // SizedBox(width: 2),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            FormatHelper.formatNumbers(
                              (completedContestPnl?.payoutAmount ?? 0) >= 0
                                  ? completedContestPnl?.payoutAmount
                                  : 0,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .tsMedium12
                                .copyWith(
                                  color: (completedContestPnl?.payoutAmount ??
                                              0) >=
                                          0
                                      ? AppColors.success
                                      : AppColors.danger,
                                ),
                          )
                        ],
                      )
                    ],
                  ),

                  ///hrhrhr
                  ///hrhhr
                  SizedBox(height: 4),
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
                    'Leaderboard',
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
