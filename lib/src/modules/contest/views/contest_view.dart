import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../modules.dart';

class ContestView extends StatelessWidget {
  const ContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // CommonFilledButton(
          //     label: 'Form',
          //     onPressed: () {
          //       CollegeContestController controller = Get.find<CollegeContestController>();
          //       controller.loadRegisterData();
          //       Get.to(
          //         () => CollegeContestRegisterView(
          //           contest: controller.liveCollegeContestList[0],
          //         ),
          //       );
          //     }),
          // SizedBox(height: 12),
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
              Get.find<CollegeContestController>().loadData();
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
              ContestController contestController = Get.find<ContestController>();
              CollegeContestController collegeContestController = Get.find<CollegeContestController>();
              contestController.getContestLeaderboardList();
              collegeContestController.getCollegeContestLeaderboardList();
              Get.to(
                () => ContestLeaderboardView(
                  contestController: contestController,
                  collegeContestController: collegeContestController,
                ),
              );
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget customCard({
    required String title,
    required String image,
    required VoidCallback onPressed,
    required BuildContext context,
    required String buttonLabel,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 160,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  image,
                  height: 140,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.tsMedium18,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Start trading, join our virtual Futures & Options contest, and win real cash prizes based on your portfolio's value",
                    style: Theme.of(context).textTheme.tsGreyRegular14,
                  ),
                ],
              ),
              SizedBox(height: 16),
              CommonFilledButton(
                label: buttonLabel,
                height: 48,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
