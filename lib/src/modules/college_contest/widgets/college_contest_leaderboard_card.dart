import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/data/data.dart';

class CollegeContestLeaderboardCard extends StatelessWidget {
  final int index;
  final CollegeContestLeaderboard? contestLeaderboard;
  const CollegeContestLeaderboardCard({
    Key? key,
    this.contestLeaderboard,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonCard(
        margin: EdgeInsets.all(16).copyWith(
          bottom: 0,
          top: 8,
        ),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withOpacity(.25),
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            contestLeaderboard?.traderProfilePhoto ?? '',
                            width: 48,
                            height: 48,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppImages.appLogo,
                                width: 48,
                                height: 48,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            child: Text(
                              index.toString(),
                              style: AppStyles.tsWhiteMedium10,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${contestLeaderboard?.traderFirstName!.capitalizeFirst} ${contestLeaderboard?.traderLastName!.capitalizeFirst}',
                          style: Theme.of(context).textTheme.tsMedium14,
                        ),
                        Text(
                          '${FormatHelper.formatNumbers(
                            contestLeaderboard?.totalPayout,
                            decimal: 0,
                          )}',
                          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                color: AppColors.success,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contests Participated',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${FormatHelper.formatNumbers(
                            contestLeaderboard?.contestParticipated,
                            showSymbol: false,
                            decimal: 0,
                          )}',
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Contests Won',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '${FormatHelper.formatNumbers(
                          contestLeaderboard?.contestWon,
                          showSymbol: false,
                          decimal: 0,
                        )}',
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Strike Rate',
                    style: AppStyles.tsGreyMedium12,
                  ),
                  Text(
                    '${FormatHelper.formatNumbers(contestLeaderboard?.strikeRate, showSymbol: false)}%',
                    style: Theme.of(context).textTheme.tsMedium12,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
