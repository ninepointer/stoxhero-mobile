import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ContestTopPerformerCard extends GetView<ContestProfileController> {
  const ContestTopPerformerCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TestZone Leaderboard of the Week\n${[
            '${FormatHelper.formatDateMonth(controller.startOfWeek.toString())} - ${FormatHelper.formatDateMonth(controller.endOfWeek.toString())}'
          ]}',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isWeeklyLoadingStatus,
          child: ListViewShimmer(
            shimmerCard: MediumCardShimmer(),
          ),
          replacement: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: controller.weeklyTopPerformerFullList.length,
            itemBuilder: (BuildContext context, index) {
              var weekly = controller.weeklyTopPerformerFullList[index];
              return CommonCard(
                margin: EdgeInsets.only(left: 12, top: 8, right: 12),
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.grey.withOpacity(.25),
                                ),
                              ),
                              child: ClipOval(
                                child: weekly.profilePicture != null
                                    ? Image.network(
                                        weekly.profilePicture?.url ?? '',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        AppImages.appLogo,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            CommonFilledButton(
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.darkGreen
                                  : AppColors.lightGreen,
                              label: 'View',
                              onPressed: () {
                                controller.getContestProfileData(weekly.trader);
                                Get.to(() => ContestProfileView());
                              },
                              height: 32,
                              width: 120,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(.25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '#${(index + 1).toString()}',
                                style: AppStyles.tsSecondarySemiBold14,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${weekly.firstName!.capitalizeFirst} ${weekly.lastName!.capitalizeFirst}',
                              style: Theme.of(context).textTheme.tsMedium14,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonCardTile(
                              label: 'TestZones Played',
                              value: FormatHelper.formatNumbers(
                                weekly.contests,
                                showSymbol: false,
                                decimal: 0,
                              ),
                              isCenterAlign: true,
                            ),
                            CommonCardTile(
                              label: 'TestZones Won',
                              value: FormatHelper.formatNumbers(
                                weekly.contestsWon,
                                showSymbol: false,
                                decimal: 0,
                              ),
                              isCenterAlign: true,
                            ),
                            CommonCardTile(
                              label: 'Strike Rate',
                              value: '${FormatHelper.formatNumbers(
                                weekly.strikeRate,
                                showSymbol: false,
                                decimal: 0,
                              )}%',
                              isCenterAlign: true,
                            ),
                            CommonCardTile(
                              label: 'Earnings',
                              value: FormatHelper.formatNumbers(
                                weekly.totalPayout,
                                decimal: 0,
                              ),
                              isCenterAlign: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
