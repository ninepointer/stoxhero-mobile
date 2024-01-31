import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class ContestLiveLeaderboardView extends GetView<ContestController> {
  const ContestLiveLeaderboardView({Key? key}) : super(key: key);

  String getContestReward(int index) {
    String price = "";

    for (Rewards reward in controller.liveContest.value.rewards ?? []) {
      if (reward.rankStart == index + 1) {
        return reward.prize;
      }
    }

    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.liveContest.value.contestName ?? 'TestZone Trading'}',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: 8),
            // CommonRankCard(
            //   rank: controller.myRank.toString(),
            //   name:
            //       '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName} ',
            //   netPnL: controller.calculateTotalNetPNL().toString(),
            //   reward: controller.liveContest.value.payoutType != "Reward"
            //       ? controller.calculatePayout().toString()
            //       : controller
            //           .calculateUserReward(controller.myRank.toString())
            //           .toString(),
            // ),
            CommonCard(
              hasBorder: false,
              margin: EdgeInsets.symmetric(horizontal: 8),
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '#${controller.myRank.toString()}',
                        style: AppStyles.tsSecondarySemiBold14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName}'
                              .capitalize ??
                          '',
                      style: Theme.of(context).textTheme.tsMedium14,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Net P&L (Profit & Loss)',
                            style: Theme.of(context).textTheme.tsGreyMedium12,
                          ),
                          Text(
                            FormatHelper.formatNumbers(
                              controller.calculateTotalNetPNL().toString(),
                            ),
                            style:
                                Theme.of(context).textTheme.tsMedium12.copyWith(
                                      color: controller.getValueColor(controller
                                          .calculateTotalNetPNL()
                                          .toString()),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    controller.liveFeatured.value.rewardType != "Goodies" &&
                            controller.liveContest.value.rewardType != "Goodies"
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Reward',
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsGreyMedium12,
                                ),
                                Text(
                                  FormatHelper.formatNumbers(
                                    controller.liveContest.value.payoutType !=
                                            "Reward"
                                        ? controller
                                            .calculatePayout()
                                            .toString()
                                        : controller
                                            .calculateUserReward(
                                                controller.myRank.toString())
                                            .toString(),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsMedium12
                                      .copyWith(
                                        color: controller.getValueColor(
                                          controller.liveContest.value
                                                      .payoutType !=
                                                  "Reward"
                                              ? controller
                                                  .calculatePayout()
                                                  .toString()
                                              : controller
                                                  .calculateUserReward(
                                                      controller.myRank
                                                          .toString())
                                                  .toString(),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                getContestReward(controller.myRank.value - 1) !=
                                        ""
                                    ? Text(
                                        'Reward',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsGreyMedium12,
                                      )
                                    : Container(),
                                Text(
                                    "${getContestReward(controller.myRank.value - 1)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .tsMedium12
                                        .copyWith(color: AppColors.lightGreen))
                              ],
                            ),
                          )
                  ],
                ),
              ],
            ),
            CommonTile(label: 'Leaderboard'),
            Expanded(
              child: Visibility(
                visible: controller.liveLeaderboardList.isNotEmpty,
                replacement: Center(
                  child: Column(
                    children: [
                      CommonLoader(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Loading your leaderboard...",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      )
                    ],
                  ),
                ),
                child: controller.liveLeaderboardList.isNotEmpty
                    ? ListView.separated(
                        itemCount: controller.liveLeaderboardList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          int rank = index + 1;
                          LiveContestLeaderboard user =
                              controller.liveLeaderboardList[index];

                          var reward = controller.liveContest.value.payoutType;

                          return
                              // CommonRankCard(
                              //   rank: rank.toString(),
                              //   name: user.userName ?? '',
                              //   reward: reward == "Reward"
                              //       ? controller
                              //           .calculateUserReward(rank.toString())
                              //           .toString()
                              //       : controller
                              //           .calculateUserPayout(user.npnl ?? 0)
                              //           .toString(),
                              //   netPnL: user.npnl?.toStringAsFixed(0) ?? '0',
                              // );
                              CommonCard(
                            hasBorder: false,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.secondary.withOpacity(.25),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '#${rank.toString()}',
                                      style: AppStyles.tsSecondarySemiBold14,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '${user.userName ?? ''}'.capitalize ?? '',
                                    style:
                                        Theme.of(context).textTheme.tsMedium14,
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Net P&L (Profit & Loss)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsGreyMedium12,
                                        ),
                                        Text(
                                          FormatHelper.formatNumbers(
                                              user.npnl?.toStringAsFixed(0) ??
                                                  '0'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsMedium12
                                              .copyWith(
                                                color: controller.getValueColor(
                                                    user.npnl?.toStringAsFixed(
                                                            0) ??
                                                        '0'),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  controller.liveFeatured.value.rewardType !=
                                              "Goodies" &&
                                          controller.liveContest.value
                                                  .rewardType !=
                                              "Goodies"
                                      ? Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Reward',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .tsGreyMedium12,
                                              ),
                                              Text(
                                                FormatHelper.formatNumbers(
                                                  reward == "Reward"
                                                      ? controller
                                                          .calculateUserReward(
                                                              rank.toString())
                                                          .toString()
                                                      : controller
                                                          .calculateUserPayout(
                                                              user.npnl ?? 0)
                                                          .toString(),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .tsMedium12
                                                    .copyWith(
                                                      color: controller
                                                          .getValueColor(
                                                        reward == "Reward"
                                                            ? controller
                                                                .calculateUserReward(rank
                                                                    .toString())
                                                                .toString()
                                                            : controller
                                                                .calculateUserPayout(
                                                                    user.npnl ??
                                                                        0)
                                                                .toString(),
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            getContestReward(index) != ""
                                                ? Text(
                                                    "Reward",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .tsGreyMedium12,
                                                  )
                                                : Container(),
                                            Text("${getContestReward(index)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .tsMedium12
                                                    .copyWith(
                                                        color: AppColors
                                                            .lightGreen))
                                          ],
                                        )
                                ],
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "Nothing here yet",
                          style: AppStyles.tsBlackRegular14,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
