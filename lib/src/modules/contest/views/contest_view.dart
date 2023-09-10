import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import '../../modules.dart';

// class ContestView extends GetView<ContestController> {
//   const ContestView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Visibility(
//         visible: !controller.isLoadingStatus,
//         replacement: CommonLoader(),
//         child: RefreshIndicator(
//           onRefresh: controller.loadData,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CommonCard(
//                   onTap: () => Get.toNamed(AppRoutes.pastContest),
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'View Past Contest',
//                           style: AppStyles.tsSecondaryRegular16,
//                         ),
//                         Spacer(),
//                         Icon(Icons.chevron_right_rounded)
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 if (controller.premiumContestList.isEmpty && controller.freeContestList.isEmpty)
//                   NoDataFound(
//                     label: 'No Upcoming Contest!',
//                   ),
//                 if (controller.premiumContestList.isNotEmpty)
//                   CommonTile(label: 'Premium Contest\'s'),
//                 if (controller.premiumContestList.isNotEmpty)
//                   ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: controller.premiumContestList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return OnGoingContestCard(
//                         contestDetails: controller.premiumContestList[index],
//                       );
//                     },
//                   ),
//                 SizedBox(height: 8),
//                 if (controller.freeContestList.isNotEmpty) CommonTile(label: 'Free Contest\'s'),
//                 if (controller.freeContestList.isNotEmpty)
//                   ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: controller.freeContestList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return OnGoingContestCard(
//                         contestDetails: controller.freeContestList[index],
//                       );
//                     },
//                   ),
//                 SizedBox(height: 36)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ContestView extends StatelessWidget {
  const ContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customCard(
              context: context,
              title: 'Contests',
              image: AppImages.contest,
              buttonLabel: 'Join Contest!',
              onPressed: () {
                Get.find<ContestController>().loadData();
                Get.to(() => ContestListView());
              },
            ),
            SizedBox(height: 12),
            customCard(
              context: context,
              title: 'College Contests',
              image: AppImages.collegeContest,
              buttonLabel: 'Join College Contest!',
              onPressed: () {
                Get.find<ContestController>().loadData();
                Get.to(() => CollegeContestView());
              },
            ),
            SizedBox(height: 12),
            customCard(
              context: context,
              title: 'Contests Leaderboard',
              image: AppImages.contestLeaderboard,
              buttonLabel: 'See Contest Leaderboard!',
              onPressed: () {
                Get.find<ContestController>().loadData();
                Get.to(() => ContestLeaderboardView());
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget customCard({
    required String title,
    required String buttonLabel,
    required String image,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              margin: EdgeInsets.all(16).copyWith(
                bottom: 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.asset(
                image,
                height: 120,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.tsMedium18,
                    // style: AppStyles.tsBlackMedium18,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.tsGreyRegular12,
                    // style: AppStyles.tsBlackMedium18,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16).copyWith(
                top: 0,
              ),
              alignment: Alignment.bottomRight,
              child: CommonFilledButton(
                label: buttonLabel,
                height: 40,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
