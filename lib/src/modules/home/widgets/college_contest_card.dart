import 'package:flutter/material.dart';

import '../../../app/app.dart';

class CollegeContestCard extends GetView<CollegeContestController> {
  final String userId;
  final LiveCollegeContest? contest;
  const CollegeContestCard({
    Key? key,
    this.contest,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(left: 12, right: 12, top: 8),
      padding: EdgeInsets.only(top: 8),
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 2),
                  ),
                  Text(
                    'College Contest',
                    style: Theme.of(context).textTheme.tsPrimaryMedium14,
                  ),
                  Expanded(
                    child: Divider(thickness: 2),
                  ),
                ],
              ),
            ),
            Text(
              '${contest?.contestName} is Live Now!',
              style: Theme.of(context).textTheme.tsSecondaryMedium14,
            ),
            SizedBox(height: 4),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: AppColors.grey.withOpacity(.25),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${contest?.payoutPercentage}% of the Net P&L',
                            style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                  color: AppColors.success,
                                ),
                          ),
                          if (contest?.payoutCapPercentage != null && contest?.payoutCapPercentage != 0)
                            Text(
                              ' (Upto ${controller.getPaidCapAmount(
                                contest?.entryFee == 0
                                    ? contest?.portfolio?.portfolioValue ?? 0
                                    : contest?.entryFee ?? 0,
                                contest?.payoutCapPercentage ?? 0,
                              )})',
                              style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                    color: AppColors.success,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 1,
                              color: AppColors.grey.withOpacity(.25),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: Text(
                              FormatHelper.formatDateTimeOnlyToIST(contest?.contestStartTime),
                              style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                    color: AppColors.secondary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Image.asset(
                        AppImages.contestTrophy,
                        width: 36,
                        height: 36,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 1,
                              color: AppColors.grey.withOpacity(.25),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: Text(
                              FormatHelper.formatDateTimeOnlyToIST(contest?.contestEndTime),
                              style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                    color: AppColors.secondary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            controller.loadData();
            Get.to(() => CollegeContestView());
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(.25),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              'Click to Participate',
              style: AppStyles.tsSecondaryMedium14.copyWith(
                color: AppColors.success.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
