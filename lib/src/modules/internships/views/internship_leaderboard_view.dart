import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipLeaderBoardView extends GetView<InternshipController> {
  const InternshipLeaderBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
        ),
        body: Obx(() => Visibility(
            visible: !controller.isLoadingStatus,
            replacement: CommonLoader(),
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.internshipBatchLeaderboard.length,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var user = controller.internshipBatchLeaderboard[index];
                  return CommonCard(
                    margin: EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
                    children: [
                      Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: Get.isDarkMode
                                ? Theme.of(context).textTheme.tsWhiteRegular14
                                : Theme.of(context).textTheme.tsBlackRegular14,
                          ),
                          SizedBox(width: 16),
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
                              child: user.profileImage == null
                                  ? Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Image.asset(
                                        Get.isDarkMode
                                            ? AppImages.darkAppLogo
                                            : AppImages.lightAppLogo,
                                        fit: BoxFit.cover,
                                      ))
                                  : Image.network(
                                      user.profileImage ?? '',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        user.name ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "ROI:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsGreyRegular12,
                                        ),
                                        Text(
                                          "  ${((user.npnl ?? 0) / (user.portfolioValue ?? 0) * 100).toStringAsFixed(2)}%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsRegular12
                                              .copyWith(
                                                color: user.totalreturn! > 0
                                                    ? AppColors.success
                                                    : AppColors.danger,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Virtual Margin: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsGreyRegular12,
                                        ),
                                        Text(
                                          "${FormatHelper.formatNumbers(user.portfolioValue, decimal: 0)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsRegular12
                                              .copyWith(
                                                  color: AppColors.success),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Net P&L: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsGreyRegular12,
                                        ),
                                        Text(
                                          "${FormatHelper.formatNumbers(user.npnl ?? 0, decimal: 0)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsRegular12
                                              .copyWith(
                                                  color: user.npnl! > 0
                                                      ? AppColors.success
                                                      : AppColors.danger),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ))));
  }
}
