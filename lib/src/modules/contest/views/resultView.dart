import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app/app.dart';

class ResultPage extends GetView<ContestController> {
  const ResultPage({
    Key? key,
  }) : super(key: key);

  void showratedailog(num reward) {
    if (reward.isGreaterThan(controller.liveContest.value.entryFee ?? 0)) {
      Get.dialog(Text("hello"));
    }
  }

  num rewardCapAmount(num fees, num cap, num payoutPercentage) {
    num capValue = (fees * cap) / 100;
    num netPNL = controller.resultPageDetails.value.npnl ?? 0;
    num tempReward = netPNL * payoutPercentage / 100;
    num reward = tempReward > capValue ? capValue : tempReward;

    return reward > 0 ? reward : 0;
  }

  @override
  Widget build(BuildContext context) {
    num reward = 0;
    if (controller.resultPageDetails.value.npnl != null) {
      reward = rewardCapAmount(
        (controller.liveFeatured.value.entryFee ??
                    controller.liveContest.value.entryFee) ==
                0
            ? controller.liveFeatured.value.portfolio?.portfolioValue ??
                controller.liveContest.value.portfolio?.portfolioValue ??
                0
            : (controller.liveFeatured.value.entryFee ??
                    controller.liveContest.value.entryFee) ??
                0,
        controller.liveFeatured.value.payoutCapPercentage ??
            controller.liveContest.value.payoutCapPercentage ??
            0,
        controller.liveFeatured.value.payoutPercentage ??
            controller.liveContest.value.payoutPercentage ??
            0,
      );
    }
    ContestController contestController = Get.find<ContestController>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20),
            child: FutureBuilder(
                future: Future.delayed(
                    Duration(seconds: 10)), // Introduce a delay of 10 seconds
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator with text while waiting
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            'Fetching Your Details...',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Obx(() {
                      // if (reward.isGreaterThan(
                      //     controller.liveContest.value.entryFee ?? 0)) {
                      //   WidgetsBinding.instance!.addPostFrameCallback((_) {
                      //     Get.dialog(UpdateAlertDialog(
                      //       label: "Rate now!",
                      //       body: "Enjoying our App? Rate us now! ",
                      //       confrimLabel: "Sure",
                      //     ));
                      //   });
                      // }

                      return Column(children: [
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
                          child: controller.resultPageDetails.value.npnl == null
                              ? Center(
                                  child: Container(
                                      child: Text(
                                          "Loading Your Rank and Reward...")))
                              : CommonCard(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  // color: AppColors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.grey
                                                        .withOpacity(.25),
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: controller
                                                              .userDetails
                                                              .value
                                                              .profilePhoto ==
                                                          null
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: Image.asset(
                                                            Get.isDarkMode
                                                                ? AppImages
                                                                    .darkAppLogo
                                                                : AppImages
                                                                    .lightAppLogo,
                                                            fit: BoxFit.cover,
                                                          ))
                                                      : Image.network(
                                                          controller
                                                                  .userDetails
                                                                  .value
                                                                  .profilePhoto
                                                                  ?.url ??
                                                              '',
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: 200,
                                                  child: Text(
                                                    controller.userDetails.value
                                                                .firstName !=
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                      "${FormatHelper.formatNumbers(controller.resultPageDetails.value.npnl ?? 0)}",
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .tsMedium14
                                                              .copyWith(
                                                                color: (controller.resultPageDetails.value.npnl ??
                                                                            0) >=
                                                                        0
                                                                    ? AppColors
                                                                        .success
                                                                    : AppColors
                                                                        .danger,
                                                              ),
                                                    )
                                                  ],
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.start,
                                                //   children: [
                                                //     Text(
                                                //       "Reward :",
                                                //       style: Get.isDarkMode
                                                //           ? Theme.of(context)
                                                //               .textTheme
                                                //               .tsWhiteMedium16
                                                //           : Theme.of(context)
                                                //               .textTheme
                                                //               .tsBlackMedium16,
                                                //     ),
                                                //     SizedBox(
                                                //       width: 16,
                                                //     ),
                                                //     Text(
                                                //         "${FormatHelper.formatNumbers(reward)}",
                                                //         style: Theme.of(context)
                                                //             .textTheme
                                                //             .tsMedium14
                                                //             .copyWith(
                                                //               color: AppColors
                                                //                   .success,
                                                //             ))
                                                //   ],
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                      "${controller.resultPageDetails.value.rank != null ? controller.resultPageDetails.value.rank ?? 0 : '0'}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .tsBlackMedium14
                                                          .copyWith(
                                                              color: AppColors
                                                                  .success),
                                                      textAlign:
                                                          TextAlign.center,
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
                        controller.resultPageDetails.value.npnl != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Please check your Reward,tds and\nPayout in completed TestZones",
                                      style: AppStyles.tsGreyMedium12,
                                      softWrap: true,
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        ElevatedButton(
                            onPressed: () async {
                              await contestController.loadData();
                              contestController.selectedTabBarIndex(0);
                              Get.off(() => ContestListView());
                            },
                            child: Text(
                              "Check Other TestZones",
                              style: TextStyle(color: AppColors.white),
                            )),
                      ]);
                    });
                  }
                })));
  }
}
