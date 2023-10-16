import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class InternshipMonthlyAnalyticsChart extends StatefulWidget {
  final String title;
  final List<BarChartGroupData> barGroups;
  const InternshipMonthlyAnalyticsChart({Key? key, required this.title, required this.barGroups})
      : super(key: key);

  @override
  _InternshipMonthlyAnalyticsChartState createState() => _InternshipMonthlyAnalyticsChartState();
}

class _InternshipMonthlyAnalyticsChartState extends State<InternshipMonthlyAnalyticsChart> {
  late InternshipController controller;

  @override
  void initState() {
    controller = Get.find<InternshipController>();
    super.initState();
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) Container();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue.toString(),
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
                          interval: 10,
                          getTitlesWidget: controller.bottomTitlesMonthly,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 56,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    barGroups: widget.barGroups,
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