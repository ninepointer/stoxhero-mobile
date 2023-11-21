import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestProfileView extends GetView<ContestProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TestZone Profile',
          style: Theme.of(context).textTheme.tsRegular16,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Visibility(
            visible: controller.isProfileLoadingStatus,
            child: ContestShimmer(),
            replacement: Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
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
                          child: controller.contestProfileData.value
                                      .profilePicture !=
                                  null
                              ? Image.network(
                                  controller.contestProfileData.value
                                          .profilePicture?.url ??
                                      '',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppImages.appLogo,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${controller.contestProfileData.value.firstName ?? ''} ${controller.contestProfileData.value.lastName ?? ''}'
                                .capitalize ??
                            '',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '@${controller.contestProfileData.value.userid}',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Member Since ${FormatHelper.formatDateYear(controller.contestProfileData.value.joiningDate)}',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CommonTile(label: 'Earnings'),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonCardTile(
                          label: 'TestZones Played',
                          value: FormatHelper.formatNumbers(
                            controller.getArenasPlayed(),
                            showSymbol: false,
                            decimal: 0,
                          ),
                          isCenterAlign: true,
                        ),
                        CommonCardTile(
                          label: 'TestZones Won',
                          value: FormatHelper.formatNumbers(
                            controller.getArenasWon(),
                            showSymbol: false,
                            decimal: 0,
                          ),
                          isCenterAlign: true,
                        ),
                        CommonCardTile(
                          label: 'Strike Rate',
                          value: '${FormatHelper.formatNumbers(
                            controller.getStrikeRate(),
                            showSymbol: false,
                            decimal: 0,
                          )}%',
                          isCenterAlign: true,
                        ),
                        CommonCardTile(
                          label: 'Earnings',
                          value: FormatHelper.formatNumbers(
                            controller.getEarnings(),
                            decimal: 0,
                          ),
                          isCenterAlign: true,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CommonTile(label: 'Recent Performance'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero.copyWith(bottom: 100),
                  itemCount: controller.contestProfileDataList.length,
                  itemBuilder: (BuildContext context, index) {
                    return ContestPerformanceCard(
                      contestProfile: controller.contestProfileDataList[index],
                      index: controller.contestProfileDataList.length - index,
                    );
                  },
                  // reverse: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
