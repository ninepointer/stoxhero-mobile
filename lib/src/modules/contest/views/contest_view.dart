import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../modules.dart';

class ContestView extends GetView<ContestController> {
  const ContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.isLoadingStatus,
        replacement: CommonLoader(),
        child: RefreshIndicator(
          onRefresh: controller.loadData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonCard(
                  onTap: () => Get.toNamed(AppRoutes.pastContest),
                  children: [
                    Row(
                      children: [
                        Text(
                          'View Past Contest',
                          style: AppStyles.tsSecondaryRegular16,
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right_rounded)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                if (controller.premiumContestList.isEmpty && controller.freeContestList.isEmpty)
                  NoDataFound(
                    label: 'No Upcoming Contest!',
                  ),
                if (controller.premiumContestList.isNotEmpty) CustomTile(label: 'Premium Contest\'s'),
                if (controller.premiumContestList.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.premiumContestList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UpComingContestCard(
                        contestDetails: controller.premiumContestList[index],
                      );
                    },
                  ),
                SizedBox(height: 8),
                if (controller.freeContestList.isNotEmpty) CustomTile(label: 'Free Contest\'s'),
                if (controller.freeContestList.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.freeContestList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UpComingContestCard(
                        contestDetails: controller.freeContestList[index],
                      );
                    },
                  ),
                SizedBox(height: 36)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
