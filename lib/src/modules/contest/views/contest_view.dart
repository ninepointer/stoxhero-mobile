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
                SizedBox(height: 16),
                ListTile(
                  tileColor: AppColors.netural.shade600,
                  title: Text(
                    'Premium Contest\'s',
                    style: AppStyles.tsPrimaryRegular18,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.premiumContestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContestCard(
                      contestDetails: controller.premiumContestList[index],
                    );
                  },
                ),
                SizedBox(height: 16),
                ListTile(
                  tileColor: AppColors.netural.shade600,
                  title: Text(
                    'Free Contest\'s',
                    style: AppStyles.tsPrimaryRegular18,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.freeContestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContestCard(
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
