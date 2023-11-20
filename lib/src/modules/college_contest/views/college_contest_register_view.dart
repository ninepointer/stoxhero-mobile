import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CollegeContestRegisterView extends StatelessWidget {
  final LiveCollegeContest? contest;
  const CollegeContestRegisterView({Key? key, this.contest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Contest Register'),
      ),
      body: Column(
        children: [
          CommonCard(
            children: [
              Align(
                child: Text(
                  contest?.contestName ?? '-',
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ),
              SizedBox(height: 8),
              Align(
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.contestTrophy,
                      width: 40,
                    ),
                    Text(
                      'Reward',
                      style: Theme.of(context).textTheme.tsGreyRegular12,
                    ),
                    Text(
                      // '',
                      '${contest?.payoutPercentage} % of the net P&L',
                      style: Theme.of(context).textTheme.tsMedium14,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        // '',
                        FormatHelper.formatDateTimeToIST(
                          contest?.contestStartTime,
                        ),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        // '',
                        FormatHelper.formatDateTimeToIST(
                          contest?.contestEndTime,
                        ),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entry Fee',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      Text(
                        // '',
                        contest?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(
                                contest?.entryFee,
                                decimal: 0,
                              ),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Virtual Currency',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      Text(
                        // '',
                        FormatHelper.formatNumbers(
                          contest?.portfolio?.portfolioValue,
                        ),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              CommonFilledButton(
                backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                label: 'Register',
                onPressed: () {
                  Get.to(
                    () => CollegeContestFormView(contestId: contest?.id),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
