import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class LiveContestCard extends GetView<ContestController> {
  final LiveContest? contest;
  final ContestPosition? contestPositionList;
  final ContestCreditData? contestPortfolio;
  const LiveContestCard({
    Key? key,
    this.contest,
    this.contestPositionList,
    this.contestPortfolio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isParticipants = controller.participateUser(
      contest,
      controller.userDetails.value.sId,
    );
    print(isParticipants);
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  contest?.contestName ?? '-',
                  style: AppStyles.tsSecondaryMedium14,
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Nifty',
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
                    'Bank Nifty',
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
                    'FinNifty',
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. of Seats left',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          controller
                              .calculateSeatsLeft(
                                contest?.maxParticipants ?? 0,
                                contest?.participants?.length ?? 0,
                              )
                              .toString(),
                          style: Theme.of(context).textTheme.tsMedium12,
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
                        style: AppStyles.tsGreyMedium12,
                      ),
                      Text(
                        '${contest?.payoutPercentage}% of the Net P&L',
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining Time',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Started',
                          style: Theme.of(context).textTheme.tsMedium12,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Starts',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatDateTimeToIST(contest?.contestStartTime),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Ends',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatDateTimeToIST(contest?.contestEndTime),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entry Fee',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        contest?.entryFee == 0 ? 'Free' : FormatHelper.formatNumbers(contest?.entryFee, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Virtual Margin Money',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                          contest?.portfolio?.portfolioValue,
                          decimal: 0,
                        ),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
                SizedBox(height: 12),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (controller.checkIfLivePurchased(contest) || contest?.entryFee == 0) &&
                          controller.calculateSeatsLeft(
                                  contest?.maxParticipants ?? 0, contest?.participants?.length ?? 0) >
                              0
                      ? () {
                          if (isParticipants) {
                            controller.participate();
                            controller.liveContest(contest);
                            controller.liveLeaderboardList();
                            controller.loadTradingData();
                            Get.to(() => ContestTradingView());
                          } else {
                            SnackbarHelper.showSnackbar(
                                'You can only participate in another contest once your current contest ends!');
                          }
                        }
                      : () {
                          if (controller.calculateSeatsLeft(
                                  contest?.maxParticipants ?? 0, contest?.participants?.length ?? 0) ==
                              0) {
                            SnackbarHelper.showSnackbar('Contest is Full');
                          } else {
                            BottomSheetHelper.openBottomSheet(
                              context: context,
                              child: PurchaseItemBottomSheet(
                                buyItemPrice: contest?.entryFee ?? 0,
                                onSubmit: () {
                                  Get.back();
                                  var data = {
                                    "contestFee": contest?.entryFee,
                                    "contestId": contest?.id,
                                    "contestName": contest?.contestName,
                                  };
                                  controller.purchaseContest(data);
                                },
                              ),
                            );
                          }
                        },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                      color: AppColors.success.withOpacity(.25),
                    ),
                    child: Text(
                      (controller.checkIfLivePurchased(contest) || contest?.entryFee == 0) &&
                              controller.calculateSeatsLeft(
                                      contest?.maxParticipants ?? 0, contest?.participants?.length ?? 0) >
                                  0
                          ? 'Start Trading'
                          : controller.calculateSeatsLeft(
                                      contest?.maxParticipants ?? 0, contest?.participants?.length ?? 0) ==
                                  0
                              ? 'Contest Full'
                              : 'Pay Now',
                      style: AppStyles.tsWhiteMedium12.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.liveContest(contest);
                    controller.getShareContest(false);
                    String url = 'https://stoxhero.com/contest';
                    Clipboard.setData(ClipboardData(text: url));
                    SnackbarHelper.showSnackbar('Share Link with your Friends');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(.25),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Share',
                      style: AppStyles.tsSecondaryMedium12.copyWith(
                        color: AppColors.secondary.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
