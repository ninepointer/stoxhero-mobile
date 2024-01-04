// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class PieChartPaidReferrals extends StatefulWidget {
  const PieChartPaidReferrals({super.key});

  @override
  State<StatefulWidget> createState() => PieChartPaidReferralsState();
}

class PieChartPaidReferralsState extends State {
  late AffiliateController controller;
  int touchedIndex = -1;

  @override
  void initState() {
    controller = Get.find<AffiliateController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 30,
                  sections: showingSections(touchedIndex),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.lightGreen,
                text: 'Total Referrals',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.primary,
                text: 'Total Active',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.brandYellow,
                text: 'Total Paid',
                isSquare: true,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            width: 18,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(int touchedIndex) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.lightGreen,
            value: controller
                .affilateOverviewDetails.value.affiliateRefferalCount
                ?.toDouble(),
            title:
                '${controller.affilateOverviewDetails.value.affiliateRefferalCount ?? 0}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.primary,
            value: controller
                .affilateOverviewDetails.value.activeAffiliateRefferalCount
                ?.toDouble(),
            title:
                '${controller.affilateOverviewDetails.value.activeAffiliateRefferalCount ?? 0}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.brandYellow,
            value: controller
                .affilateOverviewDetails.value.paidActiveAffiliateRefferalCount
                ?.toDouble(),
            title:
                '${controller.affilateOverviewDetails.value.paidActiveAffiliateRefferalCount ?? 0}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
