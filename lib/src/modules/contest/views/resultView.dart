import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ResultPage extends GetView<ContestController> {
  const ResultPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContestController contestController = Get.find<ContestController>();

    return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${controller.liveContest.value.contestName} has Ended',
                    style: Get.isDarkMode
                        ? Theme.of(context).textTheme.tsWhiteMedium16
                        : Theme.of(context).textTheme.tsBlackMedium16,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: AppColors.white,
                  shape: BoxShape.rectangle,
                  // border: Border.all(
                  //   color: AppColors.grey.withOpacity(.25),
                  //),
                ),
                child: ClipOval(
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Image.asset(
                          AppImages.contestLeaderboard,
                          fit: BoxFit.cover,
                        ))),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CommonCard(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  // color: AppColors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.grey.withOpacity(.25),
                                  ),
                                ),
                                child: ClipOval(
                                  child: controller
                                              .userDetails.value.profilePhoto ==
                                          null
                                      ? Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Image.asset(
                                            Get.isDarkMode
                                                ? AppImages.darkAppLogo
                                                : AppImages.lightAppLogo,
                                            fit: BoxFit.cover,
                                          ))
                                      : Image.network(
                                          controller.userDetails.value
                                                  .profilePhoto?.url ??
                                              '',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: 200,
                                  child: Text(
                                    controller.userDetails.value.firstName !=
                                            null
                                        ? '${controller.userDetails.value.firstName?.toString().capitalize} ${controller.userDetails.value.lastName?.toString().capitalize}'
                                        : "User",
                                    style: Get.isDarkMode
                                        ? Theme.of(context)
                                            .textTheme
                                            .tsWhiteMedium16
                                        : Theme.of(context)
                                            .textTheme
                                            .tsBlackMedium16,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Net P&L :",
                                        style: Get.isDarkMode
                                            ? Theme.of(context)
                                                .textTheme
                                                .tsWhiteMedium14
                                            : Theme.of(context)
                                                .textTheme
                                                .tsBlackMedium14),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                        "${FormatHelper.formatNumbers(controller.calculateTotalNetPNL())}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium14
                                            .copyWith(
                                              color: (controller
                                                          .calculateTotalNetPNL()) >=
                                                      0
                                                  ? AppColors.success
                                                  : AppColors.danger,
                                            ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reward :",
                                      style: Get.isDarkMode
                                          ? Theme.of(context)
                                              .textTheme
                                              .tsWhiteMedium16
                                          : Theme.of(context)
                                              .textTheme
                                              .tsBlackMedium16,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        "${FormatHelper.formatNumbers(controller.getRewardCapAmount((controller.liveFeatured.value.entryFee ?? controller.liveContest.value.entryFee) == 0 ? controller.liveFeatured.value.portfolio?.portfolioValue ?? controller.liveContest.value.portfolio?.portfolioValue ?? 0 : (controller.liveFeatured.value.entryFee ?? controller.liveContest.value.entryFee) ?? 0, controller.liveFeatured.value.payoutCapPercentage ?? controller.liveContest.value.payoutCapPercentage ?? 0, controller.liveFeatured.value.payoutPercentage ?? controller.liveContest.value.payoutPercentage ?? 0))}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium14
                                            .copyWith(
                                              color: AppColors.success,
                                            ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rank :",
                                      style: Get.isDarkMode
                                          ? Theme.of(context)
                                              .textTheme
                                              .tsWhiteMedium16
                                          : Theme.of(context)
                                              .textTheme
                                              .tsBlackMedium16,
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      "${controller.completedContest.value.rank != null ? controller.completedContest.value.rank : '0'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .tsBlackMedium14
                                          .copyWith(color: AppColors.success),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await contestController.loadData();
                    contestController.selectedTabBarIndex(0);
                    Get.off(() => ContestListView());
                  },
                  child: Text(
                    "Check Other TestZones",
                    style: TextStyle(color: AppColors.white),
                  ))
            ]))));
  }
}
