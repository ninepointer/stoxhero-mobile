import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class ContestPortfolioWeekCard extends GetView<ContestProfileController> {
  final int index;
  final WeeklyTopPerformers? performer;
  const ContestPortfolioWeekCard({
    Key? key,
    required this.index,
    this.performer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(top: 8, right: 8, left: 12, bottom: 8),
      padding: EdgeInsets.zero,
      width: 190,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      // color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.grey.withOpacity(.25),
                      ),
                    ),
                    child: ClipOval(
                        child: performer?.profilePicture != null
                            ? Image.network(
                                performer?.profilePicture?.url ?? '',
                                fit: BoxFit.cover,
                              )
                            : Padding(
                                padding: EdgeInsets.all(2),
                                child: Image.asset(
                                  Get.isDarkMode
                                      ? AppImages.darkAppLogo
                                      : AppImages.lightAppLogo,
                                  fit: BoxFit.cover,
                                ),
                              )),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(.25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '#${index.toString()}',
                      style: AppStyles.tsSecondarySemiBold14,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${performer?.firstName ?? ''}'.capitalize ?? '',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TestZones Played',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    '${performer?.contests}',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TestZones Won',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    '${performer?.contestsWon}',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Strike Rate',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    '${FormatHelper.formatNumbers(
                      performer?.strikeRate,
                      showSymbol: false,
                      decimal: 0,
                    )}%',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Earned',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    FormatHelper.formatNumbers(
                      performer?.totalPayout,
                      decimal: 0,
                    ),
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            controller.getContestProfileData(performer?.trader);
            Get.to(() => ContestProfileView());
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
              'Zone Profile',
              style: AppStyles.tsGreyMedium14.copyWith(
                color: AppColors.success,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
