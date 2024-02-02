import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../widgets/share_modal_content.dart';

class CompletedContestCard extends GetView<ContestController> {
  final String? id;
  final CompletedContest? contest;
  final CompletedContestPnl? completedContestPnl;

  const CompletedContestCard({
    Key? key,
    this.id,
    this.contest,
    this.completedContestPnl,
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

  String getContestReward() {
    String price = "";
    int userRank = completedContestPnl?.rank ?? 0;

    for (CompletedRewards reward in contest?.rewards ?? []) {
      if (reward.rankStart == userRank) {
        return reward.prize;
      }
    }

    return price;
  }

  @override
  Widget build(BuildContext context) {
    print('${controller.userDetailsData.sId}');
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
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.0306,
                      right: MediaQuery.of(context).size.width * 0.0306,
                      top: MediaQuery.of(context).size.width * 0.0204),
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
                      child: RewardTableBottomSheet(
                        completedContest: contest,
                        completedContestPnl: completedContestPnl,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.0306),
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
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.0408),
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
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.0204),
          child: Row(
            children: [
              Visibility(
                visible: contest?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.0102,
                      vertical: MediaQuery.of(context).size.width * 0.0051),
                  child: Text(
                    "Nifty",
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              Visibility(
                visible: contest?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.0102,
                      vertical: MediaQuery.of(context).size.width * 0.0051),
                  child: Text(
                    "Bank Nifty",
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              Visibility(
                visible: contest?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.0102,
                      vertical: MediaQuery.of(context).size.width * 0.0051),
                  child: Text(
                    "Finnifty",
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.0102,
                    vertical: MediaQuery.of(context).size.width * 0.0051),
                child: Text(
                  contest?.contestExpiry ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.0051),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.0102)),
            Image.asset(
              AppImages.contestTrophy,
              width: 30,
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                BottomSheetHelper.openBottomSheet(
                  context: context,
                  child: RewardTableBottomSheet(
                    completedContest: contest,
                    completedContestPnl: completedContestPnl,
                  ),
                );
              },
              child: Row(children: [
                // if (contest?.payoutType == 'Reward') ...[
                //   Text(
                //       'Rewards worth ${controller.calculateTotalReward(contest?.rewards)}',
                //       style: Theme.of(context).textTheme.tsMedium12,
                //       textAlign: TextAlign.center),
                // ],
                if (contest?.payoutType == 'Reward') ...[
                  if (contest?.rewardType == "Goodies")
                    Container(
                      width: MediaQuery.of(context).size.width * 0.67,
                      child: Text(
                        "1st rank wins ${controller.calculateTotalReward(contest?.rewards)}!",
                        style: Theme.of(context).textTheme.tsGreyRegular12,
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    Text(
                      'Rewards worth ${controller.calculateTotalReward(contest?.rewards)}',
                      style: Theme.of(context).textTheme.tsGreyRegular12,
                      textAlign: TextAlign.center,
                    )
                ],
                if (contest?.payoutType != 'Reward') ...[
                  if (contest?.payoutCapPercentage != null &&
                      contest?.payoutCapPercentage != 0)
                    Text(
                      '${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L (Upto ${controller.getPaidCapAmount(
                        contest?.entryFee == 0
                            ? completedContestPnl?.portfolioValue ?? 0
                            : contest?.entryFee ?? 0,
                        contest?.payoutCapPercentage ?? 0,
                      )})',
                      style: Theme.of(context).textTheme.tsGreyRegular12,
                    ),
                ]
              ]),
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Started:',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.0051,
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
                    width: MediaQuery.of(context).size.width * 0.0051,
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
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.0102,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.0306),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Virtual Margin',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0051),
                        Text(
                          FormatHelper.formatNumbers(
                            completedContestPnl?.portfolioValue,
                            decimal: 0,
                          ),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Entry Fee',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0051),
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
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.0204),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Net P&L: ',
                              style: AppStyles.tsGreyMedium12,
                            ),
                            // SizedBox(width: 2),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0051,
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
                      ),
                      if (contest?.rewardType != "Goodies")
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rank: ',
                                style: AppStyles.tsGreyMedium12,
                              ),
                              // SizedBox(width: 2),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0051,
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
                        )
                      else
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rank: ',
                                style: AppStyles.tsGreyMedium12,
                              ),
                              // SizedBox(width: 2),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0051,
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
                        ),
                      if (contest?.rewardType != "Goodies")
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'TDS:',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0051,
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
                        ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (contest?.rewardType == "Goodies")
                        // Text(
                        //   'Reward: ${getContestReward()}',
                        //   style: Theme.of(context).textTheme.tsGreyMedium12,
                        // )
                        Row(
                          children: [
                            Text(
                              'Reward:',
                              style: Theme.of(context).textTheme.tsGreyMedium12,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0051,
                            ),
                            Text(
                              getContestReward(),
                              style: Theme.of(context)
                                  .textTheme
                                  .tsBlackMedium12
                                  .copyWith(color: AppColors.success),
                            )
                          ],
                        )
                      else
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Reward:',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0051,
                              ),
                              Text(
                                FormatHelper.formatNumbers(
                                    calculateReward(
                                      contest?.entryFee == 0
                                          ? contest
                                                  ?.portfolio?.portfolioValue ??
                                              0
                                          : contest?.entryFee ?? 0,
                                    ).toString(),
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
                        ),
                      if (contest?.rewardType != "Goodies")
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'HeroCash:',
                                style: AppStyles.tsGreyMedium12,
                              ),
                              // SizedBox(width: 2),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0051,
                              ),
                              Text(
                                "${controller.herocashadd(contest, controller.userDetailsData.sId.toString()).toStringAsFixed(1)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .tsMedium12
                                    .copyWith(color: AppColors.success),
                              ),
                            ],
                          ),
                        ),
                      if (contest?.rewardType != "Goodies")
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Payout:',
                                style: AppStyles.tsGreyMedium12,
                              ),
                              // SizedBox(width: 2),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0051,
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
                                      color:
                                          (completedContestPnl?.payoutAmount ??
                                                      0) >=
                                                  0
                                              ? AppColors.success
                                              : AppColors.danger,
                                    ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),

                  ///hrhrhr
                  ///hrhhr
                  SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
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
                  controller.completedContest(contest);
                  controller.getCompletedContestLeaderboardList(contest?.id);
                  Get.to(() => CompletedContestLeaderboard());
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
                  controller.completedContest(contest);
                  controller.getCompletedContestOrders(contest?.id);
                  Get.to(() => CompletedContestOrdersListView());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
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
                onTap: () async {
                  controller.completedContest(contest);
                  controller.getCompletedContestOrders(contest?.id);

                  CompletedContestPnl? matchingContestPnl;
                  for (var pnl in controller.completedContestPnlList) {
                    if (pnl.contestId == controller.completedContest.value.id) {
                      matchingContestPnl = pnl;
                      break;
                    }
                  }

                  if (matchingContestPnl != null) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: ShareModalContent(
                            completedContestPnl: matchingContestPnl,
                            contest: contest,
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                    color: AppColors.primary.withOpacity(.25),
                  ),
                  child: Text(
                    'Share',
                    style: AppStyles.tsSecondaryMedium12.copyWith(
                      color: AppColors.primary,
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
