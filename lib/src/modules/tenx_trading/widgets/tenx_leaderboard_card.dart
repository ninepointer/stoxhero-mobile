import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxLeaderboardCard extends StatelessWidget {
  final int index;
  final TenxLeaderboardList? leaderboard;
  const TenxLeaderboardCard({
    Key? key,
    this.leaderboard,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonCard(
        margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.0306,
        ).copyWith(
          bottom: 0,
          top: MediaQuery.of(context).size.width * 0.0204,
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
                          child: leaderboard?.profilePic == null ||
                                  leaderboard!.profilePic!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Image.asset(
                                    Get.isDarkMode
                                        ? AppImages.darkAppLogo
                                        : AppImages.lightAppLogo,
                                    width: 48,
                                    height: 48,
                                  ),
                                )
                              : Image.network(
                                  leaderboard?.profilePic ?? '',
                                  width: 48,
                                  height: 48,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Image.asset(
                                        Get.isDarkMode
                                            ? AppImages.darkAppLogo
                                            : AppImages.lightAppLogo,
                                        width: 48,
                                        height: 48,
                                      ),
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.0204),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${leaderboard?.firstName!.capitalizeFirst} ${leaderboard?.lastName!.capitalizeFirst}',
                          style: Theme.of(context).textTheme.tsMedium14,
                        ),
                        Text(
                          '${FormatHelper.formatNumbers(
                            leaderboard?.earnings,
                            decimal: 0,
                          )}',
                          style:
                              Theme.of(context).textTheme.tsMedium14.copyWith(
                                    color: AppColors.success,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.0204),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subscriptions Total',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0051),
                        Text(
                          '${FormatHelper.formatNumbers(
                            leaderboard?.subscriptions,
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
                        'Subscriptions Won',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0051),
                      Text(
                        '${FormatHelper.formatNumbers(
                          leaderboard?.subscriptionsWithPayout,
                          showSymbol: false,
                          decimal: 0,
                        )}',
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Strike Rate',
                    style: AppStyles.tsGreyMedium12,
                  ),
                  Text(
                    '${((leaderboard?.strikeRate ?? 0) * 100).toStringAsFixed(0)}%',
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
