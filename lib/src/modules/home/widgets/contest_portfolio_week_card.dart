import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class ContestPortfolioWeekCard extends GetView<ContestProfileController> {
  // final int index;
  final WeeklyTopPerformers? performer;
  const ContestPortfolioWeekCard({
    Key? key,
    // required this.index,
    this.performer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      child: CommonCard(
        margin: EdgeInsets.only(top: 8),
        width: 220,
        children: [
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.grey.withOpacity(.25),
                  ),
                ),
                child: ClipOval(
                  child: controller.userDetails.value.profilePhoto == null
                      ? Image.asset(
                          AppImages.appLogo,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          controller.userDetails.value.profilePhoto?.url ?? '',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        // '#${index.toString()}',
                        '',
                        style: AppStyles.tsSecondarySemiBold14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${performer?.firstName} ${performer?.lastName}',
                      style: Theme.of(context).textTheme.tsMedium14,
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
              CommonCardTile(
                label: 'TestZones Played',
                value: ' ${performer?.contests}',
              ),
              CommonCardTile(
                isRightAlign: true,
                label: 'TestZones Won',
                value: ' ${performer?.contestsWon}',
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonCardTile(
                label: 'Strike Rate',
                value: '${FormatHelper.formatNumbers(performer?.strikeRate, showSymbol: false)}',
              ),
              CommonCardTile(
                isRightAlign: true,
                label: 'Earned',
                value: FormatHelper.formatNumbers(performer?.totalPayout),
              ),
            ],
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Text(
                'TestZone Profile',
                style: AppStyles.tsGreyRegular14,
              ),
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
