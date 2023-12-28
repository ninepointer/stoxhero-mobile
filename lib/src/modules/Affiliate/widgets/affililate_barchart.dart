import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class AffiliateChart extends StatefulWidget {
  final String title;
  final List<BarChartGroupData> barGroups;

  const AffiliateChart({
    Key? key,
    required this.title,
    required this.barGroups,
  }) : super(key: key);

  @override
  State<AffiliateChart> createState() => _AnalyticsChartState();
}

class _AnalyticsChartState extends State<AffiliateChart> {
  late AffiliateController controller;

  @override
  void initState() {
    controller = Get.find<AffiliateController>();
    super.initState();
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) return Container();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue.toString(),
        style: AppStyles.tsGreyRegular10,
      ),
    );
  }

  Widget bottomTitless(double value, TitleMeta meta) {
    List<String> dates = ['24 Dec', '25 Dec', '26 Dec', "27 Dec"];
    if (value == meta.max) return Container();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 55,
      child: Text(
        dates.toString(),
        style: AppStyles.tsGreyRegular10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTile(label: widget.title),
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            interval: 1,
                            getTitlesWidget: bottomTitless),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 56,
                            interval: 1,
                            getTitlesWidget: leftTitles),
                      ),
                    ),
                    // barGroups: widget.barGroups,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
