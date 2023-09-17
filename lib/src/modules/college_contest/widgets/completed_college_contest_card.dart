import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/models/response/completed_college_contest_list_response.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class CompletedCollegeContestCard extends StatelessWidget {
  final CompletedCollegeContest? completedCollegeContest;
  final CompletedContestPnl? completedContestPnl;
  const CompletedCollegeContestCard({
    Key? key,
    this.completedCollegeContest,
    this.completedContestPnl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  completedCollegeContest?.contestName ?? '',
                  style: AppStyles.tsSecondaryMedium16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Visibility(
                visible: completedCollegeContest?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Nifty",
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: completedCollegeContest?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Bank Nifty",
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: completedCollegeContest?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Finnifty",
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  completedCollegeContest?.contestExpiry ?? '',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  completedCollegeContest?.contestStatus ?? '',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 6),
              Image.asset(
                AppImages.contestTrophy,
                width: 40,
              ),
              SizedBox(height: 4),
              Text(
                'Reward',
                style: AppStyles.tsGreyRegular12,
              ),
              Text(
                '${completedCollegeContest?.payoutPercentage} % of the net P&L',
                style: Theme.of(context).textTheme.tsMedium14,
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date & Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(completedCollegeContest?.contestStartTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Date & Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(completedCollegeContest?.contestEndTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entry Fees',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        completedCollegeContest?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(
                                completedCollegeContest?.entryFee,
                                decimal: 0,
                              ),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatNumbers(
                          completedContestPnl?.portfolioValue,
                          decimal: 0,
                        ),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Net P&L',
                          style: AppStyles.tsGreyRegular12,
                        ),
                        SizedBox(height: 4),
                        Text(
                          FormatHelper.formatNumbers(completedContestPnl?.npnl, decimal: 0),
                          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                color: (completedContestPnl?.npnl ?? 0) >= 0
                                    ? AppColors.success
                                    : AppColors.danger,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Payout',
                          style: AppStyles.tsGreyRegular12,
                        ),
                        SizedBox(height: 4),
                        Text(
                          FormatHelper.formatNumbers(completedContestPnl?.payoutAmount),
                          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                color: (completedContestPnl?.payoutAmount ?? 0) >= 0
                                    ? AppColors.success
                                    : AppColors.danger,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.find<CollegeContestController>()
                      .getContestOrderList(completedCollegeContest?.sId);
                  Get.to(() => CompletedCollegeContestOrdersListView());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text('View Orders', style: AppStyles.tsSecondaryMedium14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
