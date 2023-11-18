import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class ContestPortfolioWeekCard extends GetView<HomeController> {
  const ContestPortfolioWeekCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < 5; i++) ...[
              CommonCard(
                margin: EdgeInsets.only(top: 8, left: 8),
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
                                '#100',
                                style: AppStyles.tsSecondarySemiBold14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Ritik Prajapat',
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
                        value: '7',
                      ),
                      CommonCardTile(
                        isRightAlign: true,
                        label: 'TestZones Won',
                        value: '7',
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonCardTile(
                        label: 'Strike Rate',
                        value: '7',
                      ),
                      CommonCardTile(
                        isRightAlign: true,
                        label: 'Earned',
                        value: '7',
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
            ],
          ],
        ),
      ),
    );
  }
}
