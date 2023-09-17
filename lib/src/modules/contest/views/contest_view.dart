import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../modules.dart';

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
                Get.find<CollegeContestController>().getCompletedCollegeContestList();
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
                CollegeContestController collegeContestController =
                    Get.find<CollegeContestController>();
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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              SizedBox(height: 8),
              CommonFilledButton(
                label: buttonLabel,
                height: 48,
                onPressed: onPressed,
              ),
            ],
          ),
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
                height: 42,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
